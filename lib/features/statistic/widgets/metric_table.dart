import 'package:flutter/material.dart';
import 'package:test_practic/features/statistic/widgets/metric_item_view.dart';

class MetricTable extends StatelessWidget {
  final String title;
  final Map<String, String> metrics;

  const MetricTable({super.key, required this.title, required this.metrics});

  @override
  Widget build(BuildContext context) {
    return
      Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ...metrics.entries.map((metric) {
                  return MetricItem(
                    title: metric.key,
                    value: metric.value,
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
