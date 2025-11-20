import '../../features/auth/domain/entities/user_entity.dart';

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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.parse(json['id']),
      login: json['login'],
      email: json['email'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'login': login,
      'email': email,
      'created_at': createdAt.toIso8601String(),
    };
  }
}