import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sportying_app/features/core/widgets/visuals/pulsing_dot.dart';

void main() {
  testWidgets('PulsingDot renders all sizes and animates a frame', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Row(
          children: [
            const PulsingDot.small(color: Colors.red),
            PulsingDot.medium(color: Colors.green),
            PulsingDot.large(color: Colors.blue),
          ],
        ),
      ),
    );

    expect(find.byType(PulsingDot), findsNWidgets(3));
    expect(find.descendant(of: find.byType(PulsingDot), matching: find.byType(AnimatedBuilder)), findsNWidgets(6));

    await tester.pump(const Duration(milliseconds: 200));
    expect(find.descendant(of: find.byType(PulsingDot), matching: find.byType(Transform)), findsNWidgets(6));

    await tester.pumpWidget(const SizedBox.shrink());
  });
}
