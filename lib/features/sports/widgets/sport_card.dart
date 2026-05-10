import 'package:flutter/material.dart';
import 'package:sportying_app/core/utils/extension_utils.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';
import 'package:sportying_app/features/core/utils/widget_palette.dart';
import 'package:sportying_app/features/core/utils/widget_side.dart';
import 'package:sportying_app/features/core/widgets/visuals/custom_chip.dart';

class SportCard extends StatelessWidget {
  const SportCard({
    super.key,
    this.fullRadiusSide = WidgetSide.none,
    required this.sport,
    this.numCourts,
    this.onTap,
    this.index,
    required this.selectedIndex,
  });

  final WidgetSide fullRadiusSide;

  final Sport sport;
  final int? numCourts;

  final VoidCallback? onTap;

  final int? index;
  final ValueNotifier<int> selectedIndex;

  static BorderRadius _calculateBorderRadius(WidgetSide side) {
    if (side == WidgetSide.all) return BorderRadius.circular(12.0);
    if (side == WidgetSide.none) return BorderRadius.circular(4.0);

    final topLeft = side == WidgetSide.top || side == WidgetSide.left || side == WidgetSide.topLeft;
    final topRight = side == WidgetSide.top || side == WidgetSide.right || side == WidgetSide.topRight;
    final bottomLeft = side == WidgetSide.bottom || side == WidgetSide.left || side == WidgetSide.bottomLeft;
    final bottomRight = side == WidgetSide.bottom || side == WidgetSide.right || side == WidgetSide.bottomRight;

    return BorderRadius.only(
      topLeft: Radius.circular(topLeft ? 12.0 : 4.0),
      topRight: Radius.circular(topRight ? 12.0 : 4.0),
      bottomLeft: Radius.circular(bottomLeft ? 12.0 : 4.0),
      bottomRight: Radius.circular(bottomRight ? 12.0 : 4.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ValueListenableBuilder<int>(
      valueListenable: selectedIndex,
      builder: (context, currentIndex, _) {
        final isSelected = index == currentIndex;

        return AnimatedContainer(
          duration: Duration(milliseconds: 200),
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primaryContainer
                : Theme.brightnessOf(context) == Brightness.light
                ? colorScheme.surfaceContainerLowest
                : colorScheme.surfaceContainerHigh,
            borderRadius: _calculateBorderRadius(isSelected ? WidgetSide.all : fullRadiusSide),
          ),
          clipBehavior: Clip.antiAlias,
          child: _buildContent(context, isSelected),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, bool isSelected) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 8.0,
            children: [
              Icon(sport.icon, size: 24, fill: 0, weight: 400, grade: 0, opticalSize: 24),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.0,
                children: [
                  Text(
                    sport.name.toCapitalized(),
                    style: textTheme.bodyMedium?.copyWith(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
                  ),
                  if (numCourts != null)
                    CustomChip.small.success(palette: WidgetPalette.primary, label: '$numCourts Courts'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
