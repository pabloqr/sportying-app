import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
// import 'package:sportying_app/features/core/themes/theme_old.dart';

enum WidgetStatus { neutralLight, neutralDark, alert, success, error }

extension WidgetStatusColor on WidgetStatus {
  Color colorSurface(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // final brightness = Theme.of(context).brightness;

    switch (this) {
      case WidgetStatus.neutralLight:
        return colorScheme.tertiary;
      case WidgetStatus.neutralDark:
        return colorScheme.tertiaryContainer;
      case WidgetStatus.alert:
        // if (brightness == Brightness.light) {
        //   return MaterialTheme.warning.light.colorContainer;
        // } else {
        //   return MaterialTheme.warning.dark.colorContainer;
        // }
        return colorScheme.primaryContainer;
      case WidgetStatus.success:
        // if (brightness == Brightness.light) {
        //   return MaterialTheme.success.light.colorContainer;
        // } else {
        //   return MaterialTheme.success.dark.colorContainer;
        // }
        return colorScheme.secondaryContainer;
      case WidgetStatus.error:
        return colorScheme.errorContainer;
    }
  }

  Color colorOnSurface(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // final brightness = Theme.of(context).brightness;

    switch (this) {
      case WidgetStatus.neutralLight:
        return colorScheme.onTertiary;
      case WidgetStatus.neutralDark:
        return colorScheme.onTertiaryContainer;
      case WidgetStatus.alert:
        // if (brightness == Brightness.light) {
        //   return MaterialTheme.warning.light.onColorContainer;
        // } else {
        //   return MaterialTheme.warning.dark.onColorContainer;
        // }
        return colorScheme.onPrimaryContainer;
      case WidgetStatus.success:
        // if (brightness == Brightness.light) {
        //   return MaterialTheme.success.light.onColorContainer;
        // } else {
        //   return MaterialTheme.success.dark.onColorContainer;
        // }
        return colorScheme.onSecondaryContainer;
      case WidgetStatus.error:
        return colorScheme.onErrorContainer;
    }
  }

  IconData get icon {
    switch (this) {
      case WidgetStatus.neutralLight:
      case WidgetStatus.neutralDark:
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
