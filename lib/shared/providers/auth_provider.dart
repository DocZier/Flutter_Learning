import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/data/repositories/auth_repository.dart';
import '../state/auth_state.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  AuthState build() {
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