import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../provider/lessons_list_provider.dart';
import '../state/lessons_list_state.dart';

class LessonsListScreen extends ConsumerWidget {
  const LessonsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(lessonsListProvider);

    return stateAsync.when(
      data: (state) => Scaffold(
        appBar: AppBar(title: const Text("Уроки")),
        body: Column(
          children: [
            const SizedBox(height: 12),
            SizedBox(
              height: 42,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: JLPTLevel.values.map((lvl) {
                  final label = lvl.name.toUpperCase();
                  final selected = state.selectedLevel == label;

                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      label: Text(label),
                      selected: selected,
                      onSelected: (_) {
                        ref.read(lessonsListProvider.notifier).filterByLevel(label);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: state.filtered.length,
                itemBuilder: (_, i) {
                  final lesson = state.filtered[i];
                  return ListTile(
                    title: Text(lesson.title),
                    leading: lesson.completed
                        ? const Icon(Icons.check, color: Colors.green)
                        : const SizedBox(width: 24),
                    onTap: () {
                      context.push(
                        '/lesson',
                        extra: {'id': lesson.id},
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Ошибка: $e')),
    );
  }
}
