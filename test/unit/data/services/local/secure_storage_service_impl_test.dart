import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sportying_app/data/services/local/secure_storage_service_impl.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  test('SecureStorageServiceImpl delegates all storage methods', () async {
    final storage = MockFlutterSecureStorage();
    final service = SecureStorageServiceImpl(secureStorage: storage);
    when(() => storage.read(key: 'token')).thenAnswer((_) async => 'value');
    when(() => storage.write(key: 'token', value: 'value')).thenAnswer((_) async {});
    when(() => storage.delete(key: 'token')).thenAnswer((_) async {});
    when(() => storage.deleteAll()).thenAnswer((_) async {});

    expect(await service.read('token'), equals('value'));
    await service.write('token', 'value');
    await service.delete('token');
    await service.deleteAll();

    verify(() => storage.read(key: 'token')).called(1);
    verify(() => storage.write(key: 'token', value: 'value')).called(1);
    verify(() => storage.delete(key: 'token')).called(1);
    verify(() => storage.deleteAll()).called(1);
  });
}
