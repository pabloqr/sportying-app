import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sportying_app/core/routing/routes.dart';
import 'package:sportying_app/features/users/clients/view_model/client_home_viewmodel.dart';
import 'package:sportying_app/features/users/clients/widgets/client_home_screen.dart';
import 'package:sportying_app/features/users/clients/widgets/client_scaffold.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.clientDashboardRoute,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ClientScaffold(navigationShell: navigationShell);
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
      ],
    ),
  ],
);
