// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReservationApiModel _$ReservationApiModelFromJson(Map<String, dynamic> json) =>
    _ReservationApiModel(
      id: (json['id'] as num?)?.toInt(),
      userId: json['userId'],
      complexId: (json['complexId'] as num).toInt(),
      courtId: (json['courtId'] as num).toInt(),
      dateIni: DateTime.parse(json['dateIni'] as String),
      dateEnd: DateTime.parse(json['dateEnd'] as String),
      status: json['status'] as String,
      reservationStatus: json['reservationStatus'] as String,
      timeFilter: json['timeFilter'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ReservationApiModelToJson(
  _ReservationApiModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'complexId': instance.complexId,
  'courtId': instance.courtId,
  'dateIni': instance.dateIni.toIso8601String(),
  'dateEnd': instance.dateEnd.toIso8601String(),
  'status': instance.status,
  'reservationStatus': instance.reservationStatus,
  'timeFilter': instance.timeFilter,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
