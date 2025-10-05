import 'package:freezed_annotation/freezed_annotation.dart';

part 'complex_api_model.freezed.dart';
part 'complex_api_model.g.dart';

@freezed
abstract class ComplexApiModel with _$ComplexApiModel {
  const factory ComplexApiModel({
    int? id,
    required String complexName,
    required String timeIni,
    required String timeEnd,
    required double? locLongitude,
    required double? locLatitude,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ComplexApiModel;

  factory ComplexApiModel.fromJson(Map<String, Object?> json) => _$ComplexApiModelFromJson(json);
}