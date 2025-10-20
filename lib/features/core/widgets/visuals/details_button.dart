import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class DetailsButton extends StatelessWidget {
  const DetailsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Text(label),
        Icon(
          Symbols.chevron_right_rounded,
          size: 24,
          fill: 0,
          weight: 400,
          grade: 0,
          opticalSize: 24,
          // color: colorScheme.onSurfaceVariant,
        ),
      ],
    );
  }
}
