class RemoteUserSource {
  List<Map<String, dynamic>> users;

  RemoteUserSource({
    List<Map<String, dynamic>>? initialUsers,
  }) : users = initialUsers ??
      [
        {
          'id': '1',
          'login': 'test',
          'email': 'test@test.com',
          'password': 'test',
          'created_at': DateTime.now().toIso8601String(),
        }
      ];

  RemoteUserSource copyWith({
    List<Map<String, dynamic>>? users,
  }) {
    return RemoteUserSource(
      initialUsers: users ?? this.users,
    );
  }
}