import 'package:sportying_app/core/utils/extension_utils.dart';
import 'package:sportying_app/data/mappers/court_availability_slot_mapper.dart';
import 'package:sportying_app/data/services/remote/courts/models/court_availability_dto.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/courts/court.dart';
import 'package:sportying_app/domain/models/courts/court_availability.dart';

DateTime _calculateNextAvailable(List<CourtAvailabilitySlot> slots) {
  final now = DateTime.now().toUtc().ceilNextHalfHour;

  // Si no hay elementos, está disponible ahora
  if (slots.isEmpty) return now;

  // Filtrar solo franjas ocupadas ocupadas (available == false) y ordenar por fecha inicio
  final occupiedSlots = slots.where((slot) => !slot.available).toList()..sort((a, b) => a.dateIni.compareTo(b.dateIni));

  // Si no hay elementos, está disponible ahora
  if (occupiedSlots.isEmpty) return now;

  final firstSlot = occupiedSlots.first;

  // La primera franja ocupada está en el futuro y hay al menos 1h disponible, está disponible ahora
  if (firstSlot.dateIni.isAfter(now) && firstSlot.dateIni.difference(now).inHours >= 1) return now;

  // Buscar el primer hueco entre franjas ocupadas
  for (var i = 0; i < occupiedSlots.length - 1; ++i) {
    final currentEndTime = occupiedSlots[i].dateEnd;
    final nextStartTime = occupiedSlots[i + 1].dateIni;

    // Si hay hueco entre dos franjas ocupadas
    if (currentEndTime.isBefore(nextStartTime) && currentEndTime.difference(nextStartTime).inHours >= 1) {
      // Devolver el que sea más tarde: el fin de la franja ocupada actual o ahora
      return currentEndTime.isAfter(now) ? currentEndTime : now;
    }
  }

  // Devolver el fin de la última franja ocupada
  return occupiedSlots.last.dateEnd;
}

extension CourtAvailabilityDtoMapper on CourtAvailabilityDto {
  CourtAvailability toDomain(Court court, Complex complex) {
    final availabilitySlots = availability.map((slot) => slot.toDomain()).toList();

    final nextAvailable = _calculateNextAvailable(availabilitySlots);

    return CourtAvailability(
      court: court,
      complex: complex,
      availability: availabilitySlots,
      nextAvailable: nextAvailable,
    );
  }
}

extension CourtAvailabilityMapper on CourtAvailability {
  CourtAvailabilityDto toDto() {
    return CourtAvailabilityDto(
      id: court.id,
      complexId: complex.id,
      availability: availability.map((slot) => slot.toDto()).toList(),
    );
  }
}
