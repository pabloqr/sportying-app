import 'package:flutter/material.dart';
import 'package:sportying_app/features/core/widgets/utils/marquee_widget.dart';

class LabeledInfoWidget extends StatelessWidget {
  const LabeledInfoWidget({
    super.key,
    this.showIcon = true,
    this.icon,
    this.filledIcon = false,
    required this.label,
    required this.text,
  });

  final bool showIcon;
  final IconData? icon;
  final bool filledIcon;
  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      spacing: 8.0,
      children: [
        if (showIcon)
          Icon(
            icon,
            size: 18,
            fill: filledIcon ? 1.0 : 0.0,
            weight: 400,
            grade: 0,
            opticalSize: 18,
            color: colorScheme.onSurfaceVariant,
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MarqueeWidget(
                child: Text(
                  label.toUpperCase(),
                  style: textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant),
                  softWrap: false,
                ),
              ),
              MarqueeWidget(
                child: Text(text, style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface), softWrap: false),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
