import '../state/data_container.dart';

abstract class AuthService {
  UserData? registerUser(UserData userData);
  UserData? loginUser(String email, String password);
  UserData? updateUser(UserData userData);
}

class AuthServiceImpl extends AuthService {
  final ServerData serverData;
  AuthServiceImpl(this.serverData);

  @override
  UserData? loginUser(String email, String password) {
    return serverData.users.where(
          (user) => user.email == email && user.password == password).firstOrNull;
  }

  @override
  UserData? registerUser(UserData userData) {
    final exists = serverData.users.where((user) => user.email == userData.email).firstOrNull;
    print(exists);
    if (exists != null) return null;

    serverData.users.add(userData);
    return userData;
  }

  @override
  UserData? updateUser(UserData userData) {
    final index = serverData.users.indexWhere(
          (user) => user.email == userData.email,
    );

    if (index == -1) return null;

    serverData.users[index] = userData;
    return userData;
  }
}
