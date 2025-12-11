import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/constants/feature_constants.dart';

class MenuScreen extends  StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final features = FeaturesConstants.menuFeatures;

    const cardWidth = 110.0;
    const cardHeight = 110.0;
    const spacing = 12.0;

    List<Widget> buildRows() {
      final rows = <Widget>[];
      for (int i = 0; i < features.length; i += 2) {
        final rowChildren = <Widget>[
          _buildCard(context, features[i], cardWidth, cardHeight),
        ];
        if (i + 1 < features.length) {
          rowChildren.add(
            _buildCard(context, features[i + 1], cardWidth, cardHeight),
          );
        } else {
          rowChildren.add(const SizedBox(width: cardWidth));
        }

        rows.add(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              rowChildren[0],
              SizedBox(width: spacing),
              rowChildren[1],
            ],
          ),
        );
      }
      return rows;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Добро пожаловать')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(buildRows().length, (index) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == buildRows().length - 1 ? 0 : spacing,
                ),
                child: buildRows()[index],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context,
      Map<String, dynamic> item,
      double width,
      double height,
      ) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: () {
            context.push(item['route'] as String);
          },
          borderRadius: BorderRadius.circular(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item['icon'] as IconData,
                size: 28,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 4),
              Text(
                item['title'] as String,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}