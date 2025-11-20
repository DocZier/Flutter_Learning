import 'package:test_practic/models/decks.dart';

class AppData {
  final UserData? user;

  const AppData({ required this.user});

  AppData copyWith({UserData? user}) => AppData(
        user: user ?? this.user,
      );

  @override
  String toString() => 'AppData(user: $user)';
}

class UserData {
  final String username;
  final String email;
  final String password;
  final List<Deck> decks;

  const UserData({
    required this.username,
    required this.email,
    required this.password,
    required this.decks,
  });

  UserData copyWith({
    String? username,
    String? password,
    List<Deck>? decks,
  }) =>
      UserData(
        username: username ?? this.username,
        email: email,
        password: password ?? this.password,
        decks: decks ?? this.decks,
      );

  @override
  String toString() => 'UserData(username: $username, email: $email, password: $password, decks: $decks)';
}

class ServerData {
  final List<UserData> users;

  const ServerData({required this.users});

  ServerData copyWith({List<UserData>? users}) =>
      ServerData(users: users ?? this.users);

  @override
  String toString() => 'ServerData(users: $users)';
}