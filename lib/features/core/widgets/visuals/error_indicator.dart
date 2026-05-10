import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({super.key, required this.title, required this.label, required this.onPressed});

  final String title;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IntrinsicWidth(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Symbols.error_outline_rounded,
                      size: 24,
                      fill: 0,
                      weight: 400,
                      grade: 0,
                      opticalSize: 24,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(width: 10),
                    Text(title, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          FilledButton.icon(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.errorContainer),
              foregroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.onErrorContainer),
            ),
            icon: Icon(Symbols.refresh_rounded, size: 24, fill: 0, weight: 400, grade: 0, opticalSize: 24),
            label: Text(label),
          ),
        ],
      ),
    );
  }
}
