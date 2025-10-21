import 'package:flutter/material.dart';

enum HeaderContainer { card, none }

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
  final HeaderContainer container;

  final String title;
  final String? buttonLabel;
  final IconData? icon;
  final VoidCallback? onPressed;

  final _HeaderType _headerType;

  const Header._(this._headerType, this.container, this.title, this.buttonLabel, this.icon, this.onPressed);

  factory Header.subheader({
    required HeaderContainer container,
    required String subheaderText,
    String? buttonText,
    IconData? icon,
    VoidCallback? onPressed,
  }) => Header._(_HeaderType.subheader, container, subheaderText, buttonText, icon, onPressed);

  factory Header.subSubheader({
    required HeaderContainer container,
    required String subheaderText,
    String? buttonText,
    IconData? icon,
    VoidCallback? onPressed,
  }) => Header._(_HeaderType.subSubheader, container, subheaderText, buttonText, icon, onPressed);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final content = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: _headerType.textTheme(context)),
        if (icon != null || buttonLabel != null)
          if (icon != null && buttonLabel != null)
            TextButton.icon(
              style: ButtonStyle(
                overlayColor: WidgetStatePropertyAll(colorScheme.onPrimary.withAlpha(25)),
                foregroundColor: WidgetStatePropertyAll(colorScheme.onPrimary),
              ),
              onPressed: onPressed,
              iconAlignment: IconAlignment.end,
              icon: Icon(icon, size: 24, fill: 0, weight: 400, grade: 0, opticalSize: 24),
              label: Text(buttonLabel ?? 'Text'),
            )
          else if (buttonLabel != null)
            TextButton(
              style: ButtonStyle(
                overlayColor: WidgetStatePropertyAll(colorScheme.onPrimary.withAlpha(25)),
                foregroundColor: WidgetStatePropertyAll(colorScheme.onPrimary),
              ),
              onPressed: onPressed,
              child: Text(buttonLabel ?? 'Text'),
            )
          else
            Icon(icon, size: 24, fill: 0, weight: 400, grade: 0, opticalSize: 24),
      ],
    );

    return container == HeaderContainer.card
        ? Material(
            color: colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12.0),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsetsGeometry.symmetric(vertical: 8.0, horizontal: 16.0),
                child: content,
              ),
            ),
          )
        : content;
  }
}
