import 'package:data_type/data_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DataType.detect basic types', () {
    test('primitives', () {
      expect(1.dataType, DataType.INT);
      expect(1.5.dataType, DataType.DOUBLE);
      expect(true.dataType, DataType.BOOL);
      expect('hello'.dataType, DataType.STRING);
      expect(null.dataType, DataType.NULL);
    });

    test('deep parse for strings', () {
      expect('true'.dataTypeWithOptions(parseable: true), DataType.BOOL);
      expect('123'.dataTypeWithOptions(parseable: true), DataType.INT);
      expect('3.14'.dataTypeWithOptions(parseable: true), DataType.DOUBLE);
      expect('abc'.dataTypeWithOptions(parseable: true), DataType.STRING);
    });
  });

  group('DataType.detect iterables', () {
    test('typed lists', () {
      expect([1, 2, 3].dataType, DataType.INTS);
      expect([1.1, 2.2].dataType, DataType.DOUBLES);
      expect([true, false].dataType, DataType.BOOLS);
      expect(['a', 'b'].dataType, DataType.STRINGS);
    });

    test('deep string lists', () {
      expect(
        ['1', '2', '3'].dataTypeWithOptions(parseable: true),
        DataType.INTS,
      );
      expect(
        ['1.1', '2.2'].dataTypeWithOptions(parseable: true),
        DataType.DOUBLES,
      );
      expect(
        ['true', 'false'].dataTypeWithOptions(parseable: true),
        DataType.BOOLS,
      );
      expect(['x', 'y'].dataTypeWithOptions(parseable: true), DataType.OBJECTS);
    });

    test('mixed lists', () {
      expect([1, 'a', true].dataType, DataType.OBJECTS);
      expect(
        [
          {'a': 1},
          {'b': 2},
        ].dataType,
        DataType.JSONS,
      );
      expect(
        [
          {'a': Object()},
        ].dataType,
        DataType.MAPS,
      );
    });

    test('empty list', () {
      expect([].dataType, DataType.OBJECTS);
    });
  });

  group('DataType.detect maps', () {
    test('json maps', () {
      expect({'a': 1, 'b': 'x', 'c': true}.dataType, DataType.JSON);
      expect(
        {
          'nested': {'x': 1},
        }.dataType,
        DataType.JSON,
      );
      expect(
        {
          'list': [1, 2, 3],
        }.dataType,
        DataType.JSON,
      );
      expect({}.dataType, DataType.JSON);
    });

    test('non-json maps', () {
      expect({'a': Object()}.dataType, DataType.MAP);
      expect({'a': () => {}}.dataType, DataType.MAP);
    });
  });

  group('DataType.detect complex / edge cases', () {
    test('object', () {
      expect(Object().dataType, DataType.OBJECT);
      expect(DateTime.now().dataType, DataType.OBJECT);
    });

    test('list of objects', () {
      expect([Object(), Object()].dataType, DataType.OBJECTS);
    });
  });
}
