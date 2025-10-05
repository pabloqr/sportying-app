import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/services/complexes/complexes_remote_service.dart';
import 'package:sportying_app/data/services/complexes/models/complex_api_model.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';

abstract class ComplexesRepository {
  Future<Result<List<Complex>>> getComplexes({Map<String, dynamic>? query});
  // Future<Result<Complex>> getComplex(int complexId);
}

class ComplexesRepositoryImpl implements ComplexesRepository {
  ComplexesRepositoryImpl({required ComplexesRemoteService remoteService}) : _remoteService = remoteService;

  final ComplexesRemoteService _remoteService;

  @override
  Future<Result<List<Complex>>> getComplexes({Map<String, dynamic>? query}) async {
    try {
      final result = await _remoteService.getComplexes(query);
      switch (result) {
        case Ok<List<ComplexApiModel>>():
          return Result.ok(
            result.value
                .map(
                  (complex) => Complex(
                    complexName: complex.complexName,
                    timeIni: complex.timeIni,
                    timeEnd: complex.timeEnd,
                    locLongitude: complex.locLongitude,
                    locLatitude: complex.locLatitude,
                    createdAt: complex.createdAt,
                    updatedAt: complex.updatedAt,
                  ),
                )
                .toList(),
          );
        case Error<List<ComplexApiModel>>():
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
