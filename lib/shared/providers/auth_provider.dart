import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/data/repositories/auth_repository.dart';
import '../data/user_model.dart';
import '../state/auth_state.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {

  late final AuthRepository _repository;

  @override
  AuthState build() {
    _repository = GetIt.I<AuthRepository>();
    final user = _repository.checkAuthStatus();

    if (user != null) {
      print("If statement: ${user.toString()}");
      return Authenticated(user: User.fromEntity(user));
    }
    print("Else statement: ${user.toString()}");
    return Unauthenticated();
  }

  void updateState(AuthState state) {
    this.state = state;
  }

  void logout() {
    GetIt.I<AuthRepository>().logout();
    updateState(Unauthenticated());
  }
  
  void deleteAccount() {
    _repository.deleteAccount((state as Authenticated).user.id);
    updateState(Unauthenticated());
  }
}