class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException([this.message = 'An error occurred on the server', this.statusCode]);

  @override
  String toString() => 'ServerException(message: $message, statusCode: $statusCode)';
}

class CacheException implements Exception {
  final String message;

  CacheException([this.message = 'An error occurred with local cache']);

  @override
  String toString() => 'CacheException(message: $message)';
}

class NetworkException implements Exception {
  final String message;

  NetworkException([this.message = 'No internet connection']);

  @override
  String toString() => 'NetworkException(message: $message)';
}

class UnexpectedException implements Exception {
  final String message;

  UnexpectedException([this.message = 'An unexpected error occurred']);

  @override
  String toString() => 'UnexpectedException(message: $message)';
}
