import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_practic/domain/usecases/progress/compute_statistic_usecase.dart';
import 'package:test_practic/domain/usecases/progress/get_cached_statistic_usecase.dart';
import 'package:test_practic/domain/usecases/progress/refresh_statistic_usecase.dart';
import 'package:test_practic/presentation/features/progress/states/progress_state.dart';
import 'package:test_practic/presentation/shared/providers/auth_provider.dart';
import 'package:test_practic/presentation/shared/states/auth_state.dart';


part 'progress_provider.g.dart';

@riverpod
class Progress extends _$Progress {
  late final ComputeStatisticsUseCase _computeStatsUseCase;
  late final GetCachedStatisticsUseCase _getCachedStatsUseCase;
  late final RefreshStatisticsUseCase _refreshStatsUseCase;
  late final int _userId;

  @override
  Future<ProgressState> build() async {
    _computeStatsUseCase = GetIt.I<ComputeStatisticsUseCase>();
    _getCachedStatsUseCase = GetIt.I<GetCachedStatisticsUseCase>();
    _refreshStatsUseCase = GetIt.I<RefreshStatisticsUseCase>();

    final authState = ref.watch(authProvider);
    if (authState is! Authenticated) {
      return ProgressState(
        isError: true,
        errorMessage: 'Пользователь не авторизован',
      );
    }

    _userId = authState.user.id;

    try {
      final cached = _getCachedStatsUseCase.execute(_userId);
      if (cached != null) {
        return ProgressState(
          statistics: cached,
          isLoading: false,
          isError: false,
        );
      }

      final computed = await _computeStatsUseCase.execute(_userId);
      return ProgressState(
        statistics: computed,
        isLoading: false,
        isError: false,
      );
    } catch (e) {
      return ProgressState(
        isLoading: false,
        isError: true,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    try {
      final newStats = await _refreshStatsUseCase.execute(_userId);
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