import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sportying_app/features/core/utils/widget_palette.dart';
import 'package:sportying_app/features/core/widgets/visuals/custom_chip.dart';

Widget _app(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  testWidgets('CustomChip renders its content variants and builder statuses', (tester) async {
    await tester.pumpWidget(
      _app(
        Column(
          children: [
            CustomChip.small.normal(palette: WidgetPalette.normal, label: 'Normal'),
            CustomChip.medium.neutral(palette: WidgetPalette.inverse, icon: Icons.info, label: 'Neutral'),
            CustomChip.large.translucent(palette: WidgetPalette.primary, icon: Icons.visibility),
            CustomChip.small.alert(palette: WidgetPalette.normal, leading: const Text('!'), label: 'Alert'),
            CustomChip.medium.success(
              palette: WidgetPalette.normal,
              icon: Icons.check,
              filledIcon: true,
              label: 'Success',
            ),
            CustomChip.large.error(palette: WidgetPalette.primary, label: 'Error'),
          ],
        ),
      ),
    );

    expect(find.text('Normal'), findsOneWidget);
    expect(find.text('Neutral'), findsOneWidget);
    expect(find.text('Alert'), findsOneWidget);
    expect(find.text('Success'), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);
    expect(find.byIcon(Icons.info), findsOneWidget);
    expect(find.byIcon(Icons.visibility), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);
    expect(find.byType(CustomChip), findsNWidgets(6));
  });
}
