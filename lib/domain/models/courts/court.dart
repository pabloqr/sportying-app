import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';
import 'package:sportying_app/domain/models/courts/court_status.dart';

part 'court.freezed.dart';
part 'court.g.dart';

@freezed
abstract class Court with _$Court {
  const factory Court ({
    required int id,
    required Complex complex,
    required Sport sport,
    required String name,
    required String description,
    required int maxPeople,
    required CourtStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Court;

  factory Court.fromJson(Map<String, Object?> json) => _$CourtFromJson(json);
}