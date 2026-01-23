// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'court_availability_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CourtAvailabilitySlotApiModel _$CourtAvailabilitySlotApiModelFromJson(
  Map<String, dynamic> json,
) => _CourtAvailabilitySlotApiModel(
  dateIni: DateTime.parse(json['dateIni'] as String),
  dateEnd: DateTime.parse(json['dateEnd'] as String),
  available: json['available'] as bool,
);

Map<String, dynamic> _$CourtAvailabilitySlotApiModelToJson(
  _CourtAvailabilitySlotApiModel instance,
) => <String, dynamic>{
  'dateIni': instance.dateIni.toIso8601String(),
  'dateEnd': instance.dateEnd.toIso8601String(),
  'available': instance.available,
};

_CourtAvailabilityApiModel _$CourtAvailabilityApiModelFromJson(
  Map<String, dynamic> json,
) => _CourtAvailabilityApiModel(
  id: (json['id'] as num).toInt(),
  complexId: (json['complexId'] as num).toInt(),
  availability: (json['availability'] as List<dynamic>)
      .map(
        (e) =>
            CourtAvailabilitySlotApiModel.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$CourtAvailabilityApiModelToJson(
  _CourtAvailabilityApiModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'complexId': instance.complexId,
  'availability': instance.availability,
};
