/// ─────────────────────────────────────────────────────────────
/// JSON PARSER — ABSTRACT CONTRACT
/// Defines the complete interface for all JSON operations.
/// Every method returns ApiResponse<T> for safe consumption.
///
/// To use:
///   final JsonParser parser = JsonParserImpl();
///
/// To mock in tests:
///   class MockJsonParser implements JsonParser { ... }
/// ─────────────────────────────────────────────────────────────

import 'api_response.dart';

abstract class JsonParser {

  // ═══════════════════════════════════════════════════════════
  // PARSE METHODS
  // ═══════════════════════════════════════════════════════════

  /// Parses a [Map<String, dynamic>] into a single model [T].
  ///
  /// Example:
  /// ```dart
  /// final response = parser.parseObject<UserModel>(
  ///   jsonMap,
  ///   UserModel.fromJson,
  /// );
  /// ```
  ApiResponse<T> parseObject<T>(
    dynamic data,
    T Function(Map<String, dynamic>) fromJson,
  );

  /// Parses a [List<dynamic>] into [List<T>].
  ///
  /// Example:
  /// ```dart
  /// final response = parser.parseList<UserModel>(
  ///   jsonList,
  ///   UserModel.fromJson,
  /// );
  /// ```
  ApiResponse<List<T>> parseList<T>(
    dynamic data,
    T Function(Map<String, dynamic>) fromJson,
  );

  /// Decodes a raw JSON [String] and parses into a single model [T].
  ///
  /// Example:
  /// ```dart
  /// final response = parser.parseFromString<UserModel>(
  ///   '{"id":1,"name":"Rahim"}',
  ///   UserModel.fromJson,
  /// );
  /// ```
  ApiResponse<T> parseFromString<T>(
    String jsonString,
    T Function(Map<String, dynamic>) fromJson,
  );

  /// Decodes a raw JSON [String] array and parses into [List<T>].
  ///
  /// Example:
  /// ```dart
  /// final response = parser.parseListFromString<UserModel>(
  ///   '[{"id":1},{"id":2}]',
  ///   UserModel.fromJson,
  /// );
  /// ```
  ApiResponse<List<T>> parseListFromString<T>(
    String jsonString,
    T Function(Map<String, dynamic>) fromJson,
  );

  // ═══════════════════════════════════════════════════════════
  // FIELD EXTRACTION METHODS
  // ═══════════════════════════════════════════════════════════

  /// Safely reads a required field [key] from [json] as type [T].
  /// Throws [JsonKeyNotFoundException] if key is missing.
  /// Throws [JsonTypeMismatchException] if type does not match.
  ///
  /// Example:
  /// ```dart
  /// final id = parser.getField<int>(json, 'id', modelName: 'UserModel');
  /// ```
  T getField<T>(
    Map<String, dynamic> json,
    String key, {
    required String modelName,
  });

  /// Safely reads a nullable field [key] from [json] as type [T?].
  /// Returns null if key is missing or value is null — never throws.
  ///
  /// Example:
  /// ```dart
  /// final subtitle = parser.getNullableField<String>(json, 'subtitle');
  /// ```
  T? getNullableField<T>(
    Map<String, dynamic> json,
    String key,
  );

  /// Safely reads a field with a [defaultValue] fallback.
  /// Returns [defaultValue] if key is missing or value is null.
  ///
  /// Example:
  /// ```dart
  /// final count = parser.getFieldWithDefault<int>(json, 'count', defaultValue: 0);
  /// ```
  T getFieldWithDefault<T>(
    Map<String, dynamic> json,
    String key, {
    required T defaultValue,
  });

  /// Reads a nested object from [json] by [key] and parses it as [T].
  ///
  /// Example:
  /// ```dart
  /// final address = parser.getNestedObject<AddressModel>(
  ///   json, 'address', AddressModel.fromJson, modelName: 'UserModel'
  /// );
  /// ```
  T? getNestedObject<T>(
    Map<String, dynamic> json,
    String key,
    T Function(Map<String, dynamic>) fromJson, {
    required String modelName,
  });

  /// Reads a nested list from [json] by [key] and parses it as [List<T>].
  ///
  /// Example:
  /// ```dart
  /// final tags = parser.getNestedList<TagModel>(
  ///   json, 'tags', TagModel.fromJson, modelName: 'PostModel'
  /// );
  /// ```
  List<T> getNestedList<T>(
    Map<String, dynamic> json,
    String key,
    T Function(Map<String, dynamic>) fromJson, {
    required String modelName,
  });

  // ═══════════════════════════════════════════════════════════
  // ENCODE METHODS
  // ═══════════════════════════════════════════════════════════

  /// Encodes a [Map<String, dynamic>] into a JSON string.
  ///
  /// Example:
  /// ```dart
  /// final jsonString = parser.encode(user.toJson());
  /// ```
  String encode(Map<String, dynamic> json);

  /// Encodes any object into a pretty-printed JSON string.
  ///
  /// Example:
  /// ```dart
  /// final pretty = parser.encodePretty(user.toJson());
  /// ```
  String encodePretty(Map<String, dynamic> json);
}