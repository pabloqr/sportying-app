// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Reservation _$ReservationFromJson(Map<String, dynamic> json) => _Reservation(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  complex: Complex.fromJson(json['complex'] as Map<String, dynamic>),
  court: Court.fromJson(json['court'] as Map<String, dynamic>),
  dateIni: DateTime.parse(json['dateIni'] as String),
  dateEnd: DateTime.parse(json['dateEnd'] as String),
  status: $enumDecode(_$AvailabilityStatusEnumMap, json['status']),
  reservationStatus: $enumDecode(
    _$ReservationStatusEnumMap,
    json['reservationStatus'],
  ),
  timeFilter: $enumDecode(_$TimeFilterEnumMap, json['timeFilter']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ReservationToJson(
  _Reservation instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'complex': instance.complex,
  'court': instance.court,
  'dateIni': instance.dateIni.toIso8601String(),
  'dateEnd': instance.dateEnd.toIso8601String(),
  'status': _$AvailabilityStatusEnumMap[instance.status]!,
  'reservationStatus': _$ReservationStatusEnumMap[instance.reservationStatus]!,
  'timeFilter': _$TimeFilterEnumMap[instance.timeFilter]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$AvailabilityStatusEnumMap = {
  AvailabilityStatus.empty: 'empty',
  AvailabilityStatus.occupied: 'occupied',
  AvailabilityStatus.cancelled: 'cancelled',
};

const _$ReservationStatusEnumMap = {
  ReservationStatus.scheduled: 'scheduled',
  ReservationStatus.weather: 'weather',
  ReservationStatus.completed: 'completed',
  ReservationStatus.cancelled: 'cancelled',
};

const _$TimeFilterEnumMap = {
  TimeFilter.all: 'all',
  TimeFilter.past: 'past',
  TimeFilter.upcoming: 'upcoming',
};
