import 'package:sportying_app/data/services/remote/courts/models/court_dto.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';
import 'package:sportying_app/domain/models/courts/court.dart';
import 'package:sportying_app/domain/models/courts/court_status.dart';

extension CourtDtoMapper on CourtDto {
  Court toDomain(Complex complex) {
    return Court(
      id: id,
      complex: complex,
      sport: Sport.values.byName(sport.toLowerCase()),
      name: name,
      description: description,
      maxPeople: maxPeople,
      status: CourtStatus.values.byName(status.toLowerCase()),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension CourtMapper on Court {
  CourtDto toDto() {
    return CourtDto(
      id: id,
      complexId: complex.id,
      sport: sport.toString(),
      name: name,
      description: description,
      maxPeople: maxPeople,
      status: status.toString(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
