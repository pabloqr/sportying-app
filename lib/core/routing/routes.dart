abstract final class Routes {
  // Definición de los endpoints de la API del backend del sistema, para evitar la duplicidad de las entradas en el
  // código, los métodos CRUD se agruparán para cada uno de los módulos del sistema de la siguiente manera:
  //  * Read (GET all): moduloEndpoint
  //  * Create/Read (GET all, POST): moduloCREndpoint
  //  * Update/Delete/Read by ID (GET by ID, PUT, DELETE): moduloUDEndpoint(id)
  static const String authEndpoint = '/auth';

  static const String complexesEndpoint = '/complexes';

  static String complexesByIdEndpoint(String complexId) => '$complexesEndpoint/$complexId';

  static const String courtsEndpoint = '/courts';

  static String courtsByIdEndpoint(String courtId) => '$courtsEndpoint/$courtId';

  static const String devicesEndpoint = '/devices';

  static String devicesByIdEndpoint(String deviceId) => '$devicesEndpoint/$deviceId';

  static const String newsEndpoint = '/news';

  static String newsByIdEndpoint(String newsId) => '$newsEndpoint/$newsId';

  static const String reservationsEndpoint = '/reservations';

  static String reservationsByIdEndpoint(String reservationId) => '$reservationsEndpoint/$reservationId';

  static const String usersEndpoint = '/users';

  static String usersByIdEndpoint(String userId) => '$usersEndpoint/$userId';

  static const String notificationsEndpoint = '/notifications';

  static String notificationsByIdEndpoint(String notificationId) => '$notificationsEndpoint/$notificationId';

  //------------------------------------------------------------------------------------------------------------------//
  // AUTH ENDPOINTS
  //------------------------------------------------------------------------------------------------------------------//
  static const String signUpEndpoint = '$authEndpoint/signup';
  static const String signInEndpoint = '$authEndpoint/signin';
  static const String refreshTokenEndpoint = '$authEndpoint/refresh-token';
  static const String signOutEndpoint = '$authEndpoint/signout';
  static const String forgotPasswordEndpoint = '$authEndpoint/forgot-password';
  static const String resetPasswordEndpoint = '$authEndpoint/reset-password';

  //------------------------------------------------------------------------------------------------------------------//
  // COMPLEXES ENDPOINTS
  //------------------------------------------------------------------------------------------------------------------//
  static const String complexesCREndpoint = complexesEndpoint;

  static String complexesUDEndpoint(String complexId) => complexesByIdEndpoint(complexId);

  static String complexTimeEndpoint(String complexId) => '${complexesByIdEndpoint(complexId)}/time';

  static String complexAvailabilityEndpoint(String complexId) => '${complexesByIdEndpoint(complexId)}/availability';

  //------------------------------------------------------------------------------------------------------------------//
  // COURTS ENDPOINTS
  //------------------------------------------------------------------------------------------------------------------//
  static String courtsCREndpoint(String complexId) => '${complexesByIdEndpoint(complexId)}$courtsEndpoint';

  static String courtsUDEndpoint(String complexId, String courtId) =>
      '${complexesByIdEndpoint(complexId)}${courtsByIdEndpoint(courtId)}';

  static String courtStatusEndpoint(String complexId, String courtId) =>
      '${complexesByIdEndpoint(complexId)}${courtsByIdEndpoint(courtId)}/status';

  static String courtAvailabilityEndpoint(String complexId, String courtId) =>
      '${complexesByIdEndpoint(complexId)}${courtsByIdEndpoint(courtId)}/availability';

  static String courtDevicesEndpoint(String complexId, String courtId) =>
      '${complexesByIdEndpoint(complexId)}${courtsByIdEndpoint(courtId)}/devices';

  //------------------------------------------------------------------------------------------------------------------//
  // DEVICES ENDPOINTS
  //------------------------------------------------------------------------------------------------------------------//
  static String devicesCREndpoint(String complexId) => '${complexesByIdEndpoint(complexId)}$devicesEndpoint';

  static String devicesUDEndpoint(String complexId, String deviceId) =>
      '${complexesByIdEndpoint(complexId)}${devicesByIdEndpoint(deviceId)}';

  static String devicesTelemetryEndpoint(String complexId, String deviceId) =>
      '${complexesByIdEndpoint(complexId)}${devicesByIdEndpoint(deviceId)}/telemetry';

  static String devicesStatusEndpoint(String complexId, String deviceId) =>
      '${complexesByIdEndpoint(complexId)}${devicesByIdEndpoint(deviceId)}/status';

  static String deviceCourtsEndpoint(String complexId, String deviceId) =>
      '${complexesByIdEndpoint(complexId)}${devicesByIdEndpoint(deviceId)}/courts';

  //------------------------------------------------------------------------------------------------------------------//
  // NEWS ENDPOINTS
  //------------------------------------------------------------------------------------------------------------------//
  static const String newsCREndpoint = newsEndpoint;

  static String newsUDEndpoint(String newsId) => newsByIdEndpoint(newsId);

  //------------------------------------------------------------------------------------------------------------------//
  // RESERVATIONS ENDPOINTS
  //------------------------------------------------------------------------------------------------------------------//
  static String reservationsUDEndpoint(String reservationId) => reservationsByIdEndpoint(reservationId);

  static String reservationsComplexesCREndpoint(String complexId) =>
      '${complexesByIdEndpoint(complexId)}$reservationsEndpoint';

  static String reservationsUsersEndpoint(String userId) => '${usersByIdEndpoint(userId)}$reservationsEndpoint';

  //------------------------------------------------------------------------------------------------------------------//
  // USERS ENDPOINTS
  //------------------------------------------------------------------------------------------------------------------//
  static const String usersCREndpoint = usersEndpoint;

  static String usersUDEndpoint(String userId) => usersByIdEndpoint(userId);

  //------------------------------------------------------------------------------------------------------------------//
  // NOTIFICATIONS ENDPOINTS
  //------------------------------------------------------------------------------------------------------------------//
  // TODO: Add endpoints for notifications
  static const String notificationsCREndpoint = notificationsEndpoint;

  static String notificationsUDEndpoint(String id) => '$notificationsEndpoint/$id';

  //------------------------------------------------------------------------------------------------------------------//
  // APP ROUTES
  //------------------------------------------------------------------------------------------------------------------//
  static const String clientRelative = 'client';
  static const String adminRelative = 'admin';
  static const String homeRelative = 'home';
  static const String settingsRelative = 'settings';
  static const String complexesRelative = 'complexes';
  static const String courtsRelative = 'courts';
  static const String devicesRelative = 'devices';
  static const String newsRelative = 'news';
  static const String notificationsRelative = 'notifications';
  static const String reservationsRelative = 'reservations';
  static const String usersRelative = 'users';

  static const String welcomeRoute = '/welcome';
  static const String signUpRoute = signUpEndpoint;
  static const String signInRoute = signInEndpoint;

  static const String homeRoute = '/$homeRelative';

  static const String clientDashboardRoute = '/$clientRelative/$homeRelative';
  static const String clientSettingsRoute = '/$clientRelative/$settingsRelative';

  static const String adminDashboardRoute = '/$adminRelative/$homeRelative';
  static const String adminSettingsRoute = '/$adminRelative/$settingsRelative';

  static const String complexInfoRoute = '$complexesEndpoint/info';
  static const String courtInfoRoute = '$courtsEndpoint/info';
  static const String reservationNewRoute = '$reservationsEndpoint/new';
  static const String reservationModifyRoute = '$reservationsEndpoint/modify';
  static const String reservationInfoRoute = '$reservationsEndpoint/info';
}
