import 'package:flutter/material.dart';
import 'package:test_practic/core/models/shared/metric.dart';

import 'metric_bar_view.dart';

class MetricBarCard extends StatelessWidget {
  final String title;
  final List<MetricModel> metrics;

  const MetricBarCard({
    super.key,
    required this.title,
    required this.metrics,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
              children:
                metrics.map( (metric) => MetricBarItem(
                    name: metric.title,
                    value: metric.value,
                    max: metric.max,
                  )).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
