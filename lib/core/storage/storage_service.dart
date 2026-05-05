abstract class StorageService {
  String? getString(String key);

  Future<void> setString(String key, String value);

  int? getInt(String key);

  Future<void> setInt(String key, int value);

  bool? getBool(String key);

  Future<void> setBool(String key, bool value);

  double? getDouble(String key);

  Future<void> setDouble(String key, double value);

  List<String>? getStringList(String key);

  Future<void> setStringList(String key, List<String> value);

  Future<void> remove(String key);

  Future<void> clear();
}
