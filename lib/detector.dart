/// Enum representing the detected type of a value or collection.
enum DataType {
  /// Single integer value.
  INT,

  /// Single double value.
  DOUBLE,

  /// Single string value.
  STRING,

  /// Single boolean value.
  BOOL,

  /// A JSON-safe map (`Map<String, dynamic>`) containing only primitives, maps, or iterables.
  JSON,

  /// Any other map or object that is not JSON-safe.
  OBJECT,

  /// Iterable of integers.
  INTS,

  /// Iterable of doubles.
  DOUBLES,

  /// Iterable of strings.
  STRINGS,

  /// Iterable of booleans.
  BOOLS,

  /// Map with arbitrary keys/values that is not JSON-safe.
  MAP,

  /// Iterable of non-JSON maps.
  MAPS,

  /// Iterable of JSON-safe maps.
  JSONS,

  /// Iterable of other objects.
  OBJECTS,

  /// Null value.
  NULL;

  // ---------------------------------------------------------------------------
  // Internal factories
  // ---------------------------------------------------------------------------

  /// Detects the data type of a single string, considering it may be numeric or boolean.
  factory DataType._deep(String value) {
    if (value.isBool) return DataType.BOOL;
    if (value.isInt) return DataType.INT;
    if (value.isDouble) return DataType.DOUBLE;
    return DataType.STRING;
  }

  /// Detects the data type of a list of strings, checking if all are numeric or boolean.
  factory DataType._deeps(Iterable<String> strings) {
    if (strings.isBooleans) return DataType.BOOLS;
    if (strings.isInts) return DataType.INTS;
    if (strings.isDoubles) return DataType.DOUBLES;
    return DataType.OBJECTS;
  }

  /// Detects the [DataType] of an arbitrary value.
  ///
  /// - [deep]: when true, parses strings and string lists into their potential types.
  factory DataType.detect(Object? value, {bool deep = false}) {
    /// Internal recursive JSON checker.
    /// Returns true if the value is a JSON-safe map or iterable.
    bool isJson(Object? value) {
      if (value == null || value is! Map) return false;
      if (value.isEmpty) return true;
      bool isJsonContent(Object? v) {
        if (v == null) return true;
        if (v is num || v is bool || v is String) return true;
        if (v is Map) return isJson(v);
        if (v is Iterable) return v.every(isJsonContent);
        return false;
      }

      return value.entries.every((e) {
        return e.key is String && isJsonContent(e.value);
      });
    }

    // -------------------------------------------------------------------------
    // Detect primitive types
    // -------------------------------------------------------------------------
    if (value == null) return DataType.NULL;
    if (value is int) return DataType.INT;
    if (value is double) return DataType.DOUBLE;
    if (value is String) {
      if (deep) return DataType._deep(value);
      return DataType.STRING;
    }
    if (value is bool) return DataType.BOOL;

    // -------------------------------------------------------------------------
    // Detect maps
    // -------------------------------------------------------------------------
    if (value is Map) {
      return isJson(value) ? DataType.JSON : DataType.MAP;
    }

    // -------------------------------------------------------------------------
    // Detect iterables
    // -------------------------------------------------------------------------
    if (value is Iterable) {
      if (value.isEmpty) return OBJECTS;
      if (value.every((e) => e is int)) return INTS;
      if (value.every((e) => e is double)) return DOUBLES;
      if (value.every((e) => e is bool)) return BOOLS;
      if (value.every((e) => e is String)) {
        if (deep) return DataType._deeps(value as Iterable<String>);
        return STRINGS;
      }
      if (value.every(isJson)) return JSONS;
      if (value.every((e) => e is Map)) return MAPS;
      return OBJECTS;
    }
    return DataType.OBJECT;
  }
}

/// Extension on [String] to provide helper methods for type detection.
extension DataTypeStringHelper on String? {
  /// Normalized string (trimmed and lowercase).
  String get _ => (this ?? "").trim().toLowerCase();

  /// True if the string represents a boolean value (`true`/`false`).
  bool get isBool =>
      RegExp(r'^(true|false)$', caseSensitive: false).hasMatch(_);

  /// True if the string represents an integer value.
  bool get isInt => RegExp(r'^-?\d+$').hasMatch(_);

  /// True if the string represents a double value.
  bool get isDouble => RegExp(r'^-?\d*\.\d+$').hasMatch(_);

  /// True if the string represents a numeric value (int or double).
  bool get isNum => RegExp(r'^-?\d+(\.\d+)?$').hasMatch(_);
}

/// Extension on [Iterable<String>] to provide batch type helpers.
extension DataTypeStringsHelper on Iterable<String>? {
  Iterable<String> get _ => this ?? [];

  /// True if all strings are boolean values.
  bool get isBooleans => _.every((e) => e.isBool);

  /// True if all strings are integer values.
  bool get isInts => _.every((e) => e.isInt);

  /// True if all strings are double values.
  bool get isDoubles => _.every((e) => e.isDouble);

  /// True if all strings are numeric (int or double).
  bool get isNumbers => _.every((e) => e.isNum);

  /// Parsed list of booleans.
  List<bool> get booleans => _.map(bool.tryParse).whereType<bool>().toList();

  /// Parsed list of integers.
  List<int> get ints => _.map(int.tryParse).whereType<int>().toList();

  /// Parsed list of doubles.
  List<double> get doubles =>
      _.map(double.tryParse).whereType<double>().toList();

  /// Parsed list of numeric values (int or double).
  List<num> get numbers => _.map(num.tryParse).whereType<num>().toList();
}

/// Extension on [Object?] to provide convenient type detection methods.
extension DataTypeHelper on Object? {
  /// Returns the [DataType] of this object.
  DataType get dataType => DataType.detect(this);

  /// Returns the [DataType] of this object, optionally parsing strings.
  DataType dataTypeWithOptions({bool parseable = false}) {
    return DataType.detect(this, deep: parseable);
  }
}
