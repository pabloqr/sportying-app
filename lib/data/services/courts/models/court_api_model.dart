import 'package:freezed_annotation/freezed_annotation.dart';

part 'court_api_model.freezed.dart';
part 'court_api_model.g.dart';

@freezed
abstract class CourtApiModel with _$CourtApiModel {
  const factory CourtApiModel({
    int? id,
    required int complexId,
    required String sport,
    required String name,
    required String description,
    required int maxPeople,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CourtApiModel;

  factory CourtApiModel.fromJson(Map<String, Object?> json) => _$CourtApiModelFromJson(json);
}
