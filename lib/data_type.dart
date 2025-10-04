enum DataType {
  INT,
  DOUBLE,
  STRING,
  BOOL,
  JSON,
  OBJECT,
  INTS,
  DOUBLES,
  STRINGS,
  BOOLS,
  MAP,
  MAPS,
  JSONS,
  OBJECTS,
  NULL;

  // ---------------------------------------------------------------------------
  // Internal factories
  // ---------------------------------------------------------------------------

  factory DataType._deep(String value) {
    if (value.isBool) return DataType.BOOL;
    if (value.isInt) return DataType.INT;
    if (value.isDouble) return DataType.DOUBLE;
    return DataType.STRING;
  }

  factory DataType._deeps(Iterable<String> strings) {
    if (strings.isBooleans) return DataType.BOOLS;
    if (strings.isInts) return DataType.INTS;
    if (strings.isDoubles) return DataType.DOUBLES;
    return DataType.OBJECTS;
  }

  factory DataType.detect(Object? value, {bool deep = false}) {
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

    if (value == null) return DataType.NULL;
    if (value is int) return DataType.INT;
    if (value is double) return DataType.DOUBLE;
    if (value is String) {
      if (deep) return DataType._deep(value);
      return DataType.STRING;
    }
    if (value is bool) return DataType.BOOL;
    if (value is Map) {
      return isJson(value) ? DataType.JSON : DataType.MAP;
    }
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

extension DataTypeStringHelper on String? {
  String get _ => (this ?? "").trim().toLowerCase();

  bool get isBool =>
      RegExp(r'^(true|false)$', caseSensitive: false).hasMatch(_);

  bool get isInt => RegExp(r'^-?\d+$').hasMatch(_);

  bool get isDouble => RegExp(r'^-?\d*\.\d+$').hasMatch(_);

  bool get isNum => RegExp(r'^-?\d+(\.\d+)?$').hasMatch(_);
}

extension DataTypeStringsHelper on Iterable<String>? {
  Iterable<String> get _ => this ?? [];

  bool get isBooleans => _.every((e) => e.isBool);

  bool get isInts => _.every((e) => e.isInt);

  bool get isDoubles => _.every((e) => e.isDouble);

  bool get isNumbers => _.every((e) => e.isNum);

  List<bool> get booleans => _.map(bool.tryParse).whereType<bool>().toList();

  List<int> get ints => _.map(int.tryParse).whereType<int>().toList();

  List<double> get doubles =>
      _.map(double.tryParse).whereType<double>().toList();

  List<num> get numbers => _.map(num.tryParse).whereType<num>().toList();
}

extension DataTypeHelper on Object? {
  DataType get dataType => DataType.detect(this);

  DataType dataTypeWithOptions({bool parseable = false}) {
    return DataType.detect(this, deep: parseable);
  }
}
