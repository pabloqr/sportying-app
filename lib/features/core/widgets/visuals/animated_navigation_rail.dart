import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sportying_app/core/routing/routes.dart';
import 'package:sportying_app/features/core/transitions/navigation_rail_transition.dart';
import 'package:sportying_app/features/core/utils/destination.dart';
import 'package:sportying_app/features/core/widgets/utils/animations.dart';
import 'package:sportying_app/features/core/widgets/visuals/animated_floating_action_button.dart';

class AnimatedNavigationRail extends StatelessWidget {
  const AnimatedNavigationRail({
    super.key,
    required this.railAnimation,
    required this.railFabAnimation,
    required this.backgroundColor,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
  });

  final RailAnimation railAnimation;
  final RailFabAnimation railFabAnimation;
  final Color backgroundColor;

  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  final List<Destination> destinations;

  @override
  Widget build(BuildContext context) {
    return NavigationRailTransition(
      animation: railAnimation,
      backgroundColor: backgroundColor,
      child: NavigationRail(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        groupAlignment: -0.85,
        leading: Column(
          spacing: 8.0,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Symbols.menu_rounded, size: 24, fill: 1, weight: 400, grade: 0, opticalSize: 24),
            ),
            AnimatedFloatingActionButton(
              animation: railFabAnimation,
              elevation: 0.0,
              onPressed: () => context.push(Routes.reservationNewRoute),
              icon: const Icon(
                Symbols.calendar_add_on_rounded,
                size: 24,
                fill: 1,
                weight: 400,
                grade: 0,
                opticalSize: 24,
              ),
            ),
          ],
        ),
        destinations: destinations
            .mapIndexed(
              (index, location) => NavigationRailDestination(
                label: Text(location.label),
                icon: Icon(location.icon, size: 24, fill: 0, weight: 400, grade: 0, opticalSize: 24),
                selectedIcon: Icon(location.icon, size: 24, fill: 1, weight: 400, grade: 0, opticalSize: 24),
              ),
            )
            .toList(),
      ),
    );
  }
}
