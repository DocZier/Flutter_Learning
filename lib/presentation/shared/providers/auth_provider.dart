import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_practic/domain/usecases/auth/check_auth_status_usecase.dart';
import 'package:test_practic/domain/usecases/auth/logout_usecase.dart';
import 'package:test_practic/domain/usecases/profile/delete_account_usecase.dart';
import '../states/auth_state.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  late final CheckAuthStatusUseCase _checkAuthStatusUseCase;
  late final LogoutUseCase _logoutUseCase;
  late final DeleteAccountUseCase _deleteAccountUseCase;

  @override
  Future<AuthState> build() async {
    _checkAuthStatusUseCase = GetIt.I<CheckAuthStatusUseCase>();
    _logoutUseCase = GetIt.I<LogoutUseCase>();
    _deleteAccountUseCase = GetIt.I<DeleteAccountUseCase>();

    try {
      final user = await _checkAuthStatusUseCase.execute();
      if (user != null) {
        return Authenticated(user: user);
      }
      return Unauthenticated();
    } catch (e) {
      return Unauthenticated();
    }
  }

  void updateState(AuthState state) {
    this.state = AsyncValue.data(state);
  }

  void logout() {
    _logoutUseCase.execute();
    updateState(Unauthenticated());
  }

  void deleteAccount() {
    if (state.value is Authenticated) {
      final userId = (state.value as Authenticated).user.id;
      _deleteAccountUseCase.execute(userId);
      updateState(Unauthenticated());
    }
  }
}