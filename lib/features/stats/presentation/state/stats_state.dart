import '../../domain/entities/learining_progress_entry.dart';
import '../../domain/entities/stats_entity.dart';

class StatisticsState {
  final bool isLoading;
  final bool isError;
  final String? errorMessage;
  final StatisticsEntity? statistics;
  final List<LearningProgressEntry>? progressHistory;

  const StatisticsState({
    this.isLoading = false,
    this.isError = false,
    this.errorMessage,
    this.statistics,
    this.progressHistory,
  });

  StatisticsState copyWith({
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    StatisticsEntity? statistics,
    List<LearningProgressEntry>? progressHistory,
  }) {
    return StatisticsState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      statistics: statistics ?? this.statistics,
      progressHistory: progressHistory ?? this.progressHistory,
    );
  }
}