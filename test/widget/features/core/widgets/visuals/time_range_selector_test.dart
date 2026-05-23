import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sportying_app/domain/models/courts/court_availability.dart';
import 'package:sportying_app/features/core/widgets/visuals/time_range_selector.dart';

Widget _subject({
  required TimeRangeController controller,
  required DateTime date,
  required List<CourtAvailabilitySlot> availability,
}) {
  return MaterialApp(
    home: Scaffold(
      body: ChangeNotifierProvider.value(
        value: controller,
        child: TimeRangeSelector(schedule: const RangeValues(8, 22), date: date, availability: availability),
      ),
    ),
  );
}

void main() {
  testWidgets('TimeRangeSelector renders availability and switches period', (tester) async {
    final date = DateTime(2026, 5, 23);
    final controller = TimeRangeController();
    final slots = [
      CourtAvailabilitySlot(dateIni: DateTime(2026, 5, 23, 10), dateEnd: DateTime(2026, 5, 23, 11), available: false),
    ];

    await tester.pumpWidget(_subject(controller: controller, date: date, availability: slots));
    await tester.pump();

    expect(find.text('Morning'), findsOneWidget);
    expect(find.text('Afternoon'), findsOneWidget);
    expect(find.byType(RangeSlider), findsOneWidget);
    expect(find.text('SELECTED TIME'), findsOneWidget);
    expect(find.text('PRICE'), findsOneWidget);
    expect(controller.unavailableRanges, equals(const [RangeValues(10, 11)]));
    expect(controller.currentDayTime, DayTime.morning);

    await tester.tap(find.text('Afternoon'));
    await tester.pump();

    expect(controller.currentDayTime, DayTime.afternoon);
    expect(controller.currentTimeIni, equals(16));

    await tester.tap(find.text('Morning'));
    await tester.pump();
    expect(controller.currentDayTime, DayTime.morning);

    controller.setAfternoonTime();
    await tester.pump();
    expect(controller.currentDayTime, DayTime.afternoon);

    await tester.drag(find.byType(RangeSlider), const Offset(30, 0));
    await tester.pump();
    expect(controller.currentRangeValues.start, greaterThanOrEqualTo(16));
  });

  testWidgets('TimeRangeSelector updates availability when its date changes', (tester) async {
    final firstDate = DateTime(2026, 5, 23);
    final secondDate = DateTime(2026, 5, 24);
    final controller = TimeRangeController();
    final slots = [
      CourtAvailabilitySlot(dateIni: DateTime(2026, 5, 24, 12), dateEnd: DateTime(2026, 5, 24, 13), available: false),
    ];

    await tester.pumpWidget(_subject(controller: controller, date: firstDate, availability: slots));
    await tester.pump();
    expect(controller.unavailableRanges, isEmpty);

    controller.currentTimeEnd = 22;
    await tester.pumpWidget(_subject(controller: controller, date: secondDate, availability: slots));
    await tester.pump();

    expect(controller.unavailableRanges, equals(const [RangeValues(12, 13)]));
  });
}
