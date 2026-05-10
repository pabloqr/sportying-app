import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sportying_app/core/routing/routes.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/repositories/auth/auth_repository.dart';
import 'package:sportying_app/domain/models/users/user.dart';
import 'package:sportying_app/features/core/widgets/scaffolds/client_scaffold.dart';
import 'package:sportying_app/features/reservations/reservation_process/view_model/reservation_process_viewmodel.dart';
import 'package:sportying_app/features/reservations/reservation_process/widgets/reservation_process_screen.dart';
import 'package:sportying_app/features/reservations/reservations_list/clients/view_model/client_reservations_viewmodel.dart';
import 'package:sportying_app/features/reservations/reservations_list/clients/widgets/client_reservations_screen.dart';
import 'package:sportying_app/features/users/clients/explore/view_model/client_explore_viewmodel.dart';
import 'package:sportying_app/features/users/clients/explore/widgets/client_explore_screen.dart';
import 'package:sportying_app/features/users/clients/home/view_model/client_home_viewmodel.dart';
import 'package:sportying_app/features/users/clients/home/widgets/client_home_screen.dart';

Widget withSystemUiOverlay(BuildContext context, {required Widget child}) {
  final colorScheme = Theme.of(context).colorScheme;
  final brightness = Theme.brightnessOf(context) == Brightness.light ? Brightness.dark : Brightness.light;

  return AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: brightness == Brightness.light
          ? colorScheme.surfaceContainerHigh
          : colorScheme.surfaceContainerLowest,
      systemNavigationBarDividerColor: Colors.transparent,

      statusBarIconBrightness: brightness,
      systemNavigationBarIconBrightness: brightness,
    ),
    child: child,
  );
}

GoRouter router(AuthRepository authRepository) => GoRouter(
  initialLocation: AppRoutes.clientDashboardRoute,
  debugLogDiagnostics: true,
  redirect: (context, state) async {
    final result = await authRepository.autoAuth();
    switch (result) {
      case Ok<bool>():
        final isAuthenticated = result.value;
        final isAuthRoute =
            state.matchedLocation == AppRoutes.signUpRoute || state.matchedLocation == AppRoutes.signInRoute;

        if (!isAuthenticated) return isAuthRoute ? null : AppRoutes.signInRoute;

        if (isAuthRoute) {
          return authRepository.user!.role == Role.client
              ? AppRoutes.clientDashboardRoute
              : AppRoutes.adminDashboardRoute;
        }

        return null;
      case Error<bool>():
        return AppRoutes.signInRoute;
    }
  },
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return withSystemUiOverlay(context, child: ClientScaffold(navigationShell: navigationShell));
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.clientDashboardRoute,
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
              path: AppRoutes.clientExploreRoute,
              builder: (context, state) {
                return ClientExploreScreen(viewModel: ClientExploreViewModel(complexesRepository: context.read()));
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.clientReservationsRoute,
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
    GoRoute(
      path: AppRoutes.reservationNewRoute,
      builder: (context, state) {
        return ReservationProcessScreen(
          viewModel: ReservationProcessViewModel(complexesRepository: context.read(), courtsRepository: context.read()),
        );
      },
    ),
    GoRoute(path: AppRoutes.reservationModifyRoute, builder: (context, state) => const Placeholder()),
    GoRoute(path: AppRoutes.reservationInfoRoute, builder: (context, state) => const Placeholder()),
  ],
);
