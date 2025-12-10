import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../provider/test_provider.dart';

class TestScreen extends ConsumerWidget {
  final int lessonId;
  const TestScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(lessonTestProvider(lessonId));
    return async.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: Text("Тест урока $lessonId")),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Ошибка загрузки: $e", style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text("Назад к урокам"),
              ),
            ],
          ),
        ),
      ),
      data: (state) {
        if (state.finished) {
          return Scaffold(
            appBar: AppBar(title: const Text("Тест завершён")),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.successful ? "Отличная работа!" : "Нужно еще попрактиковаться",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: state.successful ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (!state.successful)
                    Text(
                      "Вы ответили правильно на ${(state.questions.length - state.mistakes.length)}/${state.questions.length} вопросов",
                      style: const TextStyle(fontSize: 18),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    state.successful
                        ? "Урок успешно пройден!"
                        : "Все неправильные ответы добавлены в очередь на повторение",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => context.pop(),
                    child: const Text("Назад к урокам"),
                  ),
                ],
              ),
            ),
          );
        }

        if (state.questions.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text("Тест урока $lessonId")),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Нет вопросов для этого урока", style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  const Text("Возможно, урок еще не подготовлен или произошла ошибка загрузки"),
                  const SizedBox(height: 30),
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