class Constants {
  const Constants._();

  static const String baseUrl = String.fromEnvironment('API_URL', defaultValue: 'http://localhost:3000');
}
