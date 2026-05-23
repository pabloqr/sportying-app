import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sportying_app/domain/models/courts/court_availability.dart';
import 'package:sportying_app/features/core/widgets/visuals/time_range_selector.dart';

void main() {
  group('TimeRangeController Unit Tests', () {
    test('initializes with default morning time values', () {
      final controller = TimeRangeController();

      expect(controller.currentTimeIni, equals(8.0));
      expect(controller.currentTimeEnd, equals(16.0));
      expect(controller.currentRangeValues.start, equals(8.0));
      expect(controller.currentRangeValues.end, equals(9.0));
      expect(controller.unavailableRanges, isEmpty);
    });

    test('setAfternoonTime shifts time window and updates selection', () {
      final controller = TimeRangeController();

      controller.setAfternoonTime();

      expect(controller.currentTimeIni, equals(16.0));
      expect(controller.currentTimeEnd, equals(24.0));
      expect(controller.currentRangeValues.start, equals(16.0));
      expect(controller.currentRangeValues.end, equals(17.0));
    });

    test('setSchedule adjusts bounds and clamps current selection', () {
      final controller = TimeRangeController();

      controller.setSchedule(10.0, 22.0);

      expect(controller.schedule.start, equals(10.0));
      expect(controller.schedule.end, equals(22.0));
    });

    test('addUnavailableRange updates list and merges overlapping ranges', () {
      final controller = TimeRangeController();

      controller.addUnavailableRange(const RangeValues(9.0, 11.0));
      controller.addUnavailableRange(const RangeValues(10.0, 12.0));

      expect(controller.unavailableRanges.length, equals(1));
      expect(controller.unavailableRanges[0].start, equals(9.0));
      expect(controller.unavailableRanges[0].end, equals(12.0));
    });

    test('removeUnavailableRange can split a blocked period', () {
      final controller = TimeRangeController();
      controller.addUnavailableRange(const RangeValues(9.0, 13.0));

      controller.removeUnavailableRange(const RangeValues(10.0, 12.0));

      expect(controller.unavailableRanges, equals([const RangeValues(9.0, 10.0), const RangeValues(12.0, 13.0)]));
    });

    test('setUnavailableSlotsFromAvailability includes only occupied slots for selected date and schedule', () {
      final controller = TimeRangeController()..setSchedule(8.0, 18.0);
      final date = DateTime(2026, 5, 23);

      controller.setUnavailableSlotsFromAvailability([
        CourtAvailabilitySlot(dateIni: DateTime(2026, 5, 23, 7), dateEnd: DateTime(2026, 5, 23, 9), available: false),
        CourtAvailabilitySlot(dateIni: DateTime(2026, 5, 23, 10), dateEnd: DateTime(2026, 5, 23, 11), available: true),
        CourtAvailabilitySlot(dateIni: DateTime(2026, 5, 24, 12), dateEnd: DateTime(2026, 5, 24, 13), available: false),
      ], date);

      expect(controller.unavailableRanges, equals([const RangeValues(8.0, 9.0)]));
      expect(controller.isMorningAvailable, isTrue);
      expect(controller.isAfternoonAvailable, isTrue);
    });
  });
}
