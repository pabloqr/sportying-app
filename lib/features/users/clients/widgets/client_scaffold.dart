import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class _Destination {
  String route;
  String label;
  IconData icon;

  _Destination(this.route, this.label, this.icon);
}

final List<_Destination> _destinations = [
  _Destination('/home', 'Home', Symbols.home_rounded),
  _Destination('/reservations', 'Reservations', Symbols.calendar_month_rounded),
  _Destination('/explore', 'Explore', Symbols.search_rounded),
  _Destination('/profile', 'Profile', Symbols.account_circle_rounded),
];

class ClientScaffold extends StatelessWidget {
  const ClientScaffold({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static int _calculateSelectedIndex(BuildContext context) {
    final String uriPath = GoRouterState.of(context).uri.path;

    for (var i = 0; i < _destinations.length; ++i) {
      if (uriPath.startsWith(_destinations[i].route)) return i;
    }

    return 0;
  }

  void _onDestinationSelected(int index, BuildContext context) => navigationShell.goBranch(index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      body: SafeArea(child: navigationShell),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(title: Text(_destinations[_calculateSelectedIndex(context)].label));
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return NavigationBar(
      selectedIndex: _calculateSelectedIndex(context),
      onDestinationSelected: (index) => _onDestinationSelected(index, context),
      destinations: _destinations
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
