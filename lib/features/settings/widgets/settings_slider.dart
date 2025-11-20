import 'package:flutter/material.dart';

class SettingsSliderTile extends StatelessWidget {
  final String title;
  final double value;
  final void Function(double) onChanged;

  const SettingsSliderTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Slider(
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
