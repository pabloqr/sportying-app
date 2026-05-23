import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:sportying_app/core/utils/command.dart';
import 'package:sportying_app/core/utils/result.dart';

void main() {
  group('Command0', () {
    test('reports running state, ignores concurrent execution, and stores success', () async {
      final completer = Completer<Result<int>>();
      var calls = 0;
      final command = Command0<int>(() {
        calls++;
        return completer.future;
      });
      final states = <bool>[];
      command.addListener(() => states.add(command.running));

      final firstExecution = command.execute();
      await command.execute();

      expect(command.running, isTrue);
      expect(calls, equals(1));

      completer.complete(const Result.ok(42));
      await firstExecution;

      expect(command.running, isFalse);
      expect(command.completed, isTrue);
      expect((command.result! as Ok<int>).value, equals(42));
      expect(states, equals([true, false]));
    });

    test('stores errors and clearResult resets completed state', () async {
      final failure = Exception('failed');
      final command = Command0<void>(() async => Result.error(failure));

      await command.execute();

      expect(command.error, isTrue);
      expect((command.result! as Error<void>).error, same(failure));

      command.clearResult();

      expect(command.result, isNull);
      expect(command.error, isFalse);
      expect(command.completed, isFalse);
    });

    test('resets running when its action throws', () async {
      final command = Command0<void>(() async => throw Exception('failed'));

      await expectLater(command.execute(), throwsA(isA<Exception>()));

      expect(command.running, isFalse);
      expect(command.result, isNull);
    });
  });

  test('Command1 and Command2 forward their arguments', () async {
    String? oneArgument;
    final command1 = Command1<void, String>((value) async {
      oneArgument = value;
      return const Result.ok(null);
    });
    int? sum;
    final command2 = Command2<void, int, int>((left, right) async {
      sum = left + right;
      return const Result.ok(null);
    });

    await command1.execute('argument');
    await command2.execute(2, 3);

    expect(oneArgument, equals('argument'));
    expect(sum, equals(5));
  });
}
