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

  // Colores base del diseño
  static const Color _primaryOrange = Color(0xFFFF6700);
  static const Color _secondaryGreen = Color(0xFF55AF79);
  static const Color _tertiaryMagenta = Color(0xFF851967);
  static const Color _backgroundLight = Color(0xFFF4EEE6);
  static const Color _textDark = Color(0xFF110701);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,

      // Primary colors
      primary: _primaryOrange,
      surfaceTint: _primaryOrange,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFFFDBCC),
      onPrimaryContainer: Color(0xFFFF5914),

      // Secondary colors
      secondary: _secondaryGreen,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFD7F5E3),
      onSecondaryContainer: Color(0xFF259351),

      // Tertiary colors
      tertiary: _tertiaryMagenta,
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFFFD7F2),
      onTertiaryContainer: Color(0xFFBD007F),

      // Error colors
      error: Color(0xFFBA1A1A),
      onError: Colors.white,
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFFBD1200),

      // Surface colors
      surface: _backgroundLight,
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

      // Surface container colors
      surfaceDim: Color(0xFFEDE7E0),
      surfaceBright: _backgroundLight,
      surfaceContainerLowest: Color(0xFFFFFFFD),
      surfaceContainerLow: Color(0xFFFDFDFB),
      surfaceContainer: Color(0xFFFaF8F4),
      surfaceContainerHigh: Color(0xFFF9F5F1),
      surfaceContainerHighest: Color(0xFFF7F3ED),
    );
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,

      // Primary colors
      primary: Color(0xFFFF6600), // Naranja exacto
      surfaceTint: Color(0xFFFF6600),
      onPrimary: Colors.white,
      primaryContainer: Color(0xFF7D3200),
      onPrimaryContainer: Color(0xFFFFDBCC),

      // Secondary colors
      secondary: Color(0xFF50AA74), // Verde exacto
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFF1E6E46),
      onSecondaryContainer: Color(0xFFD7F5E3),

      // Tertiary colors
      tertiary: Color(0xFFE67AC7), // Magenta exacto
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFF730A56),
      onTertiaryContainer: Color(0xFFFFD7F2),

      // Error colors
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Color(0xFFFFDAD6),

      // Surface colors (con tinte cálido anaranjado oscuro)
      surface: Color(0xFF090401), // Background exacto
      onSurface: Color(0xFFFEF3EC), // Text exacto
      onSurfaceVariant: Color(0xFFCFC4BA),
      outline: Color(0xFF988D83),
      outlineVariant: Color(0xFF4A3E35),

      // Shadow and scrim
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),

      // Inverse colors
      inverseSurface: Color(0xFFF7F0E8),
      onInverseSurface: Color(0xFF34302A),
      inversePrimary: Color(0xFFFF6600),

      // Primary fixed colors
      primaryFixed: Color(0xFFFFE8DB),
      onPrimaryFixed: Color(0xFF331100),
      primaryFixedDim: Color(0xFFFFB68E),
      onPrimaryFixedVariant: Color(0xFF7D3200),

      // Secondary fixed colors
      secondaryFixed: Color(0xFFE8F9EF),
      onSecondaryFixed: Color(0xFF0D3318),
      secondaryFixedDim: Color(0xFF8FD4A8),
      onSecondaryFixedVariant: Color(0xFF1E6E46),

      // Tertiary fixed colors
      tertiaryFixed: Color(0xFFFFE5F7),
      onTertiaryFixed: Color(0xFF330022),
      tertiaryFixedDim: Color(0xFFFFACE8),
      onTertiaryFixedVariant: Color(0xFF730A56),

      // Surface container colors (estándar Material 3 para dark)
      surfaceDim: Color(0xFF090401),
      surfaceBright: Color(0xFF302A25),
      surfaceContainerLowest: Color(0xFF030200),
      surfaceContainerLow: Color(0xFF110C09),
      surfaceContainer: Color(0xFF15100D),
      surfaceContainerHigh: Color(0xFF201A17),
      surfaceContainerHighest: Color(0xFF2B2522),
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

  ThemeData theme(ColorScheme colorScheme) => colorScheme.brightness == Brightness.light
      ? ThemeData(
          useMaterial3: true,
          brightness: colorScheme.brightness,
          colorScheme: colorScheme,
          textTheme: textTheme.apply(bodyColor: colorScheme.onSurface, displayColor: colorScheme.onSurface),
          scaffoldBackgroundColor: colorScheme.surface,
          canvasColor: colorScheme.surface,
          cardTheme: CardThemeData(
            color: colorScheme.surfaceContainerLowest,
            surfaceTintColor: colorScheme.surfaceTint,
          ),
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
        )
      : ThemeData(
          useMaterial3: true,
          brightness: colorScheme.brightness,
          colorScheme: colorScheme,
          textTheme: textTheme.apply(bodyColor: colorScheme.onSurface, displayColor: colorScheme.onSurface),
          scaffoldBackgroundColor: colorScheme.surface,
          canvasColor: colorScheme.surface,
          appBarTheme: AppBarThemeData(surfaceTintColor: colorScheme.surfaceContainerLowest),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: colorScheme.primaryFixedDim,
            foregroundColor: colorScheme.onPrimaryFixedVariant,
          ),
          navigationBarTheme: NavigationBarThemeData(
            indicatorColor: colorScheme.primaryFixedDim,
            iconTheme: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return IconThemeData(color: colorScheme.onPrimaryFixedVariant);
              }
              return IconThemeData(color: colorScheme.onSurfaceVariant);
            }),
            labelTextStyle: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return TextStyle(color: colorScheme.primaryFixedDim, fontSize: 12, fontWeight: FontWeight.w600);
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
