// ignore_for_file: unused_element

// -------------------------------------------------------------------------------------------------------------------//
// COMMON ROUTES
// -------------------------------------------------------------------------------------------------------------------//
const String _authRelative = '/auth';
const String _complexesRelative = '/complexes';
const String _courtsRelative = '/courts';
const String _devicesRelative = '/devices';
const String _newsRelative = '/news';
const String _notificationsRelative = '/notifications';
const String _reservationsRelative = '/reservations';
const String _usersRelative = '/users';

abstract final class ServerRoutes {
  static const String signUpRoute = '$_authRelative/signup';
  static const String signInRoute = '$_authRelative/signin';
  static const String refreshAuthRoute = '$_authRelative/refresh-token';
  static const String signOutRoute = '$_authRelative/signout';
}

abstract final class AppRoutes {
  static const String _clientRelative = '/client';
  static const String _adminRelative = '/admin';

  static const String _homeRelative = '/home';
  static const String _exploreRelative = '/explore';
  static const String _profileRelative = '/profile';
  static const String _settingsRelative = '/settings';

  static const String welcomeRoute = '/welcome';

  static const String signUpRoute = '/signup';
  static const String signInRoute = '/signin';

  static const String clientDashboardRoute = '$_clientRelative$_homeRelative';
  static const String clientReservationsRoute = '$_clientRelative$_reservationsRelative';
  static const String clientExploreRoute = '$_clientRelative$_exploreRelative';
  static const String clientProfileRoute = '$_clientRelative$_profileRelative';
  static const String clientSettingsRoute = '$_clientRelative$_settingsRelative';

  static const String adminDashboardRoute = '$_adminRelative$_homeRelative';
  static const String adminReservationsRoute = '$_adminRelative$_reservationsRelative';
  static const String adminProfileRoute = '$_adminRelative$_profileRelative';
  static const String adminSettingsRoute = '$_adminRelative$_settingsRelative';

  static const String complexInfoRoute = '$_complexesRelative/info';
  static const String courtInfoRoute = '$_courtsRelative/info';
  static const String reservationNewRoute = '$_reservationsRelative/new';
  static const String reservationModifyRoute = '$_reservationsRelative/modify';
  static const String reservationInfoRoute = '$_reservationsRelative/info';
}
