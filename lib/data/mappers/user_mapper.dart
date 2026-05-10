import 'package:sportying_app/data/services/remote/users/models/user_dto.dart';
import 'package:sportying_app/domain/models/users/user.dart';

extension UserDtoMapper on UserDto {
  User toDomain() {
    return User(
      id: id,
      role: Role.values.byName(role.toLowerCase()),
      name: name,
      surname: surname,
      mail: mail,
      phonePrefix: phonePrefix,
      phoneNumber: phoneNumber,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension UserMapper on User {
  UserDto toDto() {
    return UserDto(
      id: id,
      role: role.name,
      name: name,
      surname: surname,
      mail: mail,
      phonePrefix: phonePrefix,
      phoneNumber: phoneNumber,
      createdAt: createdAt,
      updatedAt: createdAt,
    );
  }
}
