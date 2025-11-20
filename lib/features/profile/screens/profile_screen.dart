import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../provider/app_data_provider.dart';
import '../provider/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(appDataProvider.select((data) => data.user))!;

    return Scaffold(
      appBar: AppBar(title: const Text("Профиль")),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Никнейм",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userData.username,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _changeUsername(context, ref),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Почта",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userData.email,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Пароль",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                         userData.password,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _changePassword(context, ref),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              const Divider(),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () => _resetAccount(context, ref),
                child: const Text("Сбросить аккаунт"),
              ),
              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: () => _deleteAccount(context, ref),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Удалить аккаунт"),
              ),

              const Spacer(),

              TextButton(
                onPressed: () {
                  ref.read(profileProvider.notifier).logout();
                  context.go('/login');
                },
                child: const Text("Выйти из аккаунта"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeUsername(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Изменить никнейм"),
        content: TextFormField(
          controller: ref.watch(profileProvider.notifier).username,
          decoration: const InputDecoration(labelText: "Новый никнейм"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Отмена"),
          ),
          ElevatedButton(
            onPressed: () {
              final isUpdated = ref
                  .read(profileProvider.notifier)
                  .updateProfile();
              Navigator.pop(context);
              _showResult(
                context,
                isUpdated,
                "Никнейм обновлён!",
                "Ошибка обновления",
              );
            },
            child: const Text("Сохранить"),
          ),
        ],
      ),
    );
  }

  void _changePassword(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Изменить пароль"),
        content: TextFormField(
          controller: ref.watch(profileProvider.notifier).password,
          decoration: const InputDecoration(labelText: "Новый пароль"),
          obscureText: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Отмена"),
          ),
          ElevatedButton(
            onPressed: () {
              final isUpdated = ref
                  .read(profileProvider.notifier)
                  .updateProfile();
              Navigator.pop(context);
              _showResult(
                context,
                isUpdated,
                "Пароль обновлён!",
                "Ошибка обновления",
              );
            },
            child: const Text("Сохранить"),
          ),
        ],
      ),
    );
  }

  void _resetAccount(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Сбросить аккаунт?"),
        content: const Text("Все данные будут очищены."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Отмена"),
          ),
          ElevatedButton(
            onPressed: () {
              final isReset = ref.read(profileProvider.notifier).resetUser();
              Navigator.pop(context);
              _showResult(context, isReset, "Аккаунт очищен", "Ошибка");
            },
            child: const Text("Сбросить"),
          ),
        ],
      ),
    );
  }

  void _deleteAccount(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Удалить аккаунт?"),
        content: const Text("Это действие нельзя отменить."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Отмена"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/login');
              final isDeleted = ref.read(profileProvider.notifier).deleteUser();
              _showResult(context, isDeleted, "Аккаунт удалён", "Ошибка");
            },
            child: const Text("Удалить"),
          ),
        ],
      ),
    );
  }

  void _showResult(
    BuildContext context,
    bool isSuccess,
    String success,
    String fail,
  ) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(isSuccess ? success : fail)));
  }
}
