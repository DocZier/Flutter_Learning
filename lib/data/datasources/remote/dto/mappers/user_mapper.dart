import 'package:test_practic/core/models/shared/user_model.dart';
import '../user_dto.dart';

extension UserMapper on UserDto {
  UserModel toModel() {
    return UserModel(
      id: id,
      login: login,
      email: email,
      createdAt: createdAt,
    );
  }
}

extension UserModelMapper on UserModel {
  UserDto toDto() {
    return UserDto(
      id: id,
      login: login,
      email: email,
      password: '',
      createdAt: createdAt,
    );
  }
}