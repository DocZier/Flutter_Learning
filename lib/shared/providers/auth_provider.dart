import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/data/repositories/auth_repository.dart';
import '../data/user_model.dart';
import '../state/auth_state.dart';

part 'auth_provider.g.dart';
//TODO rework to UseCase
@riverpod
class Auth extends _$Auth {

  late final AuthRepository _repository;

  @override
  AuthState build() {
    _repository = GetIt.I<AuthRepository>();
    final user = _repository.checkAuthStatus();
    if (user != null) {
      return Authenticated(user: User.fromEntity(user));
    }
    return const Unauthenticated();
  }

  void updateState(AuthState state) {
    state = state;
  }

  void logout() {
    GetIt.I<AuthRepository>().logout();
    updateState(Unauthenticated());
  }
}