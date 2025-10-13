import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';

part 'complex.freezed.dart';
part 'complex.g.dart';

@freezed
abstract class Complex with _$Complex {
  const factory Complex({
    int? id,
    required String name,
    required String timeIni,
    required String timeEnd,
    required String address,
    required double? locLongitude,
    required double? locLatitude,
    required Set<Sport> sports,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Complex;

  factory Complex.fromJson(Map<String, Object?> json) => _$ComplexFromJson(json);
}
