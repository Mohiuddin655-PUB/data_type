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
  Map<String, dynamic> nestedJson = {
    "nested": {
      "x": 1,
      "y": [1, 2, 3]
    }
  };
  Map<String, Object> normalMap = {"obj": Object()};

  print(jsonMap.dataType); // DataType.JSON
  print(nestedJson.dataType); // DataType.JSON
  print(normalMap.dataType); // DataType.MAP

  // Lists of maps
  List<Map<String, dynamic>> jsonList = [
    {"a": 1},
    {"b": 2}
  ];
  List<Map<String, Object>> mapList = [
    {"obj": Object()},
    {"obj": Object()}
  ];

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
