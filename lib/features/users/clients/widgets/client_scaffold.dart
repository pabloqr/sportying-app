import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sportying_app/core/routing/routes.dart';
import 'package:sportying_app/features/core/utils/destination.dart';
import 'package:sportying_app/features/core/widgets/utils/animations.dart';
import 'package:sportying_app/features/core/widgets/visuals/animated_floating_action_button.dart';
import 'package:sportying_app/features/core/widgets/visuals/animated_navigation_bar.dart';
import 'package:sportying_app/features/core/widgets/visuals/animated_navigation_rail.dart';
import 'package:sportying_app/features/core/widgets/visuals/end_drawer.dart';

final List<Destination> _destinations = [
  Destination('/client/home', 'Home', Symbols.home_rounded),
  Destination('/client/explore', 'Explore', Symbols.search_rounded),
  Destination('/client/reservations', 'Reservations', Symbols.calendar_month_rounded),
];

class ClientScaffold extends StatefulWidget {
  const ClientScaffold({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<ClientScaffold> createState() => _ClientScaffoldState();
}

class _ClientScaffoldState extends State<ClientScaffold> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    reverseDuration: const Duration(milliseconds: 1250),
    value: 0,
    vsync: this,
  );
  late final _railAnimation = RailAnimation(parent: _controller);
  late final _railFabAnimation = RailFabAnimation(parent: _controller);
  late final _barAnimation = BarAnimation(parent: _controller);

  bool _controllerInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final double width = MediaQuery.of(context).size.width;
    final AnimationStatus status = _controller.status;
    if (width > 600) {
      if (status != AnimationStatus.forward && status != AnimationStatus.completed) {
        _controller.forward();
      }
    } else {
      if (status != AnimationStatus.reverse && status != AnimationStatus.dismissed) {
        _controller.reverse();
      }
    }
    if (!_controllerInitialized) {
      _controllerInitialized = true;
      _controller.value = width > 600 ? 1 : 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDestinationSelected(int index, BuildContext context) => widget.navigationShell.goBranch(index);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Scaffold(
        extendBody: true,
        body: SafeArea(
          bottom: false,
          child: Row(
            children: [
              AnimatedNavigationRail(
                railAnimation: _railAnimation,
                railFabAnimation: _railFabAnimation,
                backgroundColor: Theme.of(context).colorScheme.surface,
                selectedIndex: widget.navigationShell.currentIndex,
                onDestinationSelected: (index) => _onDestinationSelected(index, context),
                destinations: _destinations,
              ),
              Expanded(
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [_buildAppBar(context)];
                  },
                  body: widget.navigationShell,
                ),
              ),
            ],
          ),
        ),
        endDrawer: const EndDrawer(),
        bottomNavigationBar: AnimatedNavigationBar.floating(
          barAnimation: _barAnimation,
          selectedIndex: widget.navigationShell.currentIndex,
          onDestinationSelected: (index) => _onDestinationSelected(index, context),
          destinations: _destinations,
        ),
        floatingActionButton: AnimatedFloatingActionButton.extended(
          animation: _barAnimation,
          onPressed: () => context.push(Routes.reservationNewRoute),
          label: const Text('Book'),
          icon: const Icon(Symbols.calendar_add_on_rounded, size: 24, fill: 1, weight: 400, grade: 0, opticalSize: 24),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      title: Text(_destinations[widget.navigationShell.currentIndex].label),
      flexibleSpace: FlexibleSpaceBar(),
      actions: [_buildAppBarTrailingIcon(context)],
    );
  }

  Widget _buildAppBarTrailingIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(1000),
        onTap: () => Scaffold.of(context).openEndDrawer(),
        // onTap: () => showSideSheet(
        //   context,
        //   title: 'Account',
        //   content: [
        //     Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 12.0),
        //       child: Text('My account', style: textTheme.titleMedium),
        //     ),
        //     Column(
        //       children: [
        //         ListTileRounded(title: 'Edit profile', icon: Symbols.person_rounded, onTap: () {}),
        //         ListTileRounded(title: 'My payments', icon: Symbols.payments_rounded, onTap: () {}),
        //         ListTileRounded(title: 'Notifications', icon: Symbols.notifications_rounded, onTap: () {}),
        //         ListTileRounded(title: 'Settings', icon: Symbols.settings_rounded, onTap: () {}),
        //       ],
        //     ),
        //     Divider(),
        //     Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 12.0),
        //       child: Text('Support', style: textTheme.titleMedium),
        //     ),
        //     Column(
        //       children: [
        //         ListTileRounded(title: 'Help', icon: Symbols.help_rounded, onTap: () {}),
        //         ListTileRounded(title: 'FAQ', icon: Symbols.question_mark_rounded, onTap: () {}),
        //         ListTileRounded(title: 'About this app', icon: Symbols.info_rounded, onTap: () {}),
        //       ],
        //     ),
        //     Divider(),
        //     ListTileRounded(
        //       title: 'Sign out',
        //       icon: Symbols.logout_rounded,
        //       contentColor: colorScheme.error,
        //       onTap: () {},
        //     ),
        //   ],
        // ),
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
}
