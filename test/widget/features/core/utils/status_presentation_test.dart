import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sportying_app/domain/models/reservations/reservation_status.dart';
import 'package:sportying_app/features/core/utils/widget_palette.dart';
import 'package:sportying_app/features/core/utils/widget_status.dart';
import 'package:sportying_app/features/core/widgets/visuals/custom_chip.dart';
import 'package:sportying_app/features/core/widgets/visuals/pulsing_dot.dart';

void main() {
  testWidgets('WidgetStatus resolves its colors for light and dark themes', (tester) async {
    for (final brightness in Brightness.values) {
      late Brightness actualBrightness;
      late Color translucentSurface;

      await tester.pumpWidget(
        MaterialApp(
          home: Theme(
            data: ThemeData(
              brightness: brightness,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: brightness),
            ),
            child: Builder(
              builder: (context) {
                actualBrightness = Theme.brightnessOf(context);
                translucentSurface = WidgetStatus.translucent.colorSurface(context);
                for (final status in WidgetStatus.values) {
                  status.colorPrimary(context);
                  status.colorOnPrimary(context);
                  status.colorSurface(context);
                  status.colorOnSurface(context);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(actualBrightness, brightness);
      final scheme = ColorScheme.fromSeed(seedColor: Colors.blue, brightness: brightness);
      expect(
        translucentSurface,
        brightness == Brightness.light ? scheme.surface.withAlpha(50) : scheme.inverseSurface.withAlpha(50),
      );
    }
  });

  testWidgets('ReservationStatus produces colored chips for every status', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            for (final status in ReservationStatus.values) {
              status.colorPrimary(context);
              status.colorOnPrimary(context);
              status.colorSurface(context);
              status.colorOnSurface(context);
            }
            return Column(
              children: [
                ReservationStatus.scheduled.smallChip(context, WidgetPalette.normal),
                ReservationStatus.scheduled.mediumChip(context, WidgetPalette.inverse),
                ReservationStatus.weather.smallChip(context, WidgetPalette.primary),
                ReservationStatus.weather.mediumChip(context, WidgetPalette.normal),
                ReservationStatus.completed.smallChip(context, WidgetPalette.normal),
                ReservationStatus.completed.mediumChip(context, WidgetPalette.normal),
                ReservationStatus.cancelled.smallChip(context, WidgetPalette.normal),
                ReservationStatus.cancelled.mediumChip(context, WidgetPalette.normal),
              ],
            );
          },
        ),
      ),
    );

    expect(find.text('Scheduled'), findsNWidgets(2));
    expect(find.text('Weather'), findsNWidgets(2));
    expect(find.text('Completed'), findsNWidgets(2));
    expect(find.text('Cancelled'), findsNWidgets(2));
    expect(find.byType(CustomChip), findsNWidgets(8));
    expect(find.byType(PulsingDot), findsNWidgets(4));

    await tester.pumpWidget(const SizedBox.shrink());
  });
}
