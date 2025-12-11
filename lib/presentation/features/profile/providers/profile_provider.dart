import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_practic/domain/usecases/auth/logout_usecase.dart';
import 'package:test_practic/domain/usecases/profile/delete_profile_usecase.dart';
import 'package:test_practic/domain/usecases/profile/get_profile_usecase.dart';
import 'package:test_practic/domain/usecases/profile/save_profile_usecase.dart';
import 'package:test_practic/presentation/shared/providers/auth_provider.dart';
import '../../../shared/states/auth_state.dart';
import '../states/profile_state.dart';

part 'profile_provider.g.dart';

@riverpod
class Profile extends _$Profile {
  late final GetProfileUseCase _getProfileUseCase;
  late final SaveProfileUseCase _saveProfileUseCase;
  late final DeleteProfileUseCase _deleteProfileUseCase;
  late final LogoutUseCase _logoutUseCase;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController username;

  @override
  Future<ProfileState> build() async {
    _getProfileUseCase = GetIt.I<GetProfileUseCase>();
    _saveProfileUseCase = GetIt.I<SaveProfileUseCase>();
    _deleteProfileUseCase = GetIt.I<DeleteProfileUseCase>();
    _logoutUseCase = GetIt.I<LogoutUseCase>();

    final user = await _loadProfile();
    username = TextEditingController(text: user.user.login);
    formKey = GlobalKey<FormState>();
    ref.onDispose(() {
      username.dispose();
    });
    return user;
  }

  Future<ProfileState> _loadProfile() async {
    try {
      final authState = ref.read(authProvider);
      final userId = (authState as Authenticated).user.id;
      final entity = await _getProfileUseCase.execute(userId);
      return ProfileState(user: entity);
    } catch (e) {
      rethrow;
    }
  }

  void logout() {
    _logoutUseCase.execute();
    ref.read(authProvider.notifier).logout();
  }

  Future<void> updateProfile() async {
    try {
      final user = (ref.read(authProvider) as Authenticated).user;
      await _saveProfileUseCase.execute(user.copyWith(login: username.text), user.id);
      final entity = await _getProfileUseCase.execute(user.id);
      state = AsyncValue.data(ProfileState(user: entity));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProfile() async {
    try {
      final user = (ref.read(authProvider) as Authenticated).user;
      ref.read(authProvider.notifier).deleteAccount();
      await _deleteProfileUseCase.execute(user.id);
      _logoutUseCase.execute();
      ref.read(authProvider.notifier).logout();
    } catch (e) {
      rethrow;
    }
  }
}