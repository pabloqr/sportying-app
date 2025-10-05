// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complex_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ComplexApiModel _$ComplexApiModelFromJson(Map<String, dynamic> json) =>
    _ComplexApiModel(
      id: (json['id'] as num?)?.toInt(),
      complexName: json['complexName'] as String,
      timeIni: json['timeIni'] as String,
      timeEnd: json['timeEnd'] as String,
      locLongitude: (json['locLongitude'] as num?)?.toDouble(),
      locLatitude: (json['locLatitude'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ComplexApiModelToJson(_ComplexApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'complexName': instance.complexName,
      'timeIni': instance.timeIni,
      'timeEnd': instance.timeEnd,
      'locLongitude': instance.locLongitude,
      'locLatitude': instance.locLatitude,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
