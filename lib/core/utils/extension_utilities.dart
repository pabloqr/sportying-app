import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DoubleExtension on double {
  DateTime toDateTime() {
    final date = DateTime.now();
    final hours = floor();
    final minutes = ((this - hours) * 60).round();
    return DateTime(date.year, date.month, date.day, hours, minutes);
  }

  String formatAsTime() {
    final hours = floor();
    final minutes = ((this - hours) * 60).round();
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }
}

extension StringExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}

extension DateTimeExtension on DateTime {
  static DateTime fromDouble(double value) {
    final date = DateTime.now();
    final hours = value.floor();
    final minutes = ((value - hours) * 60).round();
    return DateTime(date.year, date.month, date.day, hours, minutes);
  }

  bool isSameDay(DateTime other) => year == other.year && month == other.month && day == other.day;

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

  double toDouble() => hour + minute / 60.0;

  String toFormattedDate() => DateFormat("dd/MM/yyyy").format(this);
  String toFormattedTime() => DateFormat("HH:mm").format(this);
  String toFormattedString() => DateFormat("E, dd/MM/yyyy, HH:mm:ss").format(this);
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
