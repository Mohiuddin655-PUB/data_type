## 1.0.0

* Detect primitive types: int, double, String, bool, null.
* Detect iterables: List<int>, List<double>, List<String>, List<bool>.
* Detect maps and JSON:
    - JSON-safe maps (Map<String, dynamic> with only primitives, maps, or iterables).
    - Nested JSON detection.
    - Differentiates JSON, MAP, and other OBJECT types.
* Deep string parsing to detect numbers and booleans.
* Extensions:
    - String? → .isBool, .isInt, .isDouble, .isNum
    - Iterable<String>? → .isBooleans, .isInts, .isDoubles, .booleans, .ints, .doubles
    - Object? → .dataType, .dataTypeWithOptions(parseable: true)
* Support for lists of JSON maps (JSONS) and non-JSON maps (MAPS).
* Handles empty lists and maps correctly.
* Fully documented with DartDoc.

