// import 'package:flutter/material.dart';

enum AvailabilityStatus { empty, occupied, cancelled }

extension AvailabilityStatusExtension on AvailabilityStatus {
  // Widget get smallStatusChip {
  //   switch (this) {
  //     case AvailabilityStatus.empty:
  //       return SmallChip.neutralSurface(label: 'Scheduled');
  //     case AvailabilityStatus.occupied:
  //       return SmallChip.success(label: 'Occupied');
  //     case AvailabilityStatus.cancelled:
  //       return SmallChip.error(label: 'Cancelled');
  //   }
  // }

  // Widget get mediumStatusChip {
  //   switch (this) {
  //     case AvailabilityStatus.empty:
  //       return MediumChip.neutralSurface(label: 'Scheduled');
  //     case AvailabilityStatus.occupied:
  //       return MediumChip.success(label: 'Occupied');
  //     case AvailabilityStatus.cancelled:
  //       return MediumChip.error(label: 'Cancelled');
  //   }
  // }
}
