import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sportying_app/core/utils/exceptions.dart';
import 'package:sportying_app/core/utils/extension_utils.dart';
import 'package:sportying_app/core/utils/network_utils.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/core/utils/result_utils.dart';

void main() {
  group('ResultUtils', () {
    test('unwrapOrThrow returns successes and throws failures', () {
      final failure = Exception('failure');

      expect(ResultUtils.unwrapOrThrow(const Result.ok(4)), equals(4));
      expect(() => ResultUtils.unwrapOrThrow<int>(Result.error(failure)), throwsA(same(failure)));
    });

    test('result values include their contents in string output', () {
      expect(const Result<int>.ok(2).toString(), equals('Result<int>.ok(2)'));
      expect(Result<int>.error(Exception('failed')).toString(), contains('Exception: failed'));
    });
  });

  group('NetworkUtilities.validateQueryValue', () {
    test('serializes supported values', () {
      final date = DateTime.utc(2026, 5, 23, 10);

      expect(NetworkUtilities.validateQueryValue(type: String, value: 'padel'), equals('padel'));
      expect(NetworkUtilities.validateQueryValue(type: int, value: 12), equals('12'));
      expect(NetworkUtilities.validateQueryValue(type: int, value: '12'), equals('12'));
      expect(NetworkUtilities.validateQueryValue(type: double, value: 12.5), equals('12.5'));
      expect(NetworkUtilities.validateQueryValue(type: double, value: 12), equals('12.0'));
      expect(NetworkUtilities.validateQueryValue(type: double, value: '12.5'), equals('12.5'));
      expect(NetworkUtilities.validateQueryValue(type: DateTime, value: date), equals(date.toIso8601String()));
      expect(NetworkUtilities.validateQueryValue(type: DateTime, value: '2026-05-23'), equals('2026-05-23'));
    });

    test('rejects invalid values and unsupported types', () {
      expect(NetworkUtilities.validateQueryValue(type: int, value: '12.5'), isNull);
      expect(NetworkUtilities.validateQueryValue(type: bool, value: true), isNull);
    });
  });

  group('date and range extensions', () {
    test('converts double and string time values', () {
      final dateFromDouble = 9.5.toDateTime();
      final dateFromString = '10:15'.toDateTime0();

      expect(9.5.toFormattedTime0(), equals('09:30'));
      expect(dateFromDouble.hour, equals(9));
      expect(dateFromDouble.minute, equals(30));
      expect('mADriD'.toCapitalized(), equals('Madrid'));
      expect(''.toCapitalized(), isEmpty);
      expect(dateFromString.hour, equals(10));
      expect(dateFromString.minute, equals(15));
      expect('10:30'.toDoubleTime0(), equals(10.5));
    });

    test('handles boundaries and half-hour rounding', () {
      final date = DateTime(2026, 5, 23, 10, 31, 45);

      expect(date.ceilNextHalfHour, equals(DateTime(2026, 5, 23, 11)));
      expect(DateTime(2026, 5, 23, 10, 10, 45).ceilNextHalfHour, equals(DateTime(2026, 5, 23, 10, 30)));
      expect(date.isSameDay(DateTime(2026, 5, 23, 23)), isTrue);
      expect(date.isBetween(DateTime(2026, 5, 23, 10), DateTime(2026, 5, 23, 11)), isTrue);
      expect(DateTime(2026, 5, 23, 10, 30).toDouble(), equals(10.5));
      expect(DateTimeExtension.fromDouble(11.75).hour, equals(11));
      expect(DateTimeExtension.fromDouble(11.75).minute, equals(45));
    });

    test('formats dates and times', () {
      final date = DateTime(2026, 5, 23, 10, 31, 45);

      expect(date.toFormattedTime0(), equals('10:31'));
      expect(date.toFormattedMonthDay0(), equals('23'));
      expect(date.toFormattedDate0(), equals('23/05/2026'));
      expect(date.toFormattedWeekDay0(), isNotEmpty);
      expect(date.toFormattedMonth0(), isNotEmpty);
      expect(date.toFormattedDate1(), contains('23'));
      expect(date.toFormattedDate2(), contains('2026'));
      expect(date.toFormattedDate3(), contains('10:31:45'));
    });

    test('calculates range duration, containment, and overlap', () {
      const range = RangeValues(9.5, 11);

      expect(range.duration, equals(const Duration(hours: 1, minutes: 30)));
      expect(range.contains(10), isTrue);
      expect(range.overlaps(const RangeValues(11, 12)), isTrue);
      expect(range.overlaps(const RangeValues(12, 13)), isFalse);
    });
  });

  group('custom exceptions', () {
    test('expose defaults and include configured values in toString', () {
      expect(ServerException().message, equals('An error occurred on the server'));
      expect(ServerException('failure', 503).toString(), equals('ServerException(message: failure, statusCode: 503)'));
      expect(CacheException().toString(), equals('CacheException(message: An error occurred with local cache)'));
      expect(NetworkException('offline').toString(), equals('NetworkException(message: offline)'));
      expect(UnexpectedException().toString(), equals('UnexpectedException(message: An unexpected error occurred)'));
    });
  });
}
