class UserModel {
  final int id;
  final String login;
  final String email;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.login,
    required this.email,
    required this.createdAt,
  });

  UserModel copyWith({
    String? login,
    String? email,
  }) {
    return UserModel(
      id: id,
      login: login ?? this.login,
      email: email ?? this.email,
      createdAt: createdAt,
    );
  }
}