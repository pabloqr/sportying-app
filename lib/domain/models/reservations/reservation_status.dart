import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sportying_app/features/core/utils/widget_palette.dart';
import 'package:sportying_app/features/core/utils/widget_status.dart';
import 'package:sportying_app/features/core/widgets/visuals/custom_chip.dart';
import 'package:sportying_app/features/core/widgets/visuals/pulsing_dot.dart';

enum ReservationStatus { scheduled, weather, completed, cancelled }

extension ReservationStatusExtension on ReservationStatus {
  Color _colorOnSurfaceFromPalette(BuildContext context, WidgetPalette palette) {
    switch (palette) {
      case WidgetPalette.normal:
        return colorOnSurface(context);
      case WidgetPalette.inverse:
        return colorSurface(context);
      case WidgetPalette.primary:
        return colorOnPrimary(context);
    }
  }

  bool get isActive => this == ReservationStatus.scheduled || this == ReservationStatus.weather;

  Color colorPrimary(BuildContext context) {
    switch (this) {
      case ReservationStatus.scheduled:
        return WidgetStatus.normal.colorPrimary(context);
      case ReservationStatus.weather:
        return WidgetStatus.alert.colorPrimary(context);
      case ReservationStatus.completed:
        return WidgetStatus.success.colorPrimary(context);
      case ReservationStatus.cancelled:
        return WidgetStatus.error.colorPrimary(context);
    }
  }

  Color colorOnPrimary(BuildContext context) {
    switch (this) {
      case ReservationStatus.scheduled:
        return WidgetStatus.normal.colorOnPrimary(context);
      case ReservationStatus.weather:
        return WidgetStatus.alert.colorOnPrimary(context);
      case ReservationStatus.completed:
        return WidgetStatus.success.colorOnPrimary(context);
      case ReservationStatus.cancelled:
        return WidgetStatus.error.colorOnPrimary(context);
    }
  }

  Color colorSurface(BuildContext context) {
    switch (this) {
      case ReservationStatus.scheduled:
        return WidgetStatus.normal.colorSurface(context);
      case ReservationStatus.weather:
        return WidgetStatus.alert.colorSurface(context);
      case ReservationStatus.completed:
        return WidgetStatus.success.colorSurface(context);
      case ReservationStatus.cancelled:
        return WidgetStatus.error.colorSurface(context);
    }
  }

  Color colorOnSurface(BuildContext context) {
    switch (this) {
      case ReservationStatus.scheduled:
        return WidgetStatus.normal.colorOnSurface(context);
      case ReservationStatus.weather:
        return WidgetStatus.alert.colorOnSurface(context);
      case ReservationStatus.completed:
        return WidgetStatus.success.colorOnSurface(context);
      case ReservationStatus.cancelled:
        return WidgetStatus.error.colorOnSurface(context);
    }
  }

  IconData get icon {
    switch (this) {
      case ReservationStatus.scheduled:
        return Symbols.hourglass_rounded;
      case ReservationStatus.weather:
        return Symbols.cloud_rounded;
      case ReservationStatus.completed:
        return Symbols.check_rounded;
      case ReservationStatus.cancelled:
        return Symbols.close_rounded;
    }
  }

  Widget smallChip(BuildContext context, WidgetPalette palette) {
    switch (this) {
      case ReservationStatus.scheduled:
        return CustomChip.small.normal(
          palette: palette,
          leading: PulsingDot.small(color: _colorOnSurfaceFromPalette(context, palette)),
          label: 'Scheduled',
        );
      case ReservationStatus.weather:
        return CustomChip.small.alert(
          palette: palette,
          leading: PulsingDot.small(color: _colorOnSurfaceFromPalette(context, palette)),
          label: 'Weather',
        );
      case ReservationStatus.completed:
        return CustomChip.small.success(palette: palette, label: 'Completed');
      case ReservationStatus.cancelled:
        return CustomChip.small.error(palette: palette, label: 'Cancelled');
    }
  }

  Widget mediumChip(BuildContext context, WidgetPalette palette) {
    switch (this) {
      case ReservationStatus.scheduled:
        return CustomChip.medium.normal(
          palette: palette,
          leading: PulsingDot.small(color: _colorOnSurfaceFromPalette(context, palette)),
          label: 'Scheduled',
        );
      case ReservationStatus.weather:
        return CustomChip.medium.alert(
          palette: palette,
          leading: PulsingDot.small(color: _colorOnSurfaceFromPalette(context, palette)),
          label: 'Weather',
        );
      case ReservationStatus.completed:
        return CustomChip.medium.success(palette: palette, label: 'Completed');
      case ReservationStatus.cancelled:
        return CustomChip.medium.error(palette: palette, label: 'Cancelled');
    }
  }
}
