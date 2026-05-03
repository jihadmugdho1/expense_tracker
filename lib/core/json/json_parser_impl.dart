/// ─────────────────────────────────────────────────────────────
/// JSON PARSER IMPLEMENTATION
/// Full implementation of JsonParser contract.
/// Handles all edge cases, type conversions, and nested objects.
/// ─────────────────────────────────────────────────────────────

import 'dart:convert';
import 'api_response.dart';
import 'json_exception.dart';
import 'json_parser.dart';
import 'json_type_converter.dart';

class JsonParserImpl implements JsonParser {

  // ═══════════════════════════════════════════════════════════
  // PARSE METHODS
  // ═══════════════════════════════════════════════════════════

  /// Parse single object [SINGLE_OBJECT]
  @override
  ApiResponse<T> parseObject<T>(
    dynamic data,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    try {
      if (data == null) {
        return ApiResponse.error('Cannot parse null as $T');
      }
      if (data is! Map<String, dynamic>) {
        return ApiResponse.error(
          'Expected Map<String, dynamic> but got ${data.runtimeType} for $T',
        );
      }
      final result = fromJson(data);
      return ApiResponse.success(result);
    } on JsonKeyNotFoundException catch (e) {
      return ApiResponse.error(e.toString());
    } on JsonTypeMismatchException catch (e) {
      return ApiResponse.error(e.toString());
    } on JsonParseException catch (e) {
      return ApiResponse.error(e.toString());
    } catch (e) {
      return ApiResponse.error('Unexpected error parsing $T → $e');
    }
  }

  /// Parse list of objects [LIST_OF_OBJECTS]
  @override
  ApiResponse<List<T>> parseList<T>(
    dynamic data,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    try {
      if (data == null) {
        return ApiResponse.success(<T>[]);  // null list → empty list
      }
      if (data is! List) {
        return ApiResponse.error(
          'Expected List but got ${data.runtimeType} for List<$T>',
        );
      }
      final result = <T>[];
      for (int i = 0; i < data.length; i++) {
        final item = data[i];
        if (item is! Map<String, dynamic>) {
          return ApiResponse.error(
            'Item at index $i is not a Map — got ${item.runtimeType}',
          );
        }
        result.add(fromJson(item));
      }
      return ApiResponse.success(result);
    } on JsonKeyNotFoundException catch (e) {
      return ApiResponse.error(e.toString());
    } on JsonTypeMismatchException catch (e) {
      return ApiResponse.error(e.toString());
    } catch (e) {
      return ApiResponse.error('Unexpected error parsing List<$T> → $e');
    }
  }

  /// Parse from raw JSON string → single object [JSON_STRING_TO_SINGLE_OBJECT]
  @override
  ApiResponse<T> parseFromString<T>(
    String jsonString,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    try {
      if (jsonString.isEmpty) {
        return ApiResponse.error('JSON string is empty for $T');
      }
      final decoded = jsonDecode(jsonString);
      return parseObject<T>(decoded, fromJson);
    } on FormatException catch (e) {
      return ApiResponse.error('Invalid JSON string for $T → $e');
    } catch (e) {
      return ApiResponse.error('Failed to decode string for $T → $e');
    }
  }

  /// Parse from raw JSON string → list [JSON_STRING_TO_LIST]
  @override
  ApiResponse<List<T>> parseListFromString<T>(
    String jsonString,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    try {
      if (jsonString.isEmpty) {
        return ApiResponse.success(<T>[]);
      }
      final decoded = jsonDecode(jsonString);
      return parseList<T>(decoded, fromJson);
    } on FormatException catch (e) {
      return ApiResponse.error('Invalid JSON string for List<$T> → $e');
    } catch (e) {
      return ApiResponse.error('Failed to decode list string for $T → $e');
    }
  }

  // ═══════════════════════════════════════════════════════════
  // FIELD EXTRACTION METHODS
  // ═══════════════════════════════════════════════════════════

  /// Required field — throws if missing [REQUIRED_FIELD]
  @override
  T getField<T>(
    Map<String, dynamic> json,
    String key, {
    required String modelName,
  }) {
    if (!json.containsKey(key)) {
      throw JsonKeyNotFoundException(key: key, model: modelName);
    }

    final value = json[key];

    if (value == null) {
      if (null is T) return null as T;
      throw JsonKeyNotFoundException(key: key, model: modelName);
    }

    return JsonTypeConverter.convert<T>(value, key: key);
  }

  /// Nullable field — returns null if missing, never throws [NULLABLE_FIELD]
  @override
  T? getNullableField<T>(
    Map<String, dynamic> json,
    String key,
  ) {
    if (!json.containsKey(key)) return null;
    final value = json[key];
    if (value == null) return null;
    try {
      return JsonTypeConverter.convert<T>(value, key: key);
    } catch (_) {
      return null;   // swallow error — return null for nullable fields
    }
  }

  /// Field with default value — never throws [FIELD_WITH_DEFAULT]
  @override
  T getFieldWithDefault<T>(
    Map<String, dynamic> json,
    String key, {
    required T defaultValue,
  }) {
    if (!json.containsKey(key)) return defaultValue;
    final value = json[key];
    if (value == null) return defaultValue;
    try {
      return JsonTypeConverter.convert<T>(value, key: key);
    } catch (_) {
      return defaultValue;   // conversion failed → use default
    }
  }

  /// Nested single object [NESTED_SINGLE_OBJECT]
  @override
  T? getNestedObject<T>(
    Map<String, dynamic> json,
    String key,
    T Function(Map<String, dynamic>) fromJson, {
    required String modelName,
  }) {
    if (!json.containsKey(key) || json[key] == null) return null;
    final nested = json[key];
    if (nested is! Map<String, dynamic>) {
      throw JsonTypeMismatchException(
        key: key,
        expected: 'Map<String, dynamic>',
        actual: nested.runtimeType.toString(),
      );
    }
    return fromJson(nested);
  }

  /// Nested list of objects [NESTED_LIST_OF_OBJECTS]
  @override
  List<T> getNestedList<T>(
    Map<String, dynamic> json,
    String key,
    T Function(Map<String, dynamic>) fromJson, {
    required String modelName,
  }) {
    if (!json.containsKey(key) || json[key] == null) return <T>[];
    final list = json[key];
    if (list is! List) {
      throw JsonTypeMismatchException(
        key: key,
        expected: 'List',
        actual: list.runtimeType.toString(),
      );
    }
    return list
        .map((item) => fromJson(item as Map<String, dynamic>))
        .toList();
  }

  // ═══════════════════════════════════════════════════════════
  // ENCODE METHODS
  // ═══════════════════════════════════════════════════════════

  /// Encode to compact JSON string [ENCODE_TO_COMPACT_JSON]
  @override
  String encode(Map<String, dynamic> json) {
    try {
      return jsonEncode(json);
    } catch (e) {
      throw JsonParseException('Failed to encode to JSON → $e');
    }
  }

  /// Encode to pretty printed JSON string [ENCODE_TO_PRETTY_JSON]
  @override
  String encodePretty(Map<String, dynamic> json) {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(json);
    } catch (e) {
      throw JsonParseException('Failed to pretty encode JSON → $e');
    }
  }
}