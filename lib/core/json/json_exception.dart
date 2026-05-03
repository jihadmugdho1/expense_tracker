/// ─────────────────────────────────────────────────────────────
/// JSON EXCEPTIONS
/// Custom exception classes for precise error identification.
///
/// Usage:
///   throw JsonParseException('Failed', rawData: json);
///   throw JsonKeyNotFoundException(key: 'id', model: 'UserModel');
///   throw JsonTypeMismatchException(key: 'age', expected: 'int', actual: 'String');
/// ─────────────────────────────────────────────────────────────

/// Thrown when JSON parsing fails at any level
class JsonParseException implements Exception {
  /// Human readable error message
  final String message;

  /// The raw data that caused the failure (optional)
  final dynamic rawData;

  const JsonParseException(this.message, {this.rawData});

  @override
  String toString() => 'JsonParseException: $message'
      '${rawData != null ? ' | raw: $rawData' : ''}';
}

/// Thrown when a required key is missing from the JSON map
class JsonKeyNotFoundException implements Exception {
  /// The key that was not found
  final String key;

  /// The model class name where the key was expected
  final String model;

  const JsonKeyNotFoundException({
    required this.key,
    required this.model,
  });

  @override
  String toString() =>
      'JsonKeyNotFoundException: key "$key" not found in $model';
}

/// Thrown when a JSON value has an unexpected type
class JsonTypeMismatchException implements Exception {
  /// The key whose value had the wrong type
  final String key;

  /// The type that was expected
  final String expected;

  /// The type that was actually found
  final String actual;

  const JsonTypeMismatchException({
    required this.key,
    required this.expected,
    required this.actual,
  });

  @override
  String toString() =>
      'JsonTypeMismatchException: '
      'key "$key" expected $expected but got $actual';
}

/// Thrown when a JSON string cannot be decoded
class JsonDecodeException implements Exception {
  /// The raw string that failed to decode
  final String rawString;

  /// The underlying error
  final dynamic cause;

  const JsonDecodeException({
    required this.rawString,
    this.cause,
  });

  @override
  String toString() =>
      'JsonDecodeException: Failed to decode string → $cause';
}