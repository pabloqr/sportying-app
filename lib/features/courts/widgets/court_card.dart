import 'dart:math';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sportying_app/core/utils/extension_utilities.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';
import 'package:sportying_app/domain/models/courts/court.dart';
import 'package:sportying_app/features/core/utils/widget_palette.dart';
import 'package:sportying_app/features/core/utils/widget_side.dart';
import 'package:sportying_app/features/core/widgets/scaffolds/labeled_info_widget.dart';
import 'package:sportying_app/features/core/widgets/utils/marquee_widget.dart';
import 'package:sportying_app/features/core/widgets/visuals/custom_chip.dart';
import 'package:sportying_app/features/core/widgets/visuals/pulsing_dot.dart';

//--------------------------------------------------------------------------------------------------------------------//
// CONSTANTS
//--------------------------------------------------------------------------------------------------------------------//

/// Opacity applied to non-selected cards in carousel mode
const double _kNonSelectedOpacity = 0.6;

/// Border width for selected cards in carousel mode
const double _kSelectedBorderWidth = 3.0;

/// Gradient stops for carousel card overlay
const List<double> _kCarouselGradientStops = [0.4, 1.0];

/// Gradient stops for shader mask in carousel
const List<double> _kShaderMaskStops = [0.85, 1.0];

/// Alpha values for gradient overlay
const int _kGradientStartAlpha = 25;
const int _kGradientEndAlpha = 150;

/// Image container height for cards
const double _kCardImageHeight = 200.0;

/// Star icon size
const double _kStarIconSize = 18.0;

/// Button overlay alpha
const int _kButtonOverlayAlpha = 25;

//--------------------------------------------------------------------------------------------------------------------//
// ENUMS
//--------------------------------------------------------------------------------------------------------------------//

enum _CourtCardType { carousel, tile, card }

//--------------------------------------------------------------------------------------------------------------------//
// WIDGETS
//--------------------------------------------------------------------------------------------------------------------//

/// A card widget that displays complex information in different layouts.
///
/// Supports three display modes:
/// - [CourtCard.carousel]: Horizontal carousel with image background
/// - [CourtCard.tile]: Compact tile layout (ready for custom implementation)
/// - [CourtCard.card]: Full card layout with detailed information
class CourtCard extends StatelessWidget {
  CourtCard.carousel({super.key, required this.court, this.index, ValueNotifier<int>? selectedIndex})
    : _type = _CourtCardType.carousel,
      fullRadiusSide = null,
      selectedIndex = selectedIndex ?? ValueNotifier<int>(-1),
      onTap = null;

  CourtCard.tile({
    super.key,
    this.fullRadiusSide = WidgetSide.none,
    required this.court,
    this.index,
    ValueNotifier<int>? selectedIndex,
    this.onTap,
  }) : _type = _CourtCardType.tile,
       selectedIndex = selectedIndex ?? ValueNotifier<int>(-1);

  CourtCard.card({super.key, required this.court, this.index, ValueNotifier<int>? selectedIndex})
    : _type = _CourtCardType.card,
      fullRadiusSide = null,
      selectedIndex = selectedIndex ?? ValueNotifier<int>(-1),
      onTap = null;

  final _CourtCardType _type;

  final WidgetSide? fullRadiusSide;

  final Court court;

  final int? index;
  final ValueNotifier<int> selectedIndex;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    switch (_type) {
      case _CourtCardType.carousel:
        return _CourtCarouselCard(court: court, index: index, selectedIndex: selectedIndex);
      case _CourtCardType.tile:
        return _CourtTileCard(
          fullRadiusSide: fullRadiusSide!,
          court: court,
          index: index,
          selectedIndex: selectedIndex,
          onTap: onTap,
        );
      case _CourtCardType.card:
        return _CourtDisplayCard(court: court);
    }
  }
}

class _CourtCarouselCard extends StatelessWidget {
  const _CourtCarouselCard({required this.court, required this.index, required this.selectedIndex});

  final Court court;

  final int? index;
  final ValueNotifier<int> selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedIndex,
      builder: (context, currentIndex, _) {
        final isSelected = index == currentIndex;
        final hasSelection = selectedIndex.value != -1;
        final opacity = hasSelection && !isSelected ? _kNonSelectedOpacity : 1.0;

        return Card(
          margin: EdgeInsets.zero,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: isSelected
                ? BorderSide(color: Theme.of(context).colorScheme.primary, width: _kSelectedBorderWidth)
                : BorderSide.none,
          ),
          clipBehavior: Clip.none,
          child: Opacity(opacity: opacity, child: _buildContent(context)),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.brightnessOf(context);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/placeholders/court.jpg'), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withAlpha(_kGradientStartAlpha), Colors.black.withAlpha(_kGradientEndAlpha)],
            stops: _kCarouselGradientStops,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [colorScheme.surface, colorScheme.surface.withAlpha(0)],
              stops: _kShaderMaskStops,
            ).createShader(bounds),
            blendMode: BlendMode.dstIn,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TODO: Replace with actual condition
                if (true) _AvailabilityInfo(isAvailable: Random().nextBool()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12.0,
                  children: [_buildTitle(context, brightness)],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, Brightness brightness) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final titleColor = brightness == Brightness.light ? colorScheme.surface : colorScheme.onSurface;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(court.name, style: textTheme.titleLarge?.copyWith(color: titleColor), softWrap: false)],
    );
  }
}

class _CourtTileCard extends StatelessWidget {
  const _CourtTileCard({
    this.fullRadiusSide = WidgetSide.none,
    required this.court,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  final WidgetSide fullRadiusSide;

  final Court court;

  final int? index;
  final ValueNotifier<int> selectedIndex;

  final VoidCallback? onTap;

  static BorderRadius _calculateBorderRadius(WidgetSide side) {
    if (side == WidgetSide.all) return BorderRadius.circular(12.0);
    if (side == WidgetSide.none) return BorderRadius.circular(4.0);

    final top = side == WidgetSide.top;
    final bottom = side == WidgetSide.bottom;

    return BorderRadius.vertical(top: Radius.circular(top ? 12.0 : 4.0), bottom: Radius.circular(bottom ? 12.0 : 4.0));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ValueListenableBuilder(
      valueListenable: selectedIndex,
      builder: (context, currentIndex, _) {
        final isSelected = index == currentIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(vertical: 1.0),
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
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: const EdgeInsets.all(16.0), child: _buildBody(context, isSelected)),
      ),
    );
  }

  Widget _buildBody(BuildContext context, bool isSelected) {
    final isAvailable = Random().nextBool();
    final nextAvailable = DateTime(2025, Random().nextBool() ? 11 : 12, 25, 18);

    return Row(
      spacing: 16.0,
      children: [
        Icon(court.sport.icon, size: 24, fill: 0, weight: 400, grade: 0, opticalSize: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.0,
            children: [
              _CourtTitle(
                brightness: Theme.brightnessOf(context) == Brightness.light || !isSelected
                    ? Brightness.light
                    : Brightness.dark,
                name: court.name,
                sport: court.sport,
                surface: 'Grass',
                maxPeople: court.maxPeople,
              ),
              Row(
                spacing: 8.0,
                children: [
                  CustomChip.medium.neutral(
                    palette: WidgetPalette.primary,
                    icon: Symbols.star_rounded,
                    filledIcon: true,
                    label: 4.5.toString(),
                  ),
                  Expanded(
                    child: _AvailabilityInfo(isAvailable: isAvailable, nextAvailable: nextAvailable),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CourtDisplayCard extends StatelessWidget {
  const _CourtDisplayCard({required this.court});

  final Court court;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.brightnessOf(context);

    return Card.filled(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      color: brightness == Brightness.light ? colorScheme.surfaceContainerLowest : colorScheme.surfaceContainerHigh,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16.0,
          children: [
            _CourtTitle(name: court.name, sport: court.sport, surface: 'Grass', maxPeople: court.maxPeople),
            _CourtImageContainer(
              height: _kCardImageHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 8.0,
                    children: [if (true) _AvailabilityInfo(isAvailable: Random().nextBool())],
                  ),
                ],
              ),
            ),
            _buildInfo(context),
            _CourtActionButtons(onMoreInfo: () {}, onBookCourt: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Row(
      spacing: 4.0,
      children: [
        Expanded(
          child: LabeledInfoWidget.icon(
            icon: Symbols.schedule_rounded,
            label: 'Schedule',
            text: '${court.createdAt} - ${court.updatedAt}',
          ),
        ),
      ],
    );
  }
}

class _CourtTitle extends StatelessWidget {
  const _CourtTitle({
    this.brightness = Brightness.light,
    required this.name,
    required this.sport,
    required this.surface,
    required this.maxPeople,
  });

  final Brightness? brightness;

  final String name;
  final Sport sport;
  final String surface;
  final int maxPeople;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.0,
      children: [
        Text(
          name,
          style: textTheme.titleLarge?.copyWith(
            color: brightness == Brightness.light ? colorScheme.onSurface : colorScheme.surface,
          ),
        ),
        MarqueeWidget(
          child: Row(
            spacing: 4.0,
            children: [
              Text(
                '${sport.name.toCapitalized()} · $surface ·',
                style: textTheme.bodyMedium?.copyWith(
                  color: brightness == Brightness.light ? colorScheme.onSurfaceVariant : colorScheme.outlineVariant,
                ),
              ),
              Icon(
                Symbols.groups_rounded,
                size: 18,
                fill: 0,
                weight: 400,
                grade: 0,
                opticalSize: 18,
                color: colorScheme.onSurfaceVariant,
              ),
              Text(
                maxPeople.toString().padLeft(2, '0'),
                style: textTheme.bodyMedium?.copyWith(
                  color: brightness == Brightness.light ? colorScheme.onSurfaceVariant : colorScheme.outlineVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Image container with rating and sports overlay
class _CourtImageContainer extends StatelessWidget {
  // ignore: unused_element_parameter
  const _CourtImageContainer({this.width, this.height, this.borderRadius, this.child});

  final double? width;
  final double? height;

  final double? borderRadius;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: const DecorationImage(image: AssetImage('assets/images/placeholders/court.jpg'), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
      ),
      alignment: AlignmentGeometry.topCenter,
      padding: const EdgeInsets.all(16.0),
      child: child,
    );
  }
}

/// Displays the availability status chip
class _AvailabilityInfo extends StatelessWidget {
  const _AvailabilityInfo({required this.isAvailable, this.nextAvailable});

  final bool isAvailable;
  final DateTime? nextAvailable;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final isAvailableToday =
        DateTime.now().day == nextAvailable?.day &&
        DateTime.now().month == nextAvailable?.month &&
        DateTime.now().year == nextAvailable?.year;

    final label = isAvailable
        ? 'Available'
        : isAvailableToday
        ? 'Next available time frame at ${nextAvailable?.toFormattedTime0()}'
        : 'Unavailable today';
    final color = isAvailable
        ? colorScheme.secondary
        : isAvailableToday
        ? colorScheme.tertiary
        : colorScheme.error;

    return Row(
      spacing: 4.0,
      children: [
        if (isAvailable || isAvailableToday)
          PulsingDot.small(color: isAvailable ? colorScheme.secondary : colorScheme.tertiary),
        Expanded(
          child: Text(label, style: textTheme.bodyMedium?.copyWith(color: color)),
        ),
      ],
    );
  }
}

/// Displays the rating with stars and numeric value
// ignore: unused_element
class _CourtRatingWidget extends StatelessWidget {
  const _CourtRatingWidget({required this.rating, required this.showStars});

  final double rating;
  final bool showStars;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      spacing: 4.0,
      children: [
        if (showStars) _buildStars(context) else _buildSingleStar(context),
        Text(rating.toString(), style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary), softWrap: false),
      ],
    );
  }

  Widget _buildStars(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: List.generate(5, (index) {
        final iconData = _getStarIcon(index);
        final iconFill = _getStarFill(index);

        return Icon(
          iconData,
          color: colorScheme.primary,
          size: _kStarIconSize,
          fill: iconFill,
          weight: 400,
          grade: 0,
          opticalSize: _kStarIconSize,
        );
      }),
    );
  }

  Widget _buildSingleStar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Icon(
      Symbols.star_rounded,
      color: colorScheme.primary,
      size: _kStarIconSize,
      fill: 1,
      weight: 400,
      grade: 0,
      opticalSize: _kStarIconSize,
    );
  }

  IconData _getStarIcon(int index) {
    if (rating >= index + 1) return Symbols.star_rounded;
    if (rating >= index + 0.5) return Symbols.star_half_rounded;
    return Symbols.star_rounded;
  }

  double _getStarFill(int index) {
    return rating >= index + 0.5 ? 1.0 : 0.0;
  }
}

/// Action buttons for the card (More info and Book court)
class _CourtActionButtons extends StatelessWidget {
  const _CourtActionButtons({required this.onMoreInfo, required this.onBookCourt});

  final VoidCallback onMoreInfo;
  final VoidCallback onBookCourt;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: 4.0,
      children: [
        TextButton(
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(_getTextButtonOverlayColor(context)),
            foregroundColor: WidgetStatePropertyAll(_getTextButtonForegroundColor(context)),
          ),
          onPressed: onMoreInfo,
          child: const Text('More info'),
        ),
        FilledButton(
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(colorScheme.onPrimary.withAlpha(_kButtonOverlayAlpha)),
            backgroundColor: WidgetStatePropertyAll(colorScheme.primary),
            foregroundColor: WidgetStatePropertyAll(colorScheme.onPrimary),
          ),
          onPressed: onBookCourt,
          child: const Text('Book court'),
        ),
      ],
    );
  }

  Color _getTextButtonOverlayColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Theme.brightnessOf(context) == Brightness.light
        ? colorScheme.onPrimary.withAlpha(_kButtonOverlayAlpha)
        : colorScheme.primary.withAlpha(_kButtonOverlayAlpha);
  }

  Color _getTextButtonForegroundColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Theme.brightnessOf(context) == Brightness.light ? colorScheme.onPrimary : colorScheme.primary;
  }
}
