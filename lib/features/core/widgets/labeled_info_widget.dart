import 'package:flutter/material.dart';
import 'package:sportying_app/features/core/widgets/marquee_widget.dart';

class LabeledInfoWidget extends StatelessWidget {
  final IconData icon;
  final bool filledIcon;
  final String label;
  final String text;

  const LabeledInfoWidget({
    super.key,
    required this.icon,
    this.filledIcon = false,
    required this.label,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      spacing: 8.0,
      children: [
        Icon(icon, size: 24, fill: filledIcon ? 1.0 : 0.0, weight: 400, grade: 0, opticalSize: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MarqueeWidget(
                child: Text(
                  label,
                  style: textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant),
                  softWrap: false,
                ),
              ),
              MarqueeWidget(child: Text(text, style: textTheme.bodyMedium, softWrap: false)),
            ],
          ),
        ),
      ],
    );
  }
}
