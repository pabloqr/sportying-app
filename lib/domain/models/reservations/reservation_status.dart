import 'package:flutter/material.dart';
import 'package:sportying_app/features/core/widgets/visuals/medium_chip.dart';
import 'package:sportying_app/features/core/widgets/visuals/small_chip.dart';

enum ReservationStatus { scheduled, weather, completed, cancelled }

extension ReservationStatusExtension on ReservationStatus {
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
