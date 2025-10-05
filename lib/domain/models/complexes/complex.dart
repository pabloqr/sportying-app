import 'package:freezed_annotation/freezed_annotation.dart';

part 'complex.freezed.dart';
part 'complex.g.dart';

@freezed
abstract class Complex with _$Complex {
  const factory Complex({
    int? id,
    required String complexName,
    required String timeIni,
    required String timeEnd,
    required double? locLongitude,
    required double? locLatitude,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Complex;

  factory Complex.fromJson(Map<String, Object?> json) => _$ComplexFromJson(json);
}
