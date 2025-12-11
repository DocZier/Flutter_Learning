class UserLocalDto {
  final int id;
  final String login;
  final String email;
  final DateTime createdAt;

  UserLocalDto({
    required this.id,
    required this.login,
    required this.email,
    required this.createdAt,
  });

  factory UserLocalDto.fromJson(Map<String, dynamic> json) {
    return UserLocalDto(
      id: json['id'] as int,
      login: json['login'] as String,
      email: json['email'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'email': email,
      'created_at': createdAt.toIso8601String(),
    };
  }
}