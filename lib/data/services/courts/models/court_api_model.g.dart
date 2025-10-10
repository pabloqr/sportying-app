// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'court_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CourtApiModel _$CourtApiModelFromJson(Map<String, dynamic> json) =>
    _CourtApiModel(
      id: (json['id'] as num?)?.toInt(),
      complexId: (json['complexId'] as num).toInt(),
      sport: json['sport'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      maxPeople: (json['maxPeople'] as num).toInt(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CourtApiModelToJson(_CourtApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'complexId': instance.complexId,
      'sport': instance.sport,
      'name': instance.name,
      'description': instance.description,
      'maxPeople': instance.maxPeople,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
