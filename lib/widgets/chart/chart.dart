import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nightingale_flutter_expenses/models/expense.dart';
import 'package:nightingale_flutter_expenses/widgets/chart/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({required this.recentTransactions, Key? key}) : super(key: key);

  final List<Expense> recentTransactions;

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double sumAmount = 0;
      for (final transaction in recentTransactions) {
        final date = transaction.date;
        if (date.day == weekDay.day &&
            date.month == weekDay.month &&
            date.year == weekDay.year) {
          sumAmount += transaction.amount;
        }
      }
      //print('Sum for day ${DateFormat.E().format(weekDay)} = $sumAmount');
      return {'day': DateFormat.E().format(weekDay), 'amount': sumAmount};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold<double>(
        0, (previousValue, element) => previousValue + element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withOpacity(0.3),
              theme.primaryColor.withOpacity(0),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues
              .map(
                (element) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      label: element['day'],
                      spendingAmount: element['amount'],
                      spendingPercentage: totalSpending == 0
                          ? 0.0
                          : element['amount'] / totalSpending),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
