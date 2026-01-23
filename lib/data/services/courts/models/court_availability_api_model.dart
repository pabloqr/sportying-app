import 'package:freezed_annotation/freezed_annotation.dart';

part 'court_availability_api_model.freezed.dart';
part 'court_availability_api_model.g.dart';

@freezed
abstract class CourtAvailabilitySlotApiModel with _$CourtAvailabilitySlotApiModel {
  const factory CourtAvailabilitySlotApiModel({
    required DateTime dateIni,
    required DateTime dateEnd,
    required bool available,
  }) = _CourtAvailabilitySlotApiModel;

  factory CourtAvailabilitySlotApiModel.fromJson(Map<String, Object?> json) =>
      _$CourtAvailabilitySlotApiModelFromJson(json);
}

@freezed
abstract class CourtAvailabilityApiModel with _$CourtAvailabilityApiModel {
  const factory CourtAvailabilityApiModel({
    required int id,
    required int complexId,
    required List<CourtAvailabilitySlotApiModel> availability,
  }) = _CourtAvailabilityApiModel;

  factory CourtAvailabilityApiModel.fromJson(Map<String, Object?> json) => _$CourtAvailabilityApiModelFromJson(json);
}
