import 'package:flutter/material.dart';
import 'package:sportying_app/domain/models/core/widget_status.dart';
import 'package:sportying_app/features/core/widgets/visuals/medium_chip.dart';
import 'package:sportying_app/features/core/widgets/visuals/small_chip.dart';

enum ReservationStatus { scheduled, weather, completed, cancelled }

extension ReservationStatusExtension on ReservationStatus {
  bool get isActive => this == ReservationStatus.scheduled || this == ReservationStatus.weather;

  Color color(BuildContext context) {
    switch (this) {
      case ReservationStatus.scheduled:
        return WidgetStatus.neutral.color(context);
      case ReservationStatus.weather:
        return WidgetStatus.alert.color(context);
      case ReservationStatus.completed:
        return WidgetStatus.success.color(context);
      case ReservationStatus.cancelled:
        return WidgetStatus.error.color(context);
    }
  }

  Color colorSurface(BuildContext context) {
    switch (this) {
      case ReservationStatus.scheduled:
        return WidgetStatus.neutral.colorSurface(context);
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
        return WidgetStatus.neutral.colorOnSurface(context);
      case ReservationStatus.weather:
        return WidgetStatus.alert.colorOnSurface(context);
      case ReservationStatus.completed:
        return WidgetStatus.success.colorOnSurface(context);
      case ReservationStatus.cancelled:
        return WidgetStatus.error.colorOnSurface(context);
    }
  }

  Widget get smallChip {
    switch (this) {
      case ReservationStatus.scheduled:
        return SmallChip.neutral(label: 'Scheduled');
      case ReservationStatus.weather:
        return SmallChip.alert(label: 'Weather');
      case ReservationStatus.completed:
        return SmallChip.success(label: 'Completed');
      case ReservationStatus.cancelled:
        return SmallChip.error(label: 'Cancelled');
    }
  }

  Widget get mediumChip {
    switch (this) {
      case ReservationStatus.scheduled:
        return MediumChip.neutralSurface(label: 'Scheduled');
      case ReservationStatus.weather:
        return MediumChip.alert(label: 'Weather');
      case ReservationStatus.completed:
        return MediumChip.success(label: 'Completed');
      case ReservationStatus.cancelled:
        return MediumChip.error(label: 'Cancelled');
    }
  }
}
