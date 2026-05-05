import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportying_app/core/storage/storage_service.dart';

class SharedPrefsStorageService implements StorageService {
  SharedPrefsStorageService({required SharedPreferences sharedPreferences}) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  @override
  String? getString(String key) => _sharedPreferences.getString(key);

  @override
  Future<void> setString(String key, String value) => _sharedPreferences.setString(key, value);

  @override
  int? getInt(String key) => _sharedPreferences.getInt(key);

  @override
  Future<void> setInt(String key, int value) => _sharedPreferences.setInt(key, value);

  @override
  bool? getBool(String key) => _sharedPreferences.getBool(key);

  @override
  Future<void> setBool(String key, bool value) => _sharedPreferences.setBool(key, value);

  @override
  double? getDouble(String key) => _sharedPreferences.getDouble(key);

  @override
  Future<void> setDouble(String key, double value) => _sharedPreferences.setDouble(key, value);

  @override
  List<String>? getStringList(String key) => _sharedPreferences.getStringList(key);

  @override
  Future<void> setStringList(String key, List<String> value) => _sharedPreferences.setStringList(key, value);

  @override
  Future<void> remove(String key) => _sharedPreferences.remove(key);

  @override
  Future<void> clear() => _sharedPreferences.clear();
}
