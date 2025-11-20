
import 'package:get_it/get_it.dart';
import 'package:test_practic/state/data_container.dart';

import '../services/auth_service.dart';

void registerModule() {
  GetIt.I.registerSingleton<ServerData>(ServerData(users: [UserData(username: "test", email: "test@test.com", password: "test", decks: [])]));
  GetIt.I.registerLazySingleton<AuthService>(() {
    return AuthServiceImpl(GetIt.I<ServerData>());
  });
}