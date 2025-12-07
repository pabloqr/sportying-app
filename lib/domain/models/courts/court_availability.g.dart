// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'court_availability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CourtAvailabilitySlot _$CourtAvailabilitySlotFromJson(
  Map<String, dynamic> json,
) => _CourtAvailabilitySlot(
  dateIni: DateTime.parse(json['dateIni'] as String),
  dateEnd: DateTime.parse(json['dateEnd'] as String),
  available: json['available'] as bool,
);

Map<String, dynamic> _$CourtAvailabilitySlotToJson(
  _CourtAvailabilitySlot instance,
) => <String, dynamic>{
  'dateIni': instance.dateIni.toIso8601String(),
  'dateEnd': instance.dateEnd.toIso8601String(),
  'available': instance.available,
};

_CourtAvailability _$CourtAvailabilityFromJson(Map<String, dynamic> json) =>
    _CourtAvailability(
      id: (json['id'] as num).toInt(),
      complex: Complex.fromJson(json['complex'] as Map<String, dynamic>),
      availability: (json['availability'] as List<dynamic>)
          .map((e) => CourtAvailabilitySlot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CourtAvailabilityToJson(_CourtAvailability instance) =>
    <String, dynamic>{
      'id': instance.id,
      'complex': instance.complex,
      'availability': instance.availability,
    };
