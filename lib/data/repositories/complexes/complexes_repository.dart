import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/services/complexes/complexes_remote_service.dart';
import 'package:sportying_app/data/services/complexes/models/complex_api_model.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/features/core/utils/widget_utilities.dart';

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
      // Obtener los complejos almacenados en el sistema
      // TODO: optimización para obtener solo los más relevantes y paginación
      final result = await _remoteService.getComplexes(query);
      // Obtener el resultado de la operación
      switch (result) {
        case Ok<List<ComplexApiModel>>():
          return Result.ok(
            // Necesario para las operaciones asíncronas que se realizan dentro del bucle
            await Future.wait(
              // Procesar todos los complejos obtenidos para transformarlos al modelo que emplea la aplicación
              result.value.map((complex) async {
                // Obtener la dirección del complejo en forma de cadena de texto
                // Si no se tienen las coordenadas, establecer un mensaje por defecto
                final address = (complex.locLatitude != null && complex.locLongitude != null)
                    ? await WidgetUtilities.getAddressFromLatLng(complex.locLatitude!, complex.locLongitude!)
                    : 'No address provided';

                // Crear la instancia del modelo del complejo
                return Complex(
                  name: complex.complexName,
                  timeIni: complex.timeIni,
                  timeEnd: complex.timeEnd,
                  address: address,
                  locLongitude: complex.locLongitude,
                  locLatitude: complex.locLatitude,
                  createdAt: complex.createdAt,
                  updatedAt: complex.updatedAt,
                );
              }),
            ),
          );
        case Error<List<ComplexApiModel>>():
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
