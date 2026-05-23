import 'package:flutter_test/flutter_test.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';

void main() {
  test('each sport exposes its visual icon', () {
    expect(Sport.basketball.icon, equals(Symbols.sports_basketball_rounded));
    expect(Sport.football.icon, equals(Symbols.sports_soccer_rounded));
    expect(Sport.padel.icon, equals(Symbols.sports_tennis_rounded));
    expect(Sport.tennis.icon, equals(Symbols.sports_tennis_rounded));
    expect(Sport.volleyball.icon, equals(Symbols.sports_volleyball_rounded));
  });
}
