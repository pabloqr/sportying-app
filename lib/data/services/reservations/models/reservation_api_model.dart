import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_api_model.freezed.dart';
part 'reservation_api_model.g.dart';

@freezed
abstract class ReservationApiModel with _$ReservationApiModel {
  const factory ReservationApiModel({
    int? id,
    required userId,
    required int complexId,
    required int courtId,
    required DateTime dateIni,
    required DateTime dateEnd,
    required String status,
    required String reservationStatus,
    required String timeFilter,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ReservationApiModel;

  factory ReservationApiModel.fromJson(Map<String, Object?> json) => _$ReservationApiModelFromJson(json);
}