## DataType Detector

A lightweight Dart package to automatically detect the type of any value, map, or list—including
nested JSON, primitives, and iterables. Supports deep parsing of strings into numbers or booleans
and provides convenient extensions for strings, string lists, and objects.

## Features:

- Detect Dart primitive types: int, double, bool, String, and null.
- Detect iterables: List<int>, List<double>, List<bool>, List<String>.
- Detect JSON-safe maps and nested JSON structures.
- Differentiates between JSON maps and arbitrary objects.
- Deep parsing: convert strings to numbers or booleans automatically.
- Provides easy-to-use extensions for String, Iterable<String>, and Object?.

## Installation:

Add this to your pubspec.yaml:
dependencies:

```base
data_type_detector: ^1.0.0
```

or,

```shell
flutter pub add data_type_detector
```

Then run:

```shell
flutter pub get
```

## Usage:

Detect primitive types:
print(123.dataType); // DataType.INT
print(3.14.dataType); // DataType.DOUBLE
print("true".dataType); // DataType.STRING
print(true.dataType); // DataType.BOOL
print(null.dataType); // DataType.NULL

Deep string parsing:
print("123".dataTypeWithOptions(parseable: true)); // DataType.INT
print("3.14".dataTypeWithOptions(parseable: true)); // DataType.DOUBLE
print("true".dataTypeWithOptions(parseable: true)); // DataType.BOOL

Detect iterables:
print([1, 2, 3].dataType); // DataType.INTS
print([true, false].dataType); // DataType.BOOLS
print(["1", "2"].dataTypeWithOptions(parseable: true)); // DataType.INTS
print(["a", "b"].dataType); // DataType.STRINGS

Detect maps and JSON:
print({"a": 1, "b": "x"}.dataType); // DataType.JSON
print({"nested": {"x": 1}}.dataType); // DataType.JSON
print({"obj": Object()}.dataType); // DataType.MAP
print([{"a": 1}, {"b": 2}].dataType); // DataType.JSONS

Detect objects:
print(Object().dataType); // DataType.OBJECT
print([Object(), Object()].dataType); // DataType.OBJECTS

## Examples:
```dart
import 'package:data_type_detector/data_type_detector.dart';

void main() {
  // -------------------------
  // Primitive values
  // -------------------------
  int intValue = 42;
  double doubleValue = 3.14;
  String stringValue = "hello";
  bool boolValue = true;
  String boolString = "true";
  String intString = "123";

  print(intValue.dataType); // DataType.INT
  print(doubleValue.dataType); // DataType.DOUBLE
  print(stringValue.dataType); // DataType.STRING
  print(boolValue.dataType); // DataType.BOOL
  print(boolString.dataTypeWithOptions(parseable: true)); // DataType.BOOL
  print(intString.dataTypeWithOptions(parseable: true)); // DataType.INT

  // -------------------------
  // Lists / Iterables
  // -------------------------
  List<int> intList = [1, 2, 3];
  List<double> doubleList = [1.1, 2.2, 3.3];
  List<bool> boolList = [true, false, true];
  List<String> stringList = ["1", "2", "3"];
  List<String> stringList2 = ["a", "b", "c"];

  print(intList.dataType); // DataType.INTS
  print(doubleList.dataType); // DataType.DOUBLES
  print(boolList.dataType); // DataType.BOOLS
  print(stringList.dataTypeWithOptions(parseable: true)); // DataType.INTS
  print(stringList2.dataType); // DataType.STRINGS

  // -------------------------
  // Maps / JSON
  // -------------------------
  Map<String, dynamic> jsonMap = {"a": 1, "b": "x", "c": true};
  Map<String, dynamic> nestedJson = {"nested": {"x": 1, "y": [1, 2, 3]}};
  Map<String, Object> normalMap = {"obj": Object()};

  print(jsonMap.dataType); // DataType.JSON
  print(nestedJson.dataType); // DataType.JSON
  print(normalMap.dataType); // DataType.MAP

  // Lists of maps
  List<Map<String, dynamic>> jsonList = [{"a": 1}, {"b": 2}];
  List<Map<String, Object>> mapList = [{"obj": Object()}, {"obj": Object()}];

  print(jsonList.dataType); // DataType.JSONS
  print(mapList.dataType); // DataType.MAPS

  // -------------------------
  // Mixed / Objects
  // -------------------------
  Object obj = Object();
  List<Object> objList = [Object(), Object()];

  print(obj.dataType); // DataType.OBJECT
  print(objList.dataType); // DataType.OBJECTS

  // -------------------------
  // Nested JSON with arrays
  // -------------------------
  Map<String, dynamic> complexJson = {
    "users": [
      {"name": "Alice", "age": 30},
      {"name": "Bob", "age": 25}
    ],
    "active": true
  };

  print(complexJson.dataType); // DataType.JSON
}
```
## Extensions:

- String?
  .isBool, .isInt, .isDouble, .isNum
- Iterable<String>?
  .isBooleans, .isInts, .isDoubles, .booleans, .ints, .doubles
- Object?
  .dataType, .dataTypeWithOptions(parseable: true)

## Why use this package?

- Automatically handle dynamic data in Flutter and Dart.
- Detect nested JSON without manual checking.
- Simplify type validation and serialization tasks.
- Save time and reduce errors when working with dynamic or external data.

## License:

MIT License
