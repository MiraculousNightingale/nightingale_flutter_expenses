import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nightingale_flutter_expenses/models/transaction.dart';
import 'package:nightingale_flutter_expenses/views/chart/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({required this.recentTransactions, Key? key}) : super(key: key);

  final List<Transaction> recentTransactions;

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double sumAmount = 0;
      for (final transaction in recentTransactions) {
        if (transaction.date.day == weekDay.day &&
            transaction.date.month == weekDay.month &&
            transaction.date.year == weekDay.year) {
          sumAmount += transaction.amount;
        }
      }
      //print('Sum for day ${DateFormat.E().format(weekDay)} = $sumAmount');
      return {'day': DateFormat.E().format(weekDay), 'amount': sumAmount};
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold<double>(
        0, (previousValue, element) => previousValue + element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    //var test = groupedTransactionValues;
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
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
