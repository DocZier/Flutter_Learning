import 'package:flutter/material.dart';

class MetricItem extends StatelessWidget {
  final String title;
  final String value;

  const MetricItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
        Expanded(flex: 1,child: SizedBox(),),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
