import 'package:test_practic/core/models/progress/stats_model.dart';
import '../../../../core/models/shared/learining_progress_enity.dart';

class ProgressState {
  final bool isLoading;
  final bool isError;
  final String? errorMessage;
  final StatisticsModel? statistics;
  final List<LearningProgressModel>? progressHistory;

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
    StatisticsModel? statistics,
    List<LearningProgressModel>? progressHistory,
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