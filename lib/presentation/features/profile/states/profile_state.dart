import '../../../../core/models/shared/user_model.dart';

class ProfileState {
  final UserModel user;

  ProfileState({
    required this.user,
  });

  ProfileState copyWith({
    UserModel? user,
  }) {
    return ProfileState(
      user: user ?? this.user,
    );
  }
}