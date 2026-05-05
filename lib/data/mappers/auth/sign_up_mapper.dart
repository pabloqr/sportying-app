import 'package:sportying_app/data/services/remote/auth/models/sign_up_dto.dart';
import 'package:sportying_app/domain/models/auth/sign_up.dart';

extension SignUpDtoMapper on SignUpDto {
  SignUp toDomain() {
    return SignUp(
      name: name,
      surname: surname,
      mail: mail,
      phonePrefix: phonePrefix,
      phoneNumber: phoneNumber,
      password: password,
    );
  }
}

extension SignUpMapper on SignUp {
  SignUpDto toDto() {
    return SignUpDto(
      name: name,
      surname: surname,
      mail: mail,
      phonePrefix: phonePrefix,
      phoneNumber: phoneNumber,
      password: password,
    );
  }
}
