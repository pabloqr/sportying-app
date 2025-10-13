// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complex.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Complex _$ComplexFromJson(Map<String, dynamic> json) => _Complex(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String,
  timeIni: json['timeIni'] as String,
  timeEnd: json['timeEnd'] as String,
  address: json['address'] as String,
  locLongitude: (json['locLongitude'] as num?)?.toDouble(),
  locLatitude: (json['locLatitude'] as num?)?.toDouble(),
  sports: (json['sports'] as List<dynamic>)
      .map((e) => $enumDecode(_$SportEnumMap, e))
      .toSet(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ComplexToJson(_Complex instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'timeIni': instance.timeIni,
  'timeEnd': instance.timeEnd,
  'address': instance.address,
  'locLongitude': instance.locLongitude,
  'locLatitude': instance.locLatitude,
  'sports': instance.sports.map((e) => _$SportEnumMap[e]!).toList(),
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
