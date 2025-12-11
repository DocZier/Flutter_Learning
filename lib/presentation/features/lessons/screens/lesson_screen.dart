import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/lesson_theory_provider.dart';

class LessonScreen extends ConsumerWidget {
  final int lessonId;

  const LessonScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(lessonTheoryProvider(lessonId));

    return asyncState.when(
      data: (state) {
        final page = state.parts[state.index];

        return Scaffold(
          appBar: AppBar(title: Text("Урок $lessonId — Теория")),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      page,
                      style: const TextStyle(fontSize: 20, height: 1.4),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: state.index == 0
                            ? null
                            : () => ref
                            .read(lessonTheoryProvider(lessonId).notifier)
                            .previous(),
                        child: const Text("Назад"),
                      ),
                    ),

                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: state.index >= state.parts.length - 1
                            ? null
                            : () => ref
                            .read(lessonTheoryProvider(lessonId).notifier)
                            .next(),
                        child: const Text("Дальше"),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                if (state.finished)
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push('/test', extra: {'id': lessonId});
                      },
                      child: const Text(
                        "Перейти к тестированию",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },

      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),

      error: (e, _) => Scaffold(
        body: Center(child: Text('Ошибка: $e')),
      ),
    );
  }
}