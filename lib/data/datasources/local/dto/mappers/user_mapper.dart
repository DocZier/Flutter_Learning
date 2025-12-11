import 'package:test_practic/core/models/shared/user_model.dart';
import 'package:test_practic/data/datasources/local/dto/user_dto.dart';

extension UserLocalMapper on UserLocalDto {
  UserModel toModel() {
    return UserModel(
      id: id,
      login: login,
      email: email,
      createdAt: createdAt,
    );
  }
}

extension UserModelLocalMapper on UserModel {
  UserLocalDto toLocalDto() {
    return UserLocalDto(
      id: id,
      login: login,
      email: email,
      createdAt: createdAt,
    );
  }
}