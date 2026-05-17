import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';


import 'package:flutter_tamplate/core/services/cache/storage_service.dart';
import 'package:flutter_tamplate/core/models/response_data.dart';

// ============================================================================
// Constants
// ============================================================================

const Duration _kConnectTimeout = Duration(seconds: 30);
const Duration _kReceiveTimeout = Duration(seconds: 30);
const String _kDefaultFileField = 'profile_picture';

const String _kJsonContentType = 'application/json';
const String _kMultipartContentType = 'multipart/form-data';

const Set<String> _kAuthEndpoints = {
  '/auth/login/',
  '/auth/register/',
  '/auth/logout/',
  '/auth/token/refresh/',
};

// ============================================================================
// Typedefs
// ============================================================================

/// Returns `true` if the refresh succeeded and a new token is now in storage.
typedef TokenRefresher = Future<bool> Function();

/// Notifies the UI layer that the session has expired and the user should
/// be redirected to the login screen.
typedef SessionExpiredCallback = void Function();

// ============================================================================
// NetworkCaller
// ============================================================================

class NetworkCaller {
  NetworkCaller._internal();
  static final NetworkCaller _instance = NetworkCaller._internal();
  factory NetworkCaller() => _instance;

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: _kConnectTimeout,
      receiveTimeout: _kReceiveTimeout,
      contentType: _kJsonContentType,
    ),
  );

  /// Wire this from the auth layer to enable automatic 401 retry.
  TokenRefresher? tokenRefresher;

  /// Wire this from the app shell to react to forced logout.
  SessionExpiredCallback? onSessionExpired;

  // --------------------------------------------------------------------------
  // Public HTTP API
  // --------------------------------------------------------------------------

  Future<ResponseData> getRequest(String endpoint, {String? token}) {
    log('GET    → $endpoint');
    return _execute(
      endpoint,
      () => _dio.get(endpoint, options: _options(token: token)),
    );
  }

  Future<ResponseData> postRequest(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
  }) {
    log('POST   → $endpoint | body: ${jsonEncode(body)}');
    return _execute(
      endpoint,
      () => _dio.post(
        endpoint,
        data: body,
        options: _options(token: token),
      ),
    );
  }

  Future<ResponseData> patchRequest(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
  }) {
    log('PATCH  → $endpoint');
    return _execute(
      endpoint,
      () => _dio.patch(
        endpoint,
        data: body,
        options: _options(token: token),
      ),
    );
  }

  Future<ResponseData> putRequest(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
  }) {
    log('PUT    → $endpoint');
    return _execute(
      endpoint,
      () => _dio.put(
        endpoint,
        data: body,
        options: _options(token: token),
      ),
    );
  }

  Future<ResponseData> deleteRequest(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
  }) {
    log('DELETE → $endpoint');
    return _execute(
      endpoint,
      () => _dio.delete(
        endpoint,
        data: body,
        options: _options(token: token),
      ),
    );
  }

  Future<ResponseData> multipartRequest(
    String endpoint, {
    required String filePath,
    String fieldName = _kDefaultFileField,
    String? token,
  }) {
    log('UPLOAD → $endpoint');
    final mediaType = DioMediaType.parse(_resolveContentType(filePath));

    Future<FormData> buildFormData() async => FormData.fromMap({
      fieldName: await MultipartFile.fromFile(filePath, contentType: mediaType),
    });

    return _execute(
      endpoint,
      () async => _dio.patch(
        endpoint,
        data: await buildFormData(),
        options: _options(token: token, multipart: true),
      ),
      retryRequest: () async => _dio.patch(
        endpoint,
        data: await buildFormData(),
        options: _options(token: token, multipart: true),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Request execution + retry
  // --------------------------------------------------------------------------

  /// Runs [request], and on a 401 attempts a single token refresh + retry.
  /// [retryRequest] should be supplied when the payload cannot be reused
  ///
  /// (e.g. `FormData`), so it can be rebuilt on retry.
  Future<ResponseData> _execute(
    String endpoint,
    Future<Response> Function() request, {
    Future<Response> Function()? retryRequest,
  }) async {
    try {
      return _handleResponse(await request());
    } catch (error) {
      if (await _shouldRetryAfterRefresh(error, endpoint)) {
        log('NetworkCaller: retrying [$endpoint] after token refresh');
        try {
          return _handleResponse(await (retryRequest ?? request)());
        } catch (retryError) {
          return _handleError(retryError);
        }
      }
      return _handleError(error);
    }
  }

  // --------------------------------------------------------------------------
  // Headers
  // --------------------------------------------------------------------------

  Options _options({String? token, bool multipart = false}) => Options(
    headers: _buildHeaders(token: token, multipart: multipart),
  );

  Map<String, dynamic> _buildHeaders({String? token, bool multipart = false}) {
    final activeToken = token ?? StorageService.token;

    final headers = <String, dynamic>{
      'Content-Type': multipart ? _kMultipartContentType : _kJsonContentType,
    };

    if (activeToken != null && activeToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $activeToken';
      log('NetworkCaller: bearer token attached (${activeToken.length} chars)');
    } else {
      log('NetworkCaller: no token — skipping Authorization header');
    }

    return headers;
  }

  // --------------------------------------------------------------------------
  // Response parsing
  // --------------------------------------------------------------------------

  ResponseData _handleResponse(Response response) {
    final status = response.statusCode ?? 0;
    log('Response [$status] ← ${response.realUri}');

    final data = response.data is String
        ? jsonDecode(response.data as String)
        : response.data;

    if (status == 200 || status == 201) {
      return _successResponse(status, data);
    }
    return _errorFromBody(status, data);
  }

  ResponseData _successResponse(int status, dynamic data) {
    if (data is List) {
      return ResponseData(
        isSuccess: true,
        statusCode: status,
        responseData: data,
        errorMessage: '',
      );
    }

    if (data is Map<String, dynamic>) {
      final isSuccess = !data.containsKey('success') || data['success'] == true;
      return ResponseData(
        isSuccess: isSuccess,
        statusCode: status,
        responseData: data,
        errorMessage: isSuccess ? '' : (data['message'] ?? 'Unknown error'),
      );
    }

    return ResponseData(
      isSuccess: true,
      statusCode: status,
      responseData: data,
      errorMessage: '',
    );
  }

  ResponseData _errorFromBody(int status, dynamic data) {
    final message = switch (status) {
      400 =>
        data is Map<String, dynamic>
            ? _joinErrorSources(data['errorSources'])
            : 'Bad Request',
      500 =>
        data is Map<String, dynamic>
            ? (data['message'] ?? 'Internal Server Error')
            : 'Internal Server Error',
      _ =>
        data is Map<String, dynamic>
            ? (data['message'] ?? 'Unexpected error occurred')
            : 'Unexpected error occurred',
    };

    return ResponseData(
      isSuccess: false,
      statusCode: status,
      responseData: data,
      errorMessage: message,
    );
  }

  String _joinErrorSources(dynamic errorSources) {
    if (errorSources is! List) return 'Validation error';
    return errorSources
        .map((e) => (e as Map<String, dynamic>)['message'] ?? 'Unknown error')
        .join(', ');
  }

  // --------------------------------------------------------------------------
  // Token refresh
  // --------------------------------------------------------------------------

  /// Returns `true` only when the request hit a 401, the endpoint is
  /// retry-eligible, and a refresh callback succeeded.
  Future<bool> _shouldRetryAfterRefresh(dynamic error, String endpoint) async {
    if (error is! DioException) return false;
    if (error.response?.statusCode != 401) return false;
    if (_isAuthEndpoint(endpoint)) return false;

    final refresh = tokenRefresher;
    if (refresh == null) {
      log('NetworkCaller: 401 on [$endpoint] — no tokenRefresher set');
      await _forceLogout();
      return false;
    }

    log('NetworkCaller: 401 on [$endpoint] — attempting refresh');
    try {
      if (await refresh()) {
        log('NetworkCaller: token refresh succeeded');
        return true;
      }
      log('NetworkCaller: token refresh failed');
    } catch (e) {
      log('NetworkCaller: exception during token refresh — $e');
    }

    await _forceLogout();
    return false;
  }

  Future<void> _forceLogout() async {
    await StorageService.logoutUser();
    onSessionExpired?.call();
  }

  bool _isAuthEndpoint(String endpoint) =>
      _kAuthEndpoints.any(endpoint.contains);

  // --------------------------------------------------------------------------
  // Error mapping
  // --------------------------------------------------------------------------

  ResponseData _handleError(dynamic error) {
    log('NetworkCaller error: $error');

    if (error is! DioException) {
      return _errorResponse(500, 'Unknown error occurred.');
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return _errorResponse(408, 'Request timed out. Please try again.');

      case DioExceptionType.connectionError:
        return _errorResponse(
          500,
          'No internet connection. Please check your network.',
        );

      case DioExceptionType.badResponse:
        return _badResponseError(error);

      case DioExceptionType.cancel:
        return _errorResponse(499, 'Request was cancelled.');

      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return _errorResponse(500, 'An unexpected error occurred.');
    }
  }

  ResponseData _badResponseError(DioException error) {
    final status = error.response?.statusCode ?? 500;
    final body = error.response?.data;

    final message = switch (status) {
      401 => 'Session expired. Please log in again.',
      403 => 'Access denied. You lack permission for this resource.',
      _ =>
        (body is Map ? (body['message'] ?? body['detail']) : null) ??
            'Server returned an error.',
    };

    log('NetworkCaller: BadResponse $status — $message');
    log('NetworkCaller: response body: $body');

    return ResponseData(
      isSuccess: false,
      statusCode: status,
      responseData: body ?? '',
      errorMessage: message,
    );
  }

  ResponseData _errorResponse(int statusCode, String message) => ResponseData(
    isSuccess: false,
    statusCode: statusCode,
    responseData: '',
    errorMessage: message,
  );

  // --------------------------------------------------------------------------
  // File helpers
  // --------------------------------------------------------------------------

  String _resolveContentType(String filePath) {
    final ext = filePath.contains('.')
        ? filePath.split('.').last.toLowerCase()
        : '';

    return switch (ext) {
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      'gif' => 'image/gif',
      _ => throw ArgumentError('Unsupported image format: .$ext'),
    };
  }
}
