import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum WidgetStatus { normal, neutral, translucent, alert, success, error }

extension WidgetStatusColor on WidgetStatus {
  Color colorPrimary(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.brightnessOf(context);

    switch (this) {
      case WidgetStatus.normal:
        return colorScheme.primary;
      case WidgetStatus.neutral:
        return brightness == Brightness.light ? colorScheme.surface : colorScheme.surface;
      case WidgetStatus.translucent:
        return brightness == Brightness.light
            ? colorScheme.inverseSurface.withAlpha(50)
            : colorScheme.surface.withAlpha(50);
      case WidgetStatus.alert:
        return colorScheme.tertiary;
      case WidgetStatus.success:
        return colorScheme.secondary;
      case WidgetStatus.error:
        return colorScheme.error;
    }
  }

  Color colorOnPrimary(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.brightnessOf(context);

    switch (this) {
      case WidgetStatus.normal:
        return brightness == Brightness.light ? colorScheme.onPrimary : colorScheme.onPrimary;
      case WidgetStatus.neutral:
        return brightness == Brightness.light ? colorScheme.onPrimary : colorScheme.onPrimary;
      case WidgetStatus.translucent:
        return brightness == Brightness.light ? colorScheme.primary : colorScheme.primary;
      case WidgetStatus.alert:
        return colorScheme.onTertiary;
      case WidgetStatus.success:
        return colorScheme.onSecondary;
      case WidgetStatus.error:
        return colorScheme.onError;
    }
  }

  Color colorSurface(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.brightnessOf(context);

    switch (this) {
      case WidgetStatus.normal:
        return brightness == Brightness.light ? colorScheme.primaryContainer : colorScheme.primaryContainer;
      case WidgetStatus.neutral:
        return brightness == Brightness.light ? colorScheme.surface : colorScheme.surface;
      case WidgetStatus.translucent:
        return brightness == Brightness.light
            ? colorScheme.surface.withAlpha(50)
            : colorScheme.inverseSurface.withAlpha(50);
      case WidgetStatus.alert:
        return colorScheme.tertiaryContainer;
      case WidgetStatus.success:
        return colorScheme.secondaryContainer;
      case WidgetStatus.error:
        return colorScheme.errorContainer;
    }
  }

  Color colorOnSurface(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.brightnessOf(context);

    switch (this) {
      case WidgetStatus.normal:
        return brightness == Brightness.light ? colorScheme.onPrimaryContainer : colorScheme.onPrimaryContainer;
      case WidgetStatus.neutral:
        return brightness == Brightness.light ? colorScheme.onSurface : colorScheme.onSurface;
      case WidgetStatus.translucent:
        return brightness == Brightness.light ? colorScheme.surface : colorScheme.onSurface;
      case WidgetStatus.alert:
        return colorScheme.onTertiaryContainer;
      case WidgetStatus.success:
        return colorScheme.onSecondaryContainer;
      case WidgetStatus.error:
        return colorScheme.onErrorContainer;
    }
  }

  IconData get icon {
    switch (this) {
      case WidgetStatus.normal:
      case WidgetStatus.neutral:
      case WidgetStatus.translucent:
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
