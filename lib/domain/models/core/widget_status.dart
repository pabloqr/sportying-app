import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sportying_app/features/core/themes/theme_old.dart';

enum WidgetStatus { neutralSurface, neutralCard, alert, success, error }

extension WidgetStatusColor on WidgetStatus {
  Color colorSurface(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;

    switch (this) {
      case WidgetStatus.neutralSurface:
        return colorScheme.surfaceContainer;
      case WidgetStatus.neutralCard:
        return colorScheme.surface;
      case WidgetStatus.alert:
        if (brightness == Brightness.light) {
          return MaterialTheme.warning.light.colorContainer;
        } else {
          return MaterialTheme.warning.dark.colorContainer;
        }
      case WidgetStatus.success:
        if (brightness == Brightness.light) {
          return MaterialTheme.success.light.colorContainer;
        } else {
          return MaterialTheme.success.dark.colorContainer;
        }
      case WidgetStatus.error:
        return colorScheme.errorContainer;
    }
  }

  Color colorOnSurface(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;

    switch (this) {
      case WidgetStatus.neutralSurface:
        return colorScheme.onSurface;
      case WidgetStatus.neutralCard:
        return colorScheme.onSurface;
      case WidgetStatus.alert:
        if (brightness == Brightness.light) {
          return MaterialTheme.warning.light.onColorContainer;
        } else {
          return MaterialTheme.warning.dark.onColorContainer;
        }
      case WidgetStatus.success:
        if (brightness == Brightness.light) {
          return MaterialTheme.success.light.onColorContainer;
        } else {
          return MaterialTheme.success.dark.onColorContainer;
        }
      case WidgetStatus.error:
        return colorScheme.onErrorContainer;
    }
  }

  IconData get icon {
    switch (this) {
      case WidgetStatus.neutralSurface:
      case WidgetStatus.neutralCard:
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
