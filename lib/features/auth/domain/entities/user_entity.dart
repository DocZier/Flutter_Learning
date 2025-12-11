class UserEntity {
  final int id;
  final String login;
  final String email;
  final DateTime createdAt;

  const UserEntity({
    required this.id,
    required this.login,
    required this.email,
    required this.createdAt,
  });
}