import 'package:flutter/material.dart';

class MetricBarItem extends StatelessWidget {
  final String name;
  final int value;
  final int max;

  const MetricBarItem({
    super.key,
    required this.name,
    required this.value,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (max >= 0) ? (value / max) : 0.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$name: $value',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Theme
                .of(context)
                .primaryColor),
            minHeight: 10,
          ),
        ],
      ),
    );
  }
}
