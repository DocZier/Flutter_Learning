
import 'package:test_practic/core/models/shared/user_model.dart';
import 'package:test_practic/data/datasources/remote/dto/profile_dto.dart';

extension ProfileMapper on ProfileDto {
  UserModel toModel() {
    return UserModel(
      id: id,
      login: login,
      email: email,
      createdAt: createdAt,
    );
  }
}

extension ProfileModelMapper on UserModel {
  ProfileDto toDto() {
    return ProfileDto(
      id: id,
      login: login,
      email: email,
      createdAt: createdAt,
    );
  }
}