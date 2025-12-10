import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_practic/shared/providers/auth_provider.dart';
import 'package:test_practic/shared/state/auth_state.dart';

import '../../data/repositories/stats_repository.dart';
import '../state/stats_state.dart';

part 'stats_provider.g.dart';

@riverpod
class Statistics extends _$Statistics {
  late final StatsRepository _statsRepository;
  late final int _userId;

  @override
  Future<StatisticsState> build() async {
    final authState = ref.watch(authProvider);
    if (authState is! Authenticated) {
      return StatisticsState(
        isError: true,
        errorMessage: 'Пользователь не авторизован',
      );
    }

    _userId = authState.user.id;
    _statsRepository = GetIt.I<StatsRepository>();

    try {
      final cached = _statsRepository.getCachedStatistics(_userId);
      if (cached != null) {
        return StatisticsState(
          statistics: cached,
          isLoading: false,
          isError: false,
        );
      }

      final computed = await _statsRepository.computeStatisticsForUser(_userId);
      return StatisticsState(
        statistics: computed,
        isLoading: false,
        isError: false,
      );
    } catch (e) {
      return StatisticsState(
        isLoading: false,
        isError: true,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    try {
      final newStats = await _statsRepository.refreshStatistics(_userId);
      state = AsyncValue.data(
        state.value!.copyWith(
          statistics: newStats,
          isLoading: false,
          isError: false,
        ),
      );
    } catch (e) {
      state = AsyncValue.data(
        state.value!.copyWith(
          isLoading: false,
          isError: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}