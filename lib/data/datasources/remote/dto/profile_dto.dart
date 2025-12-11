class ProfileDto {
  final int id;
  final String login;
  final String email;
  final DateTime createdAt;

  ProfileDto({
    required this.id,
    required this.login,
    required this.email,
    required this.createdAt,
  });

  factory ProfileDto.fromJson(Map<String, dynamic> json) {
    return ProfileDto(
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