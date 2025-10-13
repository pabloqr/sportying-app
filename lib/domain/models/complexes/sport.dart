import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum Sport { basketball, football, padel, tennis, volleyball }

extension SportsIcon on Sport {
  IconData get icon {
    switch (this) {
      case Sport.basketball:
        return Symbols.sports_basketball_rounded;
      case Sport.football:
        return Symbols.sports_soccer_rounded;
      case Sport.padel:
      case Sport.tennis:
        return Symbols.sports_tennis_rounded;
      case Sport.volleyball:
        return Symbols.sports_volleyball_rounded;
    }
  }
}
