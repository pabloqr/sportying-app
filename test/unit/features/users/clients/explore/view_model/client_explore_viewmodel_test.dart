import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/repositories/complexes/complexes_repository.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';
import 'package:sportying_app/features/users/clients/explore/view_model/client_explore_viewmodel.dart';

class MockComplexesRepository extends Mock implements ComplexesRepository {}

void main() {
  late MockComplexesRepository complexesRepository;
  final now = DateTime.now();

  final complex = Complex(
    id: 1,
    name: 'Complex 1',
    timeIni: '08:00',
    timeEnd: '22:00',
    address: 'Madrid, Spain',
    locLatitude: 40.0,
    locLongitude: -3.0,
    sports: {Sport.football},
    createdAt: now,
    updatedAt: now,
  );

  setUp(() {
    complexesRepository = MockComplexesRepository();
  });

  group('ClientExploreViewModel Tests', () {
    test('Constructor executes load command and updates complexes list on success', () async {
      when(
        () => complexesRepository.getComplexes(query: any(named: 'query')),
      ).thenAnswer((_) async => Result.ok([complex]));

      final viewModel = ClientExploreViewModel(complexesRepository: complexesRepository);

      // Wait for the constructor's asynchronous load to finish
      while (viewModel.load.running) {
        await Future<void>.delayed(Duration.zero);
      }

      expect(viewModel.complexes.length, equals(1));
      expect(viewModel.complexes[0], equals(complex));
      expect(viewModel.load.running, isFalse);
      expect(viewModel.load.error, isFalse);
      expect(viewModel.load.completed, isTrue);

      verify(() => complexesRepository.getComplexes(query: any(named: 'query'))).called(1);
    });

    test('Constructor handles load command failure correctly', () async {
      final exception = Exception('Load failed');
      when(
        () => complexesRepository.getComplexes(query: any(named: 'query')),
      ).thenAnswer((_) async => Result.error(exception));

      final viewModel = ClientExploreViewModel(complexesRepository: complexesRepository);

      while (viewModel.load.running) {
        await Future<void>.delayed(Duration.zero);
      }

      expect(viewModel.complexes, isEmpty);
      expect(viewModel.load.error, isTrue);
      expect(viewModel.load.completed, isFalse);
    });
  });
}
