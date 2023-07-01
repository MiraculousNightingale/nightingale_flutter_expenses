import 'package:flutter/material.dart';

class TypeChartBar extends StatelessWidget {
  const TypeChartBar({required this.fill, Key? key}) : super(key: key);

  final double fill;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: fill,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              color: isDarkMode
                  ? theme.colorScheme.secondary
                  : theme.primaryColor.withOpacity(0.65),
            ),
          ),
        ),
      ),
    );
  }
}
