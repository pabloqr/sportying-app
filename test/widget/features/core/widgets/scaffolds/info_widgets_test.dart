import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sportying_app/features/core/widgets/scaffolds/info_section_widget.dart';
import 'package:sportying_app/features/core/widgets/scaffolds/labeled_info_widget.dart';
import 'package:sportying_app/features/core/widgets/utils/marquee_widget.dart';

Widget _app(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  testWidgets('InfoSectionWidget places content in both columns', (tester) async {
    await tester.pumpWidget(
      _app(const InfoSectionWidget(leftChildren: [Text('Left value')], rightChildren: [Text('Right value')])),
    );

    expect(find.text('Left value'), findsOneWidget);
    expect(find.text('Right value'), findsOneWidget);
    expect(find.byType(Expanded), findsNWidgets(2));
  });

  testWidgets('LabeledInfoWidget renders labels with and without icons', (tester) async {
    const label = 'sport';

    await tester.pumpWidget(
      _app(
        Column(
          children: [
            LabeledInfoWidget(label: label, text: 'Padel'),
            const LabeledInfoWidget.icon(icon: Icons.timer, filledIcon: true, label: 'time', text: '10:00'),
          ],
        ),
      ),
    );

    expect(find.text('SPORT'), findsOneWidget);
    expect(find.text('TIME'), findsOneWidget);
    expect(find.text('Padel'), findsOneWidget);
    expect(find.text('10:00'), findsOneWidget);
    expect(find.byIcon(Icons.timer), findsOneWidget);
  });

  testWidgets('MarqueeWidget scrolls overflowing text and stops when removed', (tester) async {
    await tester.pumpWidget(
      _app(
        const SizedBox(
          width: 40,
          child: MarqueeWidget(
            charactersPerSecond: 1000,
            pauseDuration: Duration(milliseconds: 10),
            child: Text('A long scrolling text value'),
          ),
        ),
      ),
    );
    await tester.pump();

    final scrollable = tester.state<ScrollableState>(find.byType(Scrollable));
    expect(scrollable.position.maxScrollExtent, greaterThan(0));

    await tester.pump(const Duration(milliseconds: 10));
    await tester.pump(const Duration(milliseconds: 500));
    expect(scrollable.position.pixels, greaterThan(0));

    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 10));
    await tester.pump(const Duration(milliseconds: 500));

    await tester.pumpWidget(_app(const SizedBox.shrink()));
    await tester.pump();
  });

  testWidgets('MarqueeWidget extracts rich text while animating overflow', (tester) async {
    await tester.pumpWidget(
      _app(
        SizedBox(
          width: 40,
          child: MarqueeWidget(
            charactersPerSecond: 1000,
            pauseDuration: const Duration(milliseconds: 10),
            child: RichText(text: const TextSpan(text: 'Another long scrolling text value')),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    await tester.pump(const Duration(seconds: 2));

    await tester.pumpWidget(_app(const SizedBox.shrink()));
    await tester.pump(const Duration(milliseconds: 10));
  });
}
