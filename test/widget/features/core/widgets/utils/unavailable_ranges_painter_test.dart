import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sportying_app/features/core/widgets/utils/unavailable_ranges_painter.dart';

UnavailableRangesPainter _painter(List<RangeValues> ranges) {
  return UnavailableRangesPainter(
    unavailableRanges: ranges,
    minTime: 8,
    maxTime: 16,
    fillColor: Colors.red,
    strokeColor: Colors.black,
  );
}

void main() {
  testWidgets('UnavailableRangesPainter paints visible edge and inner ranges', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CustomPaint(
          size: const Size(300, 32),
          painter: _painter(const [
            RangeValues(7, 17),
            RangeValues(7, 10),
            RangeValues(14, 17),
            RangeValues(10, 12),
            RangeValues(1, 2),
          ]),
        ),
      ),
    );

    expect(find.byType(CustomPaint), findsWidgets);
  });

  test('shouldRepaint changes only when painter configuration changes', () {
    final original = _painter(const [RangeValues(9, 10)]);
    final unchanged = _painter(const [RangeValues(9, 10)]);
    final changed = _painter(const [RangeValues(10, 11)]);

    expect(unchanged.shouldRepaint(original), isFalse);
    expect(changed.shouldRepaint(original), isTrue);
  });
}
