import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sportying_app/features/core/widgets/scaffolds/side_sheet.dart';
import 'package:sportying_app/features/core/widgets/visuals/list_tile_rounded.dart';

class _Destination {
  String route;
  String label;
  IconData icon;

  _Destination(this.route, this.label, this.icon);
}

final List<_Destination> _destinations = [
  _Destination('/client/home', 'Home', Symbols.home_rounded),
  _Destination('/client/explore', 'Explore', Symbols.search_rounded),
  _Destination('/client/reservations', 'Reservations', Symbols.calendar_month_rounded),
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
      bottomNavigationBar: _buildBottomNavigationBar(context),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [_buildAppBar(context)];
          },
          body: navigationShell,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Book'),
        icon: const Icon(Symbols.calendar_add_on_rounded, size: 24, fill: 1, weight: 400, grade: 0, opticalSize: 24),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      title: Text(_destinations[_calculateSelectedIndex(context)].label),
      flexibleSpace: FlexibleSpaceBar(),
      actions: [_buildAppBarTrailingIcon(context)],
    );
  }

  Widget _buildAppBarTrailingIcon(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(1000),
        onTap: () => showSideSheet(
          context,
          title: 'Account',
          content: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text('My account', style: textTheme.titleMedium),
            ),
            Column(
              children: [
                ListTileRounded(title: 'Edit profile', icon: Symbols.person_rounded, onTap: () {}),
                ListTileRounded(title: 'My payments', icon: Symbols.payments_rounded, onTap: () {}),
                ListTileRounded(title: 'Notifications', icon: Symbols.notifications_rounded, onTap: () {}),
                ListTileRounded(title: 'Settings', icon: Symbols.settings_rounded, onTap: () {}),
              ],
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text('Support', style: textTheme.titleMedium),
            ),
            Column(
              children: [
                ListTileRounded(title: 'Help', icon: Symbols.help_rounded, onTap: () {}),
                ListTileRounded(title: 'FAQ', icon: Symbols.question_mark_rounded, onTap: () {}),
                ListTileRounded(title: 'About this app', icon: Symbols.info_rounded, onTap: () {}),
              ],
            ),
            Divider(),
            ListTileRounded(
              title: 'Sign out',
              icon: Symbols.logout_rounded,
              contentColor: colorScheme.error,
              onTap: () {},
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const CircleAvatar(
            radius: 16.0,
            // TODO: Replace with user's actual avatar or initials
            child: Icon(Icons.person_rounded, size: 18.0, opticalSize: 18.0),
          ),
        ),
      ),
    );
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
