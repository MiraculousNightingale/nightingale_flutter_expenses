import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nightingale_flutter_expenses/models/expense.dart';
import 'package:nightingale_flutter_expenses/widgets/chart/type_chart_bar.dart';

import '../../models/expense_bucket.dart';

class TypeChart extends StatelessWidget {
  const TypeChart({Key? key, required this.expenses}) : super(key: key);

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets => [
        for (final type in ExpenseType.values
            .where((element) => element != ExpenseType.none))
          ExpenseBucket.forType(expenses, type)
      ];

  double get maxTotalExpense => buckets.fold(
      0, (previousValue, element) => max(previousValue, element.totalExpenses));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    final isDarkMode = mq.platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 6,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(0.3),
            theme.primaryColor.withOpacity(0),
          ],
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets)
                  TypeChartBar(
                    fill: bucket.totalExpenses == 0
                        ? 0
                        : bucket.totalExpenses / maxTotalExpense,
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              for (final bucket in buckets)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      bucket.typeIcon,
                      color: isDarkMode
                          ? theme.colorScheme.secondary
                          : theme.primaryColor.withOpacity(0.7),
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
