import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

enum Role { superadmin, admin, client }

@freezed
abstract class User with _$User {
  const factory User({
    required int id,
    required Role role,
    required String name,
    required String surname,
    required String mail,
    required int phonePrefix,
    required int phoneNumber,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _User;
}
