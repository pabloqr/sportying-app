import 'package:flutter/material.dart';
import 'package:sportying_app/features/core/themes/text_theme.dart';

class AdminTheme extends MaterialTheme {
  AdminTheme() : super();

  // Colores base del diseño
  static const Color _primaryBlue = Color(0xFF004961);
  static const Color _secondaryTurquoise = Color(0xFF57BCA3);
  static const Color _tertiaryDarkBlue = Color(0xFF002E3D);
  static const Color _backgroundLight = Color(0xFFE8F4F7);
  static const Color _textDark = Color(0xFF08151B);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,

      // Primary colors
      primary: _primaryBlue,
      surfaceTint: _primaryBlue,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFC2E7F5),
      onPrimaryContainer: Color(0xFF187395),

      // Secondary colors
      secondary: _secondaryTurquoise,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFD3F3E9),
      onSecondaryContainer: Color(0xFF27906F),

      // Tertiary colors
      tertiary: _tertiaryDarkBlue,
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFB3D9E8),
      onTertiaryContainer: Color(0xFF26657d),

      // Error colors
      error: Color(0xFFBA1A1A),
      onError: Colors.white,
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFFbd1200),

      // Surface colors
      surface: _backgroundLight,
      onSurface: _textDark,
      onSurfaceVariant: Color(0xFF3E4A50),
      outline: Color(0xFF6E787E),
      outlineVariant: Color(0xFFBEC8CE),

      // Shadow and scrim
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),

      // Inverse colors
      inverseSurface: Color(0xFF2B3539),
      onInverseSurface: Color(0xFFEBF3F6),
      inversePrimary: Color(0xFF81CEE8),

      // Primary fixed colors
      primaryFixed: Color(0xFFD6EFFA),
      onPrimaryFixed: _textDark,
      primaryFixedDim: Color(0xFF81CEE8),
      onPrimaryFixedVariant: Color(0xFF003547),

      // Secondary fixed colors
      secondaryFixed: Color(0xFFE5F8F1),
      onSecondaryFixed: _textDark,
      secondaryFixedDim: Color(0xFF8DD9C3),
      onSecondaryFixedVariant: Color(0xFF3A8F7B),

      // Tertiary fixed colors
      tertiaryFixed: Color(0xFFCCE5F2),
      onTertiaryFixed: _textDark,
      tertiaryFixedDim: Color(0xFF99CCDF),
      onTertiaryFixedVariant: Color(0xFF00202C),

      // Surface container colors
      surfaceDim: Color(0xFFDCE9ED),
      surfaceBright: _backgroundLight,
      surfaceContainerLowest: Color(0xFFFFFFFE),
      surfaceContainerLow: Color(0xFFF8FCFD),
      surfaceContainer: Color(0xFFF2F9FB),
      surfaceContainerHigh: Color(0xFFEDF6F9),
      surfaceContainerHighest: Color(0xFFEAF4F8),
    );
  }

  ThemeData get light => theme(lightScheme());
}

class ClientTheme extends MaterialTheme {
  ClientTheme() : super();

  static const primaryDim = Color(0xFFBDAA00);

  // Colores base de la paleta clara
  static const Color _primaryLight = Color(0xFFFFEB38);
  static const Color _secondaryLight = Color(0xFF004961);
  static const Color _tertiaryLight = Color(0xFF570531);
  static const Color _backgroundLight = Color(0xFFF5F3E8);
  static const Color _textLight = Color(0xFF18170C);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,

      // Primary colors
      primary: _primaryLight,
      surfaceTint: _primaryLight,
      onPrimary: Color(0xFF3C3500),
      primaryContainer: Color(0xFFfff7ad),
      onPrimaryContainer: Color(0xFF5C5000),

      // Secondary colors
      secondary: _secondaryLight,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFB3E5FC),
      onSecondaryContainer: Color(0xFF033A53),

      // Tertiary colors
      tertiary: _tertiaryLight,
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFFFD7EE),
      onTertiaryContainer: Color(0xFF5C0035),

      // Error colors
      error: Color(0xFFBA1A1A),
      onError: Colors.white,
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),

      // Surface colors
      surface: _backgroundLight,
      onSurface: _textLight,
      onSurfaceVariant: Color(0xFF48463A),
      outline: Color(0xFF79766A),
      outlineVariant: Color(0xFFCAC7BB),

      // Shadow and scrim
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),

      // Inverse colors
      inverseSurface: Color(0xFF32312A),
      onInverseSurface: Color(0xFFF7F4E8),
      inversePrimary: Color(0xFFE5D070),

      // Primary fixed colors
      primaryFixed: Color(0xFFFFFBE6),
      onPrimaryFixed: _textLight,
      primaryFixedDim: Color(0xFFE5D070),
      onPrimaryFixedVariant: Color(0xFF5A5100),

      // Secondary fixed colors
      secondaryFixed: Color(0xFFD6F6FF),
      onSecondaryFixed: _textLight,
      secondaryFixedDim: Color(0xFF7DD5F7),
      onSecondaryFixedVariant: Color(0xFF003546),

      // Tertiary fixed colors
      tertiaryFixed: Color(0xFFFFE5F3),
      onTertiaryFixed: _textLight,
      tertiaryFixedDim: Color(0xFFFFB0DC),
      onTertiaryFixedVariant: Color(0xFF420028),

      // Surface container colors
      surfaceDim: Color(0xFFECEADF),
      surfaceBright: Color(0xFFFFFFFD),
      surfaceContainerLowest: Color(0xFFFFFFFD),
      surfaceContainerLow: Color(0xFFFCFAF3),
      surfaceContainer: Color(0xFFF9F7ED),
      surfaceContainerHigh: Color(0xFFF7F5EB),
      surfaceContainerHighest: Color(0xFFF6F4EA),
    );
  }

  // Colores base de la paleta oscura
  static const Color _primaryDark = Color(0xFFC7B300);
  static const Color _secondaryDark = Color(0xFF9EE7FF);
  static const Color _tertiaryDark = Color(0xFFFAA8D4);
  static const Color _backgroundDark = Color(0xFF040301);
  static const Color _textDark = Color(0xFFF3F2E7);

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,

      // Primary colors
      primary: _primaryDark,
      surfaceTint: _primaryDark,
      onPrimary: Color(0xFF3C3500),
      primaryContainer: Color(0xFF5A5100),
      onPrimaryContainer: Color(0xFFFFF7C2),

      // Secondary colors
      secondary: _secondaryDark,
      onSecondary: Color(0xFF001E29),
      secondaryContainer: Color(0xFF003546),
      onSecondaryContainer: Color(0xFFB3E5FC),

      // Tertiary colors
      tertiary: _tertiaryDark,
      onTertiary: Color(0xFF330022),
      tertiaryContainer: Color(0xFF420028),
      onTertiaryContainer: Color(0xFFFFD7EE),

      // Error colors
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Color(0xFFFFDAD6),

      // Surface colors
      surface: _backgroundDark,
      onSurface: _textDark,
      onSurfaceVariant: Color(0xFFCAC7BB),
      outline: Color(0xFF939085),
      outlineVariant: Color(0xFF48463A),

      // Shadow and scrim
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),

      // Inverse colors
      inverseSurface: Color(0xFFF7F4E8),
      onInverseSurface: Color(0xFF32312A),
      inversePrimary: Color(0xFFFFEB38),

      // Primary fixed colors
      primaryFixed: Color(0xFFFFFBE6),
      onPrimaryFixed: Color(0xFF3C3500),
      primaryFixedDim: Color(0xFFE5D070),
      onPrimaryFixedVariant: Color(0xFF5A5100),

      // Secondary fixed colors
      secondaryFixed: Color(0xFFD6F6FF),
      onSecondaryFixed: Color(0xFF001E29),
      secondaryFixedDim: Color(0xFF7DD5F7),
      onSecondaryFixedVariant: Color(0xFF003546),

      // Tertiary fixed colors
      tertiaryFixed: Color(0xFFFFE5F3),
      onTertiaryFixed: Color(0xFF330022),
      tertiaryFixedDim: Color(0xFFFFB0DC),
      onTertiaryFixedVariant: Color(0xFF420028),

      // Surface container colors
      surfaceDim: _backgroundDark,
      surfaceBright: Color(0xFF2B2A1F),
      surfaceContainerLowest: Color(0xFF000000),
      surfaceContainerLow: Color(0xFF0D0C09),
      surfaceContainer: Color(0xFF11100D),
      surfaceContainerHigh: Color(0xFF1C1B17),
      surfaceContainerHighest: Color(0xFF272622),
    );
  }

  ThemeData get light => theme(lightScheme());
  ThemeData get dark => theme(darkScheme());
}

abstract class MaterialTheme {
  MaterialTheme() : textTheme = textThemeDefinition;

  final TextTheme textTheme;

  static const success = ExtendedColor(
    seed: Color(0xff2e7d32),
    value: Color(0xff2e7d32),
    light: ColorFamily(
      color: Color(0xff0d631b),
      onColor: Color(0xfff4f8f4),
      colorContainer: Color(0xffcbffc2),
      onColorContainer: Color(0xff2e7d32),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff000000),
      onColor: Color(0xff000000),
      colorContainer: Color(0xff000000),
      onColorContainer: Color(0xff000000),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff000000),
      onColor: Color(0xff000000),
      colorContainer: Color(0xff000000),
      onColorContainer: Color(0xff000000),
    ),
    dark: ColorFamily(
      color: Color(0xff88d982),
      onColor: Color(0xff003909),
      colorContainer: Color(0xff2e7d32),
      onColorContainer: Color(0xffcbffc2),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xff000000),
      onColor: Color(0xff000000),
      colorContainer: Color(0xff000000),
      onColorContainer: Color(0xff000000),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xff000000),
      onColor: Color(0xff000000),
      colorContainer: Color(0xff000000),
      onColorContainer: Color(0xff000000),
    ),
  );

  List<ExtendedColor> get extendedColors => [success];

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(bodyColor: colorScheme.onSurface, displayColor: colorScheme.onSurface),
    textSelectionTheme: TextSelectionThemeData(cursorColor: colorScheme.outline),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
    navigationRailTheme: NavigationRailThemeData(
      indicatorColor: colorScheme.primary,
      selectedIconTheme: IconThemeData(color: colorScheme.onPrimary),
    ),
    navigationBarTheme: NavigationBarThemeData(
      elevation: 0.0,
      backgroundColor: colorScheme.brightness == Brightness.light
          ? colorScheme.surfaceContainerLowest
          : colorScheme.surfaceContainerHigh,
      indicatorColor: colorScheme.primary,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: colorScheme.onPrimary);
        }
        return IconThemeData(color: colorScheme.onSurfaceVariant);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            color: colorScheme.brightness == Brightness.light ? colorScheme.onPrimary : colorScheme.primary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          );
        }
        return TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12);
      }),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 0.0,
      splashColor: colorScheme.onPrimary.withAlpha(25),
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
    ),
  );
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
