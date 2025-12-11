import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_practic/core/models/progress/stats_model.dart';
import 'package:test_practic/presentation/shared/providers/auth_provider.dart';
import 'package:test_practic/presentation/shared/states/auth_state.dart';
import '../providers/progress_provider.dart';
import '../../../shared/widgets/progress/progress_ring_widget.dart';
class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    if (authState is! Authenticated) {
      return Scaffold(
        body: Center(child: Text('Пожалуйста, авторизуйтесь для просмотра статистики')),
      );
    }

    final stats = ref.watch(progressProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Прогресс обучения"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(progressProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: stats.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 60, color: Colors.red),
              const SizedBox(height: 20),
              Text("Ошибка загрузки статистики: $error"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ref.read(progressProvider.notifier).refresh();
                },
                child: const Text("Попробовать снова"),
              ),
            ],
          ),
        ),
        data: (state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.isError || state.statistics == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 60, color: Colors.red),
                  const SizedBox(height: 20),
                  Text(state.errorMessage ?? "Ошибка загрузки статистики"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(progressProvider.notifier).refresh();
                    },
                    child: const Text("Попробовать снова"),
                  ),
                ],
              ),
            );
          }

          final s = state.statistics!;
          return RefreshIndicator(
            onRefresh: () async {
              ref.read(progressProvider.notifier).refresh();
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildActivityRow(s),
                  const SizedBox(height: 24),

                  _buildProgressRingSection(s),
                  const SizedBox(height: 24),

                  _buildDetailedStatsSection(s, ref),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActivityRow(StatisticsModel stats) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActivityItem(
              icon: Icons.school,
              label: 'Дней обучения',
              value: stats.daysSinceFirstActivity.toString(),
            ),
            _buildActivityItem(
              icon: Icons.emoji_events,
              label: 'Стрик',
              value: '${stats.learningStreak} дней',
              highlight: true,
            ),
            _buildActivityItem(
              icon: Icons.calendar_today,
              label: 'Последняя активность',
              value: stats.daysSinceLastActivity == 0
                  ? 'Сегодня'
                  : '${stats.daysSinceLastActivity} дн. назад',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required String label,
    required String value,
    bool highlight = false,
  }) {
    return Column(
      children: [
        Icon(icon, size: 32, color: highlight ? Colors.amber : null),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: highlight ? Colors.amber : null,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProgressRingSection(StatisticsModel stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Общий прогресс',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ProgressRing(
              progress: stats.totalLessonsAvailable > 0
                  ? stats.completedLessons / stats.totalLessonsAvailable
                  : 0,
              label: 'Пройдено уроков',
              progressColor: Colors.blue,
            ),
            ProgressRing(
              progress: stats.testsTotalAttempts > 0
                  ? stats.testsCorrectAnswers / stats.testsTotalAttempts
                  : 0,
              label: 'Точность ответов',
              progressColor: Colors.green,
            ),
            ProgressRing(
              progress: stats.totalFlashcards > 0
                  ? (stats.totalFlashcards - stats.cardsDueToday) / stats.totalFlashcards
                  : 0,
              label: 'Выучено карточек',
              progressColor: Colors.purple,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailedStatsSection(StatisticsModel stats, WidgetRef ref) {
    final retentionColor = stats.retentionRate >= 90
        ? Colors.green
        : stats.retentionRate >= 75
        ? Colors.orange
        : Colors.red;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Детальная статистика',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildStatsCategory(
          title: 'Карточки',
          items: [
            _buildStatsItem('Колод', stats.totalDecks.toString()),
            _buildStatsItem('Всего карточек', stats.totalFlashcards.toString()),
            _buildStatsItem('К повторению сегодня', stats.cardsDueToday.toString(), highlight: true),
            _buildStatsItem('Средний Ease Factor', stats.averageEaseFactor.toStringAsFixed(2)),
          ],
        ),
        const SizedBox(height: 24),
        _buildStatsCategory(
          title: 'Уроки',
          items: [
            _buildStatsItem('Всего уроков', stats.totalLessonsAvailable.toString()),
            _buildStatsItem('Пройдено уроков', '${stats.completedLessons} (${(stats.completedLessons / stats.totalLessonsAvailable * 100).round()}%)'),
            _buildStatsItem('Эффективность обучения', '${stats.retentionRate}%', color: retentionColor),
          ],
        ),
        const SizedBox(height: 24),
        Center(
          child: ElevatedButton.icon(
            onPressed: () {
              ref.read(progressProvider.notifier).refresh();
            },
            icon: const Icon(Icons.refresh),
            label: const Text("Обновить статистику"),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCategory({required String title, required List<Widget> items}) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...items,
          ],
        ),
      ),
    );
  }

  Widget _buildStatsItem(String label, String value, {Color? color, bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color ?? (highlight ? Colors.blue : null),
            ),
          ),
        ],
      ),
    );
  }
}