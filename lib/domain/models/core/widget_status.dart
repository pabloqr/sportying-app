import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum WidgetStatus { neutral, neutralTranslucent, alert, success, error }

extension WidgetStatusColor on WidgetStatus {
  Color colorSurface(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;

    switch (this) {
      case WidgetStatus.neutral:
        return brightness == Brightness.light ? colorScheme.tertiary : colorScheme.tertiaryContainer;
      case WidgetStatus.neutralTranslucent:
        return brightness == Brightness.light ? Colors.white.withAlpha(50) : Colors.black.withAlpha(50);
      case WidgetStatus.alert:
        return colorScheme.primary;
      case WidgetStatus.success:
        return colorScheme.secondaryContainer;
      case WidgetStatus.error:
        return colorScheme.error;
    }
  }

  Color colorOnSurface(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;

    switch (this) {
      case WidgetStatus.neutral:
        return brightness == Brightness.light ? colorScheme.onTertiary : colorScheme.onTertiaryContainer;
      case WidgetStatus.neutralTranslucent:
        return brightness == Brightness.light ? colorScheme.surface : colorScheme.onSurface;
      case WidgetStatus.alert:
        return colorScheme.onPrimary;
      case WidgetStatus.success:
        return colorScheme.onSecondaryContainer;
      case WidgetStatus.error:
        return colorScheme.onError;
    }
  }

  IconData get icon {
    switch (this) {
      case WidgetStatus.neutral:
      case WidgetStatus.neutralTranslucent:
        return Symbols.info_rounded;
      case WidgetStatus.alert:
        return Symbols.warning_rounded;
      case WidgetStatus.success:
        return Symbols.check_circle_rounded;
      case WidgetStatus.error:
        return Symbols.error_outline_rounded;
    }
  }
}
