/// ─────────────────────────────────────────────────────────────
/// API RESPONSE WRAPPER
/// Wraps every parsed result in a safe container.
/// Eliminates try/catch in UI and business logic layers.
///
/// Usage:
///   final response = parser.parseObject<UserModel>(data, UserModel.fromJson);
///   if (response.isSuccess) { use response.data }
///   else { show response.error }
/// ─────────────────────────────────────────────────────────────

class ApiResponse<T> {
  /// Parsed data — available when isSuccess is true
  final T? data;

  /// Error message — available when isSuccess is false
  final String? error;

  /// True if parsing succeeded, false otherwise
  final bool isSuccess;

  /// HTTP status code (optional — pass when available)
  final int? statusCode;

  /// Timestamp of when this response was created
  final DateTime createdAt;

  ApiResponse._({
    this.data,
    this.error,
    required this.isSuccess,
    this.statusCode,
  }) : createdAt = DateTime.now();

  /// Creates a successful response with parsed data
  factory ApiResponse.success(T data, {int? statusCode}) => ApiResponse._(
        data: data,
        isSuccess: true,
        statusCode: statusCode,
      );

  /// Creates a failed response with an error message
  factory ApiResponse.error(String error, {int? statusCode}) => ApiResponse._(
        error: error,
        isSuccess: false,
        statusCode: statusCode,
      );

  /// Returns data if success, otherwise runs onError callback
  T? when({
    T Function(T data)? onSuccess,
    T Function(String error)? onError,
  }) {
    if (isSuccess && data != null && onSuccess != null) {
      return onSuccess(data as T);
    }
    if (!isSuccess && error != null && onError != null) {
      return onError(error!);
    }
    return null;
  }

  @override
  String toString() => isSuccess
      ? 'ApiResponse.success(data: $data, statusCode: $statusCode)'
      : 'ApiResponse.error(error: $error, statusCode: $statusCode)';
}