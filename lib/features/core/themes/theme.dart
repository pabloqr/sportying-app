import 'package:flutter/material.dart';
import 'package:sportying_app/features/core/themes/text_theme.dart';

class ClientTheme extends MaterialTheme {
  ClientTheme() : super();

  // Colores base del diseño
  static const Color _primaryOrange = Color(0xFFFF6700);
  static const Color _secondaryGreen = Color(0xFF55AF79);
  static const Color _tertiaryMagenta = Color(0xFF851967);
  static const Color _backgroundLight = Color(0xFFf4eee6);
  static const Color _textDark = Color(0xFF110701);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,

      // Primary colors
      primary: _primaryOrange,
      surfaceTint: _primaryOrange,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFFFDBCC), // Naranja claro
      onPrimaryContainer: Color(0xFFFF5914),

      // Secondary colors
      secondary: _secondaryGreen,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFD7F5E3), // Verde claro
      onSecondaryContainer: Color(0xFF259351),

      // Tertiary colors
      tertiary: _tertiaryMagenta,
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFFFD7F2), // Magenta claro
      onTertiaryContainer: Color(0xFFBD007F),

      // Error colors
      error: Color(0xFFBA1A1A),
      onError: Colors.white,
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFFBD1200),

      // Surface colors (con tinte cálido anaranjado)
      surface: _backgroundLight, // Fondo con tinte naranja cálido
      onSurface: _textDark,
      onSurfaceVariant: Color(0xFF4A3E35),
      outline: Color(0xFF7C7067),
      outlineVariant: Color(0xFFCFC4BA),

      // Shadow and scrim
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),

      // Inverse colors
      inverseSurface: Color(0xFF34302A),
      onInverseSurface: Color(0xFFF7F0E8),
      inversePrimary: Color(0xFFFFB68E),

      // Primary fixed colors
      primaryFixed: Color(0xFFFFE8DB),
      onPrimaryFixed: _textDark,
      primaryFixedDim: Color(0xFFFFB68E),
      onPrimaryFixedVariant: Color(0xFFC24E00),

      // Secondary fixed colors
      secondaryFixed: Color(0xFFE8F9EF),
      onSecondaryFixed: _textDark,
      secondaryFixedDim: Color(0xFF8FD4A8),
      onSecondaryFixedVariant: Color(0xFF3A8A5B),

      // Tertiary fixed colors
      tertiaryFixed: Color(0xFFFFE5F7),
      onTertiaryFixed: _textDark,
      tertiaryFixedDim: Color(0xFFFFACE8),
      onTertiaryFixedVariant: Color(0xFF64134E),

      // Surface container colors (más claros que el fondo, con tinte naranja cálido)
      surfaceDim: Color(0xFFEDE7E0),
      surfaceBright: _backgroundLight,
      surfaceContainerLowest: Color(0xFFFFFFFD),
      surfaceContainerLow: Color(0xFFFDFDFB),
      surfaceContainer: Color(0xFFFaF8F4),
      surfaceContainerHigh: Color(0xFFF9F5F1),
      surfaceContainerHighest: Color(0xFFF7F3ED),
    );
  }

  ThemeData get light => theme(lightScheme());
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
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
    cardTheme: CardThemeData(color: colorScheme.surfaceContainerLowest, surfaceTintColor: colorScheme.surfaceTint),
    appBarTheme: AppBarThemeData(surfaceTintColor: colorScheme.surfaceContainerLowest),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: colorScheme.surfaceContainerLowest,
      indicatorColor: colorScheme.primaryContainer,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: colorScheme.onPrimaryContainer);
        }
        return IconThemeData(color: colorScheme.onSurfaceVariant);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(color: colorScheme.primary, fontSize: 12, fontWeight: FontWeight.w600);
        }
        return TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12);
      }),
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
