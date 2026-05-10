import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportying_app/core/config/constants.dart';

class ConfigService {
  ConfigService({required SharedPreferences sharedPreferences}) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  static const String _overrideKey = 'api_url_override';

  String getApiUrl() {
    return _sharedPreferences.getString(_overrideKey) ?? Constants.baseUrl;
  }

  Future<void> setApiUrl(String url) async {
    await _sharedPreferences.setString(_overrideKey, url);
  }

  Future<void> resetApiUrl() async {
    await _sharedPreferences.remove(_overrideKey);
  }

  bool get hasOverride => _sharedPreferences.containsKey(_overrideKey);
}
