import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:sportying_app/core/utils/command.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/repositories/complexes/complexes_repository.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';

class ClientExploreViewModel extends ChangeNotifier {
  final _log = Logger('ClientExploreViewModel');

  ClientExploreViewModel({required ComplexesRepository complexesRepository})
    : _complexesRepository = complexesRepository {
    load = Command0(_load)..execute();
  }

  final ComplexesRepository _complexesRepository;

  List<Complex> _complexes = [];
  UnmodifiableListView<Complex> get complexes => UnmodifiableListView(_complexes);

  late Command0<void> load;

  Future<Result> _load() async {
    // Obtener los complejos almacenados en el sistema
    final complexesResult = await _complexesRepository.getComplexes();
    // Obtener el resultado de la operación
    switch (complexesResult) {
      case Ok<List<Complex>>():
        _log.fine('Loaded complexes.');

        // Actualizar la lista de complejos almacenados en el sistema
        _complexes = complexesResult.value;
        notifyListeners();
        break;
      case Error<List<Complex>>():
        _log.warning('Failed to load complexes.');
        break;
    }

    return complexesResult;
  }
}
