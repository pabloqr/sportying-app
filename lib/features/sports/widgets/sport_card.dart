import 'package:flutter/material.dart';
import 'package:sportying_app/core/utils/extension_utilities.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';

class SportCard extends StatelessWidget {
  const SportCard({super.key, required this.sport, this.onTap, this.index, required this.selectedIndex});

  final Sport sport;
  final VoidCallback? onTap;

  final int? index;
  final ValueNotifier<int> selectedIndex;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;

    return ValueListenableBuilder<int>(
      valueListenable: selectedIndex,
      builder: (context, currentIndex, _) {
        final isSelected = index == currentIndex;

        return Card.filled(
          margin: EdgeInsets.zero,
          color: isSelected
              ? colorScheme.primary
              : brightness == Brightness.light
              ? colorScheme.surfaceContainerLowest
              : colorScheme.surfaceContainerHigh,
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4.0,
          children: [
            Row(
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
                  color: isSelected ? colorScheme.primary : null,
                ),
                Text(
                  sport.name.toCapitalized(),
                  style: textTheme.bodyMedium?.copyWith(
                    color: isSelected ? colorScheme.primary : null,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
            if (false) Text('00 Courts'),
          ],
        ),
      ),
    );
  }
}
