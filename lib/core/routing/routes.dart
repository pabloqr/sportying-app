abstract final class Routes {
  //------------------------------------------------------------------------------------------------------------------//
  // APP ROUTES
  //------------------------------------------------------------------------------------------------------------------//
  static const String clientRelative = 'client';
  static const String adminRelative = 'admin';

  static const String homeRelative = 'home';
  static const String exploreRelative = 'explore';
  static const String profileRelative = 'profile';
  static const String settingsRelative = 'settings';

  static const String complexesRelative = 'complexes';
  static const String courtsRelative = 'courts';
  static const String devicesRelative = 'devices';
  static const String newsRelative = 'news';
  static const String notificationsRelative = 'notifications';
  static const String reservationsRelative = 'reservations';
  static const String usersRelative = 'users';

  static const String welcomeRoute = '/welcome';
  static const String signUpRoute = '/signup';
  static const String signInRoute = '/signin';

  static const String homeRoute = '/$homeRelative';

  static const String clientDashboardRoute = '/$clientRelative/$homeRelative';
  static const String clientReservationsRoute = '/$clientRelative/$reservationsRelative';
  static const String clientExploreRoute = '/$clientRelative/$exploreRelative';
  static const String clientProfileRoute = '/$clientRelative/$profileRelative';
  static const String clientSettingsRoute = '/$clientRelative/$settingsRelative';

  static const String adminDashboardRoute = '/$adminRelative/$homeRelative';
  static const String adminReservationsRoute = '/$clientRelative/$reservationsRelative';
  static const String adminProfileRoute = '/$clientRelative/$profileRelative';
  static const String adminSettingsRoute = '/$adminRelative/$settingsRelative';

  static const String complexInfoRoute = '/complexes/info';
  static const String courtInfoRoute = '/court/info';
  static const String reservationNewRoute = '/$reservationsRelative/new';
  static const String reservationModifyRoute = '/$reservationsRelative/modify';
  static const String reservationInfoRoute = '/$reservationsRelative/info';
}
