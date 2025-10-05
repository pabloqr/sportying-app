import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum Sport { tennis, padel, football, volleyball }

extension SportsIcon on Sport {
  IconData get icon {
    switch (this) {
      case Sport.tennis:
      case Sport.padel:
        return Symbols.sports_tennis_rounded;
      case Sport.football:
        return Symbols.sports_soccer_rounded;
      case Sport.volleyball:
        return Symbols.sports_volleyball_rounded;
    }
  }
}
