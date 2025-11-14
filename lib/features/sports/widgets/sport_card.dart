import 'package:flutter/material.dart';
import 'package:sportying_app/core/utils/extension_utilities.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';
import 'package:sportying_app/features/core/utils/widget_palette.dart';
import 'package:sportying_app/features/core/widgets/visuals/custom_chip.dart';

class SportCard extends StatelessWidget {
  const SportCard({
    super.key,
    required this.sport,
    this.numCourts,
    this.onTap,
    this.index,
    required this.selectedIndex,
  });

  final Sport sport;
  final int? numCourts;

  final VoidCallback? onTap;

  final int? index;
  final ValueNotifier<int> selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedIndex,
      builder: (context, currentIndex, _) {
        final isSelected = index == currentIndex;

        return Card.filled(
          margin: EdgeInsets.zero,
          elevation: isSelected ? 3.0 : 0.0,
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          child: _buildContent(context, isSelected),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, bool isSelected) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      overlayColor: WidgetStatePropertyAll(colorScheme.onPrimary.withAlpha(25)),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16.0),
        color: isSelected
            ? colorScheme.primary
            : Theme.brightnessOf(context) == Brightness.light
            ? colorScheme.surfaceContainerLowest
            : colorScheme.surfaceContainerHigh,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 8.0,
          children: [
            Icon(
              sport.icon,
              size: 24,
              fill: 0,
              weight: 400,
              grade: 0,
              opticalSize: 24,
              color: isSelected ? colorScheme.onPrimary : null,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.0,
              children: [
                Text(
                  sport.name.toCapitalized(),
                  style: textTheme.bodyMedium?.copyWith(
                    color: isSelected ? colorScheme.onPrimary : null,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                if (numCourts != null)
                  CustomChip.small.success(palette: WidgetPalette.primary, label: '$numCourts Courts'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
