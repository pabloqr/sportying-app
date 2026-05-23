import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/repositories/complexes/complexes_repository.dart';
import 'package:sportying_app/data/services/remote/complexes/complexes_remote_service.dart';
import 'package:sportying_app/data/services/remote/complexes/models/complex_dto.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';

class MockComplexesRemoteService extends Mock implements ComplexesRemoteService {}

void main() {
  late MockComplexesRemoteService remoteService;
  late ComplexesRepositoryImpl repository;

  setUp(() {
    remoteService = MockComplexesRemoteService();
    repository = ComplexesRepositoryImpl(remoteService: remoteService);
  });

  final now = DateTime.now();
  final complexDto = ComplexDto(
    id: 1,
    name: 'Complex 1',
    timeIni: '08:00',
    timeEnd: '22:00',
    locLatitude: 40.0,
    locLongitude: -3.0,
    sports: ['football'],
    createdAt: now,
    updatedAt: now,
  );

  group('ComplexesRepositoryImpl Tests', () {
    test('getComplexes success returns mapped complexes with default address', () async {
      when(() => remoteService.getComplexes(any())).thenAnswer((_) async => Result.ok([complexDto]));

      final result = await repository.getComplexes();

      expect(result, isA<Ok<List<Complex>>>());
      final list = (result as Ok<List<Complex>>).value;
      expect(list.length, equals(1));
      expect(list[0].id, equals(1));
      expect(list[0].name, equals('Complex 1'));
      // In testing env, getAddressFromLatLng throws and falls back to:
      expect(list[0].address, equals('No address provided'));

      verify(() => remoteService.getComplexes(any())).called(1);
    });

    test('getComplexes failure returns error', () async {
      final exception = Exception('Network error');
      when(() => remoteService.getComplexes(any())).thenAnswer((_) async => Result.error(exception));

      final result = await repository.getComplexes();

      expect(result, isA<Error<List<Complex>>>());
      expect((result as Error).error, equals(exception));

      verify(() => remoteService.getComplexes(any())).called(1);
    });

    test('getComplexes returns thrown remote failures as errors', () async {
      final exception = Exception('Connection failed');
      when(() => remoteService.getComplexes(any())).thenThrow(exception);

      final result = await repository.getComplexes();

      expect((result as Error<List<Complex>>).error, same(exception));
    });
  });
}
