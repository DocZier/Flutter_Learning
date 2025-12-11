import '../../../../core/models/shared/learining_progress_enity.dart';
import '../../../../core/models/progress/stats_entity.dart';

class ProgressState {
  final bool isLoading;
  final bool isError;
  final String? errorMessage;
  final StatisticsEntity? statistics;
  final List<LearningProgressEntity>? progressHistory;

  const ProgressState({
    this.isLoading = false,
    this.isError = false,
    this.errorMessage,
    this.statistics,
    this.progressHistory,
  });

  ProgressState copyWith({
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    StatisticsEntity? statistics,
    List<LearningProgressEntity>? progressHistory,
  }) {
    return ProgressState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      statistics: statistics ?? this.statistics,
      progressHistory: progressHistory ?? this.progressHistory,
    );
  }
}