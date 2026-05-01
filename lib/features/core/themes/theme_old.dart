import 'package:flutter/material.dart';
import 'package:sportying_app/features/core/themes/text_theme.dart';

class MaterialTheme {
  final TextTheme textTheme;

  MaterialTheme() : textTheme = textThemeDefinition;

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff006a65),
      surfaceTint: Color(0xff006a65),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9df1eb),
      onPrimaryContainer: Color(0xff00504c),
      secondary: Color(0xff4a6361),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcce8e5),
      onSecondaryContainer: Color(0xff324b49),
      tertiary: Color(0xff48607b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffd0e4ff),
      onTertiaryContainer: Color(0xff304962),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff4fbf9),
      // surface: Color(0xffeff5f3),
      onSurface: Color(0xff161d1c),
      onSurfaceVariant: Color(0xff3f4948),
      outline: Color(0xff6f7978),
      outlineVariant: Color(0xffbec9c7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xff80d5cf),
      primaryFixed: Color(0xff9df1eb),
      onPrimaryFixed: Color(0xff00201e),
      primaryFixedDim: Color(0xff80d5cf),
      onPrimaryFixedVariant: Color(0xff00504c),
      secondaryFixed: Color(0xffcce8e5),
      onSecondaryFixed: Color(0xff051f1e),
      secondaryFixedDim: Color(0xffb0ccc9),
      onSecondaryFixedVariant: Color(0xff324b49),
      tertiaryFixed: Color(0xffd0e4ff),
      onTertiaryFixed: Color(0xff001d34),
      tertiaryFixedDim: Color(0xffb0c9e7),
      onTertiaryFixedVariant: Color(0xff304962),
      surfaceDim: Color(0xffd5dbda),
      surfaceBright: Color(0xfff4fbf9),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f3),
      surfaceContainer: Color(0xffe9efed),
      surfaceContainerHigh: Color(0xffe3e9e8),
      surfaceContainerHighest: Color(0xffdde4e2),
      // surfaceDim: Color(0xffd5dbda),
      // surfaceBright: Color(0xffeff5f3),
      // surfaceContainerLowest: Color(0xffffffff),
      // surfaceContainerLow: Color(0xfffafdfc),
      // surfaceContainer: Color(0xfff8fcfb),
      // surfaceContainerHigh: Color(0xfff6fbfa),
      // surfaceContainerHighest: Color(0xfff4fbf9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003d3a),
      surfaceTint: Color(0xff006a65),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff197974),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff213a39),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff58726f),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff1f3850),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff576f8a),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fbf9),
      onSurface: Color(0xff0c1212),
      onSurfaceVariant: Color(0xff2e3837),
      outline: Color(0xff4a5453),
      outlineVariant: Color(0xff656f6e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xff80d5cf),
      primaryFixed: Color(0xff197974),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff005f5b),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff58726f),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff405957),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff576f8a),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff3f5771),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc1c8c6),
      surfaceBright: Color(0xfff4fbf9),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f3),
      surfaceContainer: Color(0xffe3e9e8),
      surfaceContainerHigh: Color(0xffd8dedd),
      surfaceContainerHighest: Color(0xffccd3d1),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003230),
      surfaceTint: Color(0xff006a65),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff00524f),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff17302e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff354e4c),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff142e46),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff334b64),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fbf9),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff242e2d),
      outlineVariant: Color(0xff414b4a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xff80d5cf),
      primaryFixed: Color(0xff00524f),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003a37),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff354e4c),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff1e3735),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff334b64),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff1b344d),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb4bab9),
      surfaceBright: Color(0xfff4fbf9),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffecf2f0),
      surfaceContainer: Color(0xffdde4e2),
      surfaceContainerHigh: Color(0xffcfd6d4),
      surfaceContainerHighest: Color(0xffc1c8c6),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff80d5cf),
      surfaceTint: Color(0xff80d5cf),
      onPrimary: Color(0xff003734),
      primaryContainer: Color(0xff00504c),
      onPrimaryContainer: Color(0xff9df1eb),
      secondary: Color(0xffb0ccc9),
      onSecondary: Color(0xff1b3533),
      secondaryContainer: Color(0xff324b49),
      onSecondaryContainer: Color(0xffcce8e5),
      tertiary: Color(0xffb0c9e7),
      onTertiary: Color(0xff19324a),
      tertiaryContainer: Color(0xff304962),
      onTertiaryContainer: Color(0xffd0e4ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1514),
      onSurface: Color(0xffdde4e2),
      onSurfaceVariant: Color(0xffbec9c7),
      outline: Color(0xff889391),
      outlineVariant: Color(0xff3f4948),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e2),
      inversePrimary: Color(0xff006a65),
      primaryFixed: Color(0xff9df1eb),
      onPrimaryFixed: Color(0xff00201e),
      primaryFixedDim: Color(0xff80d5cf),
      onPrimaryFixedVariant: Color(0xff00504c),
      secondaryFixed: Color(0xffcce8e5),
      onSecondaryFixed: Color(0xff051f1e),
      secondaryFixedDim: Color(0xffb0ccc9),
      onSecondaryFixedVariant: Color(0xff324b49),
      tertiaryFixed: Color(0xffd0e4ff),
      onTertiaryFixed: Color(0xff001d34),
      tertiaryFixedDim: Color(0xffb0c9e7),
      onTertiaryFixedVariant: Color(0xff304962),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff343a3a),
      surfaceContainerLowest: Color(0xff090f0f),
      surfaceContainerLow: Color(0xff161d1c),
      surfaceContainer: Color(0xff1a2120),
      surfaceContainerHigh: Color(0xff252b2a),
      surfaceContainerHighest: Color(0xff2f3635),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff96ebe5),
      surfaceTint: Color(0xff80d5cf),
      onPrimary: Color(0xff002b29),
      primaryContainer: Color(0xff489e98),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffc6e2df),
      onSecondary: Color(0xff102a28),
      secondaryContainer: Color(0xff7b9693),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffc6dffe),
      onTertiary: Color(0xff0c273f),
      tertiaryContainer: Color(0xff7b93af),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1514),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd4dedd),
      outline: Color(0xffaab4b2),
      outlineVariant: Color(0xff889291),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e2),
      inversePrimary: Color(0xff00514d),
      primaryFixed: Color(0xff9df1eb),
      onPrimaryFixed: Color(0xff001413),
      primaryFixedDim: Color(0xff80d5cf),
      onPrimaryFixedVariant: Color(0xff003d3a),
      secondaryFixed: Color(0xffcce8e5),
      onSecondaryFixed: Color(0xff001413),
      secondaryFixedDim: Color(0xffb0ccc9),
      onSecondaryFixedVariant: Color(0xff213a39),
      tertiaryFixed: Color(0xffd0e4ff),
      onTertiaryFixed: Color(0xff001224),
      tertiaryFixedDim: Color(0xffb0c9e7),
      onTertiaryFixedVariant: Color(0xff1f3850),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff3f4645),
      surfaceContainerLowest: Color(0xff040808),
      surfaceContainerLow: Color(0xff181f1e),
      surfaceContainer: Color(0xff232928),
      surfaceContainerHigh: Color(0xff2d3433),
      surfaceContainerHighest: Color(0xff383f3e),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffabfff8),
      surfaceTint: Color(0xff80d5cf),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff7dd1cb),
      onPrimaryContainer: Color(0xff000e0d),
      secondary: Color(0xffd9f6f2),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffadc8c5),
      onSecondaryContainer: Color(0xff000e0d),
      tertiary: Color(0xffe8f1ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffacc5e3),
      onTertiaryContainer: Color(0xff000c1a),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff0e1514),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffe8f2f0),
      outlineVariant: Color(0xffbac5c3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e2),
      inversePrimary: Color(0xff00514d),
      primaryFixed: Color(0xff9df1eb),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff80d5cf),
      onPrimaryFixedVariant: Color(0xff001413),
      secondaryFixed: Color(0xffcce8e5),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb0ccc9),
      onSecondaryFixedVariant: Color(0xff001413),
      tertiaryFixed: Color(0xffd0e4ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffb0c9e7),
      onTertiaryFixedVariant: Color(0xff001224),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff4b5150),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1a2120),
      surfaceContainer: Color(0xff2b3231),
      surfaceContainerHigh: Color(0xff363d3c),
      surfaceContainerHighest: Color(0xff414847),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(bodyColor: colorScheme.onSurface, displayColor: colorScheme.onSurface),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  static const success = ExtendedColor(
    seed: Color(0xff228b22),
    value: Color(0xff008a52),
    light: ColorFamily(
      color: Color(0xff2b6a46),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffaff2c4),
      onColorContainer: Color(0xff0c5130),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff2b6a46),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffaff2c4),
      onColorContainer: Color(0xff0c5130),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff2b6a46),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffaff2c4),
      onColorContainer: Color(0xff0c5130),
    ),
    dark: ColorFamily(
      color: Color(0xff94d5a9),
      onColor: Color(0xff00391f),
      colorContainer: Color(0xff0c5130),
      onColorContainer: Color(0xffaff2c4),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xff94d5a9),
      onColor: Color(0xff00391f),
      colorContainer: Color(0xff0c5130),
      onColorContainer: Color(0xffaff2c4),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xff94d5a9),
      onColor: Color(0xff00391f),
      colorContainer: Color(0xff0c5130),
      onColorContainer: Color(0xffaff2c4),
    ),
  );

  static const warning = ExtendedColor(
    seed: Color(0xfff6d55c),
    value: Color(0xffdedc68),
    light: ColorFamily(
      color: Color(0xff626117),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffe9e78e),
      onColorContainer: Color(0xff4a4900),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff626117),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffe9e78e),
      onColorContainer: Color(0xff4a4900),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff626117),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffe9e78e),
      onColorContainer: Color(0xff4a4900),
    ),
    dark: ColorFamily(
      color: Color(0xffcccb75),
      onColor: Color(0xff333200),
      colorContainer: Color(0xff4a4900),
      onColorContainer: Color(0xffe9e78e),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffcccb75),
      onColor: Color(0xff333200),
      colorContainer: Color(0xff4a4900),
      onColorContainer: Color(0xffe9e78e),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffcccb75),
      onColor: Color(0xff333200),
      colorContainer: Color(0xff4a4900),
      onColorContainer: Color(0xffe9e78e),
    ),
  );

  List<ExtendedColor> get extendedColors => [success, warning];
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
