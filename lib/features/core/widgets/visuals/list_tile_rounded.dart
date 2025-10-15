import 'package:flutter/material.dart';

class ListTileRounded extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Widget? trailing;

  final Color? contentColor;

  final VoidCallback onTap;

  const ListTileRounded({
    super.key,
    required this.title,
    this.icon,
    this.trailing,
    this.contentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(1000),
      child: InkWell(
        borderRadius: BorderRadius.circular(1000),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            spacing: 16.0,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  size: 24,
                  fill: 0,
                  weight: 400,
                  grade: 0,
                  opticalSize: 24,
                  color: contentColor ?? colorScheme.onSurfaceVariant,
                ),
              Expanded(
                child: Text(
                  title,
                  style: textTheme.bodyLarge?.copyWith(color: contentColor ?? colorScheme.onSurfaceVariant),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
