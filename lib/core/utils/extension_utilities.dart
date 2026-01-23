import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DoubleExtension on double {
  DateTime toDateTime() {
    final date = DateTime.now();
    final hours = floor();
    final minutes = ((this - hours) * 60).round();
    return DateTime(date.year, date.month, date.day, hours, minutes);
  }

  String toFormattedTime0() {
    final hours = floor();
    final minutes = ((this - hours) * 60).round();
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }
}

extension StringExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  DateTime toDateTime0() {
    final now = DateTime.now();
    return DateFormat('HH:mm').parse(this).copyWith(year: now.year, month: now.month, day: now.day);
  }

  double toDoubleTime0() {
    final dateTime = DateFormat('HH:mm').parse(this);
    return dateTime.hour + dateTime.minute / 60.0;
  }
}

extension DateTimeExtension on DateTime {
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  bool isBetween(DateTime start, DateTime end) => !isBefore(start) && !isAfter(end);

  bool isSameDay(DateTime other) => year == other.year && month == other.month && day == other.day;

  DateTime get ceilNextHalfHour {
    if (minute < 30) {
      return copyWith(minute: 30, second: 0, millisecond: 0, microsecond: 0);
    } else {
      return add(const Duration(hours: 1)).copyWith(minute: 0, second: 0, millisecond: 0, microsecond: 0);
    }
  }

  static DateTime fromDouble(double value) {
    final date = DateTime.now();
    final hours = value.floor();
    final minutes = ((value - hours) * 60).round();
    return DateTime(date.year, date.month, date.day, hours, minutes);
  }

  double toDouble() => hour + minute / 60.0;

  String toFormattedTime0() => DateFormat('HH:mm').format(this);
  String toFormattedWeekDay0() => DateFormat('EEE').format(this);
  String toFormattedMonthDay0() => DateFormat('dd').format(this);
  String toFormattedMonth0() => DateFormat('MMM').format(this);
  String toFormattedDate0() => DateFormat('dd/MM/yyyy').format(this);
  String toFormattedDate1() => DateFormat('EEE, dd MMM').format(this);
  String toFormattedDate2() => DateFormat('EEEE, dd MMM yyyy').format(this);
  String toFormattedDate3() => DateFormat('EEE, dd/MM/yyyy, HH:mm:ss').format(this);
}

extension RangeValuesExtension on RangeValues {
  Duration get duration {
    final duration = end - start;
    final hours = duration.floor();
    return Duration(hours: hours, minutes: ((duration - hours) * 60).round());
  }

  bool contains(double time) => time >= start && time <= end;
  bool overlaps(RangeValues other) => start <= other.end && end >= other.start;
}
