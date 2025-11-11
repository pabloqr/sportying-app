import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sportying_app/features/core/transitions/bottom_bar_transition.dart';
import 'package:sportying_app/features/core/utils/destination.dart';
import 'package:sportying_app/features/core/widgets/utils/animations.dart';

class AnimatedNavigationBar extends StatelessWidget {
  const AnimatedNavigationBar({
    super.key,
    required this.barAnimation,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    this.floatingBar = false,
  });

  factory AnimatedNavigationBar.floating({
    required BarAnimation barAnimation,
    required int selectedIndex,
    ValueChanged<int>? onDestinationSelected,
    required List<Destination> destinations,
  }) => AnimatedNavigationBar(
    floatingBar: true,
    barAnimation: barAnimation,
    selectedIndex: selectedIndex,
    onDestinationSelected: onDestinationSelected,
    destinations: destinations,
  );

  final BarAnimation barAnimation;

  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  final List<Destination> destinations;

  final bool floatingBar;

  @override
  Widget build(BuildContext context) {
    return BottomBarTransition(
      animation: barAnimation,
      backgroundColor: floatingBar ? Colors.transparent : Colors.white,
      child: floatingBar
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                child: Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(24.0),
                  clipBehavior: Clip.antiAlias,
                  child: _buildNavigationBar(context),
                ),
              ),
            )
          : _buildNavigationBar(context),
    );
  }

  Widget _buildNavigationBar(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: destinations
          .mapIndexed(
            (index, location) => NavigationDestination(
              label: location.label,
              icon: Icon(location.icon, size: 24, fill: 0, weight: 400, grade: 0, opticalSize: 24),
              selectedIcon: Icon(location.icon, size: 24, fill: 1, weight: 400, grade: 0, opticalSize: 24),
            ),
          )
          .toList(),
    );
  }
}
