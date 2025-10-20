import 'package:flutter/material.dart';

enum _HeaderType { subheader, subSubheader }

extension _HeaderTypeExtension on _HeaderType {
  TextStyle? textTheme(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    switch (this) {
      case _HeaderType.subheader:
        return textTheme.titleMedium?.copyWith(fontSize: 18.0);
      case _HeaderType.subSubheader:
        return textTheme.titleSmall;
    }
  }
}

class Header extends StatelessWidget {
  final String subheaderText;
  final bool showButton;
  final String? buttonText;
  final IconData? icon;
  final VoidCallback? onPressed;

  final _HeaderType _headerType;

  const Header._(this._headerType, this.subheaderText, this.showButton, this.buttonText, this.icon, this.onPressed);

  factory Header.subheader({
    required String subheaderText,
    required bool showButton,
    String? buttonText,
    IconData? icon,
    VoidCallback? onPressed,
  }) => Header._(_HeaderType.subheader, subheaderText, showButton, buttonText, icon, onPressed);

  factory Header.subSubheader({
    required String subheaderText,
    required bool showButton,
    String? buttonText,
    IconData? icon,
    VoidCallback? onPressed,
  }) => Header._(_HeaderType.subSubheader, subheaderText, showButton, buttonText, icon, onPressed);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(subheaderText, style: _headerType.textTheme(context)),
        if (showButton)
          if (icon != null)
            TextButton.icon(
              style: ButtonStyle(
                overlayColor: WidgetStatePropertyAll(colorScheme.onPrimary.withAlpha(25)),
                foregroundColor: WidgetStatePropertyAll(colorScheme.onPrimary),
              ),
              onPressed: onPressed,
              iconAlignment: IconAlignment.end,
              icon: Icon(icon, size: 24, fill: 0, weight: 400, grade: 0, opticalSize: 24),
              label: Text(buttonText ?? 'Text'),
            )
          else
            TextButton(
              style: ButtonStyle(
                overlayColor: WidgetStatePropertyAll(colorScheme.onPrimary.withAlpha(25)),
                foregroundColor: WidgetStatePropertyAll(colorScheme.onPrimary),
              ),
              onPressed: onPressed,
              child: Text(buttonText ?? 'Text'),
            ),
      ],
    );
  }
}
