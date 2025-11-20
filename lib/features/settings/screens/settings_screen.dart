import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/settings_switch.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Настройки"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
 SettingsSwitchTile(
            title: "Тёмная тема",
            value: false,
            onChanged: (v) {},
          ),
        ],
      ),
    );
  }
}
