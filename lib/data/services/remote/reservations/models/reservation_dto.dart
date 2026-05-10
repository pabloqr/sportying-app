import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_dto.freezed.dart';
part 'reservation_dto.g.dart';

@freezed
abstract class ReservationDto with _$ReservationDto {
  const factory ReservationDto({
    required int id,
    required int userId,
    required int complexId,
    required int courtId,
    required DateTime dateIni,
    required DateTime dateEnd,
    required String status,
    required String reservationStatus,
    required String timeFilter,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ReservationDto;

  factory ReservationDto.fromJson(Map<String, dynamic> json) => _$ReservationDtoFromJson(json);
}
