import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sportying_app/core/storage/secure_storage_service.dart';

class SecureStorageServiceImpl implements SecureStorageService {
  SecureStorageServiceImpl({required FlutterSecureStorage secureStorage}) : _secureStorage = secureStorage;

  final FlutterSecureStorage _secureStorage;

  @override
  Future<String?> read(String key) => _secureStorage.read(key: key);

  @override
  Future<void> write(String key, String value) => _secureStorage.write(key: key, value: value);

  @override
  Future<void> delete(String key) => _secureStorage.delete(key: key);

  @override
  Future<void> deleteAll() => _secureStorage.deleteAll();
}
