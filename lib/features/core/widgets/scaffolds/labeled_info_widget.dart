import 'package:flutter/material.dart';
import 'package:sportying_app/features/core/widgets/utils/marquee_widget.dart';

class LabeledInfoWidget extends StatelessWidget {
  final Brightness brightness;

  final bool showIcon;
  final IconData? icon;
  final bool filledIcon;
  final String label;
  final String text;

  const LabeledInfoWidget._(this.brightness, this.showIcon, this.icon, this.filledIcon, this.label, this.text);

  factory LabeledInfoWidget.light({
    bool showIcon = true,
    IconData? icon,
    bool filledIcon = false,
    required String label,
    required String text,
  }) => LabeledInfoWidget._(Brightness.light, showIcon, icon, filledIcon, label, text);

  factory LabeledInfoWidget.dark({
    bool showIcon = true,
    IconData? icon,
    bool filledIcon = false,
    required String label,
    required String text,
  }) => LabeledInfoWidget._(Brightness.dark, showIcon, icon, filledIcon, label, text);

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
            color: brightness == Brightness.light ? colorScheme.outlineVariant : colorScheme.onSurfaceVariant,
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MarqueeWidget(
                child: Text(
                  label,
                  style: textTheme.labelSmall?.copyWith(
                    color: brightness == Brightness.light ? colorScheme.outlineVariant : colorScheme.onSurfaceVariant,
                  ),
                  softWrap: false,
                ),
              ),
              MarqueeWidget(
                child: Text(
                  text,
                  style: textTheme.bodyLarge?.copyWith(
                    color: brightness == Brightness.light ? colorScheme.surface : colorScheme.onSurface,
                  ),
                  softWrap: false,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
