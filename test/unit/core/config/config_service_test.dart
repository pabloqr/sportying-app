import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportying_app/core/config/config_service.dart';
import 'package:sportying_app/core/config/constants.dart';
import 'package:sportying_app/data/services/local/shared_prefs_storage_service.dart';

void main() {
  late SharedPreferences preferences;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    preferences = await SharedPreferences.getInstance();
  });

  test('ConfigService stores and resets an API URL override', () async {
    final service = ConfigService(sharedPreferences: preferences);

    expect(service.getApiUrl(), equals(Constants.baseUrl));
    expect(service.hasOverride, isFalse);

    await service.setApiUrl('https://api.test');
    expect(service.getApiUrl(), equals('https://api.test'));
    expect(service.hasOverride, isTrue);

    await service.resetApiUrl();
    expect(service.getApiUrl(), equals(Constants.baseUrl));
    expect(service.hasOverride, isFalse);
  });

  test('SharedPrefsStorageService delegates supported storage values', () async {
    final service = SharedPrefsStorageService(sharedPreferences: preferences);

    await service.setString('string', 'value');
    await service.setInt('int', 2);
    await service.setBool('bool', true);
    await service.setDouble('double', 2.5);
    await service.setStringList('list', ['one', 'two']);

    expect(service.getString('string'), equals('value'));
    expect(service.getInt('int'), equals(2));
    expect(service.getBool('bool'), isTrue);
    expect(service.getDouble('double'), equals(2.5));
    expect(service.getStringList('list'), equals(['one', 'two']));

    await service.remove('string');
    expect(service.getString('string'), isNull);

    await service.clear();
    expect(service.getInt('int'), isNull);
  });
}
