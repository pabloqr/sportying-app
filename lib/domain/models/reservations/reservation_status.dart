import 'package:flutter/material.dart';
import 'package:sportying_app/features/core/utils/widget_status.dart';
import 'package:sportying_app/features/core/widgets/visuals/medium_chip.dart';
import 'package:sportying_app/features/core/widgets/visuals/small_chip.dart';

enum ReservationStatus { scheduled, weather, completed, cancelled }

extension ReservationStatusExtension on ReservationStatus {
  bool get isActive => this == ReservationStatus.scheduled || this == ReservationStatus.weather;

  Color colorPrimary(BuildContext context) {
    switch (this) {
      case ReservationStatus.scheduled:
        return WidgetStatus.neutral.colorPrimary(context);
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
        return WidgetStatus.neutral.colorOnPrimary(context);
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

  Widget smallChip(bool inverse) {
    switch (this) {
      case ReservationStatus.scheduled:
        return SmallChip.neutral(inverse, label: 'Scheduled');
      case ReservationStatus.weather:
        return SmallChip.alert(inverse, label: 'Weather');
      case ReservationStatus.completed:
        return SmallChip.success(inverse, label: 'Completed');
      case ReservationStatus.cancelled:
        return SmallChip.error(inverse, label: 'Cancelled');
    }
  }

  Widget mediumChip(bool inverse) {
    switch (this) {
      case ReservationStatus.scheduled:
        return MediumChip.neutral(inverse, label: 'Scheduled');
      case ReservationStatus.weather:
        return MediumChip.alert(inverse, label: 'Weather');
      case ReservationStatus.completed:
        return MediumChip.success(inverse, label: 'Completed');
      case ReservationStatus.cancelled:
        return MediumChip.error(inverse, label: 'Cancelled');
    }
  }
}
