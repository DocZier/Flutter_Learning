import 'user_entity.dart';

class User extends UserEntity {
  const User({
    required super.id,
    required super.login,
    required super.email,
    required super.createdAt,
  });

  static User fromEntity(UserEntity entity) {
    return User(
      id: entity.id,
      login: entity.login,
      email: entity.email,
      createdAt: entity.createdAt,
    );
  }

  UserEntity toEntity() =>
      UserEntity(id: id, login: login, email: email, createdAt: createdAt);

  @override
  String toString() {
    return 'User(id: $id, login: $login, email: $email, createdAt: $createdAt)';
  }

  User copyWith({String? login}) {
    return User(
      id: id,
      login: login ?? this.login,
      email: email,
      createdAt: createdAt,
    );
  }
}
