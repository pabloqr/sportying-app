import 'package:sportying_app/data/services/remote/courts/models/court_availability_dto.dart';
import 'package:sportying_app/domain/models/courts/court_availability.dart';

extension CourtAvailabilitySlotDtoMapper on CourtAvailabilitySlotDto {
  CourtAvailabilitySlot toDomain() {
    return CourtAvailabilitySlot(dateIni: dateIni, dateEnd: dateEnd, available: available);
  }
}

extension CourtAvailabilitySlotMapper on CourtAvailabilitySlot {
  CourtAvailabilitySlotDto toDto() {
    return CourtAvailabilitySlotDto(dateIni: dateIni, dateEnd: dateEnd, available: available);
  }
}
