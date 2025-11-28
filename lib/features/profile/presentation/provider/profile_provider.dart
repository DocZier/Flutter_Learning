import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_practic/shared/providers/auth_provider.dart';

import '../../../../shared/data/user_model.dart';
import '../../../../shared/state/auth_state.dart';
import '../../data/repositories/profile_repository.dart';
import '../states/profile_state.dart';

part 'profile_provider.g.dart';

@riverpod
class Profile extends _$Profile {
  late final ProfileRepository _profileRepository;

  late final GlobalKey<FormState> formKey;
  late final TextEditingController username;

  @override
  Future<ProfileState> build() async {
    _profileRepository = GetIt.I<ProfileRepository>();
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
      final user = ref.read(authProvider);
      final userId = (user as Authenticated).user.id;
      final entity = await _profileRepository.getProfile(userId);

      return ProfileState(user: User.fromEntity(entity));
    } catch (e) {
      rethrow;
    }
  }


  void logout() {
    _profileRepository.logout();
    ref.read(authProvider.notifier).logout();
  }

  Future<void> updateProfile() async {
    try {
      final user = (ref.read(authProvider) as Authenticated).user;
      await _profileRepository.saveProfile(user.copyWith(login: username.text), user.id);

      final entity = await _profileRepository.getProfile(user.id);

      ProfileState(user: User.fromEntity(entity));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProfile() async {
    try {
      final user = (ref.read(authProvider) as Authenticated).user;
      await _profileRepository.deleteProfile(user.id);
      _profileRepository.logout();

      ref.read(authProvider.notifier).logout();
    } catch (e) {
      rethrow;
    }
  }
}