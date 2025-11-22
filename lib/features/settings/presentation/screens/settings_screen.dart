import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  String _getThemeModeText(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Светлая';
      case ThemeMode.dark:
        return 'Темная';
      case ThemeMode.system:
        return 'Системная';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Настройки")),
      body: settingsState.when(
        data: (state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.isError) {
            return const Center(child: Text('Ошибка загрузки настроек'));
          }

          final settings = state.settings;

          if (settings == null) {
            return const Center(child: Text('Настройки недоступны'));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ListTile(
                  title: const Text('Тема'),
                  subtitle: Text(_getThemeModeText(settings.themeMode)),
                  trailing: DropdownButton<ThemeMode>(
                    value: settings.themeMode,
                    items: ThemeMode.values.map((mode) {
                      return DropdownMenuItem(
                        value: mode,
                        child: Text(_getThemeModeText(mode)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        ref
                            .read(settingsProvider.notifier)
                            .updateThemeMode(value);
                      }
                    },
                  ),
                ),

                ListTile(
                  title: const Text('Начало дня'),
                  subtitle: Text('${settings.startOfTheDay}:00'),
                  trailing: SizedBox(
                    width: 600,
                    child: Slider(
                      value: settings.startOfTheDay.toDouble(),
                      max: 24,
                      min: 0,
                      divisions: 24,
                      label: settings.startOfTheDay.toString(),
                      onChanged: (value) {
                        ref
                            .read(settingsProvider.notifier)
                            .updateStartOfTheDay(value.toInt());
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: () =>
                      ref.read(settingsProvider.notifier).resetSettings(),
                  icon: const Icon(Icons.restore),
                  label: const Text("Сбросить до стандартных"),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Ошибка: $error')),
      ),
    );
  }
}
