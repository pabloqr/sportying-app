import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sportying_app/core/routing/routes.dart';
import 'package:sportying_app/features/users/clients/view_model/client_explore_viewmodel.dart';
import 'package:sportying_app/features/users/clients/view_model/client_home_viewmodel.dart';
import 'package:sportying_app/features/users/clients/view_model/client_reservations_viewmodel.dart';
import 'package:sportying_app/features/users/clients/widgets/client_explore_screen.dart';
import 'package:sportying_app/features/users/clients/widgets/client_home_screen.dart';
import 'package:sportying_app/features/users/clients/widgets/client_reservations_screen.dart';
import 'package:sportying_app/features/users/clients/widgets/client_scaffold.dart';

Widget withSystemUiOverlay(BuildContext context, {required Widget child}) {
  final colorScheme = Theme.of(context).colorScheme;
  final brightness = Theme.of(context).brightness == Brightness.light ? Brightness.dark : Brightness.light;

  return AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: brightness == Brightness.light
          ? colorScheme.surface
          : colorScheme.surface,
      systemNavigationBarDividerColor: Colors.transparent,

      statusBarIconBrightness: brightness,
      systemNavigationBarIconBrightness: brightness,
    ),
    child: child,
  );
}

GoRouter router() => GoRouter(
  initialLocation: Routes.clientDashboardRoute,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return withSystemUiOverlay(context, child: ClientScaffold(navigationShell: navigationShell));
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.clientDashboardRoute,
              builder: (context, state) {
                return ClientHomeScreen(
                  viewModel: ClientHomeViewModel(
                    reservationRepository: context.read(),
                    complexesRepository: context.read(),
                  ),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.clientExploreRoute,
              builder: (context, state) {
                return ClientExploreScreen(viewModel: ClientExploreViewModel(complexesRepository: context.read()));
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.clientReservationsRoute,
              builder: (context, state) {
                return ClientReservationsScreen(
                  viewModel: ClientReservationsViewModel(reservationRepository: context.read()),
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
