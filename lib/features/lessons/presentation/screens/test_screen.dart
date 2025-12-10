import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../provider/test_provider.dart';
import '../state/test_state.dart';

class TestScreen extends ConsumerWidget {
  final int lessonId;
  const TestScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(lessonTestProvider(lessonId));

    return async.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text("Ошибка: $e"))),
      data: (state) {
        if (state.finished) {
          return Scaffold(
            appBar: AppBar(title: const Text("Тест завершён")),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Отличная работа!", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.pop(),
                    child: const Text("Назад к урокам"),
                  ),
                ],
              ),
            ),
          );
        }

        final notifier = ref.read(lessonTestProvider(lessonId).notifier);
        final q = state.questions[state.index];

        return Scaffold(
          appBar: AppBar(title: Text("Тест урока $lessonId")),
          body: Center(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Container(
                width: 360,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${state.index + 1}/${state.questions.length}"),
                        TextButton(
                          onPressed: notifier.dontKnow,
                          child: const Text("Не знаю"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(q.question, style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
                    const SizedBox(height: 20),

                    if (!state.showCorrect)
                      ...q.options.asMap().entries.map(
                            (e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: ElevatedButton(
                            onPressed: () => notifier.selectOption(e.key),
                            child: Text(e.value),
                          ),
                        ),
                      ),

                    if (state.showCorrect) ...[
                      Text(
                        state.correct ? "Верно!" : "Неверно. Правильный ответ: ${q.options[q.correctOptionIndex]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: state.correct ? Colors.green : Colors.red,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (state.translation != null) Text(state.translation!),
                      const SizedBox(height: 12),
                      if (state.theory != null)
                        Text(state.theory!, style: const TextStyle(fontStyle: FontStyle.italic)),
                      const SizedBox(height: 20),
                      ElevatedButton(onPressed: notifier.next, child: const Text("Продолжить")),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

