// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'court.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Court _$CourtFromJson(Map<String, dynamic> json) => _Court(
  id: (json['id'] as num).toInt(),
  complex: Complex.fromJson(json['complex'] as Map<String, dynamic>),
  sport: $enumDecode(_$SportEnumMap, json['sport']),
  name: json['name'] as String,
  description: json['description'] as String,
  maxPeople: (json['maxPeople'] as num).toInt(),
  status: $enumDecode(_$CourtStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$CourtToJson(_Court instance) => <String, dynamic>{
  'id': instance.id,
  'complex': instance.complex,
  'sport': _$SportEnumMap[instance.sport]!,
  'name': instance.name,
  'description': instance.description,
  'maxPeople': instance.maxPeople,
  'status': _$CourtStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$SportEnumMap = {
  Sport.basketball: 'basketball',
  Sport.football: 'football',
  Sport.padel: 'padel',
  Sport.tennis: 'tennis',
  Sport.volleyball: 'volleyball',
};

const _$CourtStatusEnumMap = {
  CourtStatus.open: 'open',
  CourtStatus.maintenance: 'maintenance',
  CourtStatus.blocked: 'blocked',
  CourtStatus.weather: 'weather',
};
