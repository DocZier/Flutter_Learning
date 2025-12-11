class UserDto {
  final int id;
  final String login;
  final String email;
  final String password;
  final DateTime createdAt;

  UserDto({
    required this.id,
    required this.login,
    required this.email,
    required this.password,
    required this.createdAt,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: int.parse(json['id']),
      login: json['login'],
      email: json['email'],
      password: json['password'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'login': login,
      'email': email,
      'password': password,
      'created_at': createdAt.toIso8601String(),
    };
  }
}