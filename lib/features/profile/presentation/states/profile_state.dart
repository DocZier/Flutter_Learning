
import '../../../../shared/data/user_model.dart';

class ProfileState {
  final User user;

  ProfileState({
    required this.user,
  });

  ProfileState copyWith({
    User? user,
  }) {
    return ProfileState(
      user: user ?? this.user,
    );
  }
}