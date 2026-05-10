import 'package:sportying_app/data/services/remote/complexes/models/complex_dto.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';

extension ComplexDtoMapper on ComplexDto {
  Complex toDomain(String address) {
    return Complex(
      id: id,
      name: name,
      timeIni: timeIni,
      timeEnd: timeEnd,
      address: address,
      locLongitude: locLongitude,
      locLatitude: locLatitude,
      sports: sports.map((sport) => Sport.values.byName(sport.toLowerCase())).toSet(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension ComplexMapper on Complex {
  ComplexDto toDto() {
    return ComplexDto(
      id: id,
      name: name,
      timeIni: timeIni,
      timeEnd: timeEnd,
      locLongitude: locLongitude,
      locLatitude: locLatitude,
      sports: sports.map((sport) => sport.name).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
