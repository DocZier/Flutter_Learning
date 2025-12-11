import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/providers/auth_provider.dart';
import '../providers/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);

    return   Scaffold(
        appBar: AppBar(title: const Text("Профиль")),
        body: profileState.when(
        data: (state) {
          final user = state.user;
          print(user.toString());
          return Center(
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
                              user.login,
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
                              user.email,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  const SizedBox(height: 24),

                  const Divider(),
                  const SizedBox(height: 24),

                  ElevatedButton(
                    onPressed: () => _deleteAccount(context, ref),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("Удалить аккаунт"),
                  ),

                  const Spacer(),

                  TextButton(
                    onPressed: () {
                      context.go('/login');
                      ref.read(authProvider.notifier).logout();
                      ref.read(profileProvider.notifier).logout();
                    },
                    child: const Text("Выйти из аккаунта"),
                  ),
                ],
              ),
            ),
          );
        },
            error: (error, stack) => Center(child: Text('Error: $error')),
            loading: () => const Center(child: CircularProgressIndicator()),
        )

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
              bool isUpdated = false;
              try
              {
                ref.read(profileProvider.notifier).updateProfile();
                Navigator.pop(context);
                isUpdated = true;
              }
              catch (e){
                isUpdated = false;
              }
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
              bool isDeleted = false;
              try {
                ref.read(profileProvider.notifier).deleteProfile();
                context.go('/login');
                isDeleted = true;
              }
              catch (e) {
                isDeleted = false;
              }
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
