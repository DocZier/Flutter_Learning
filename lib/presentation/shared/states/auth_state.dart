import '../../../core/models/shared/user_model.dart';

sealed class AuthState {
  const AuthState();
}

final class Unauthenticated extends AuthState {
  const Unauthenticated();

}
final class Authenticated extends AuthState {
  final UserModel user;

  const Authenticated({required this.user});
}