import 'package:sportying_app/data/services/remote/auth/models/sign_in_dto.dart';
import 'package:sportying_app/domain/models/auth/sign_in.dart';

extension SignUpDtoMapper on SignInDto {
  SignIn toDomain() {
    return SignIn(mail: mail, password: password);
  }
}

extension SignInMapper on SignIn {
  SignInDto toDto() {
    return SignInDto(mail: mail, password: password);
  }
}
