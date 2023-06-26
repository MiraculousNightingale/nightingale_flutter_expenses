import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nightingale_flutter_expenses/theme_config.dart';
import 'package:nightingale_flutter_expenses/widgets/chart/chart.dart';

import 'models/expense.dart';
import 'widgets/expense/expense_form.dart';
import 'widgets/expense/expense_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nightingale Flutter Expenses',
      theme: ThemeConfig.theme,
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Expense> _userTransactions = [
    Expense(
        title: 'Transaction 1', amount: 228, date: DateTime.now(), id: 'cock1'),
    Expense(
        title: 'Transaction 2', amount: 322, date: DateTime.now(), id: 'cock2'),
    Expense(
        title: 'Transaction 3', amount: 822, date: DateTime.now(), id: 'cock3'),
  ];

  void _addTransaction(String txTitle, double txAmount, DateTime date) {
    final newTx = Expense(
      title: txTitle,
      amount: txAmount,
      id: 'cock${Random().nextInt(256)}',
      date: date,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _showTransactionForm(BuildContext context) {
    final mq = MediaQuery.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints:
          BoxConstraints(maxHeight: mq.size.height - mq.viewPadding.top),
      builder: (builderContext) {
        return ExpenseForm(
          expense: Expense.empty(),
          addExpense: _addTransaction,
        );
      },
    );
  }

  List<Expense> get _recentTransactions => _userTransactions
      .where((element) =>
          element.date != null &&
          element.date!
              .isAfter(DateTime.now().subtract(const Duration(days: 7))))
      .toList();

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final AppBar appBar = AppBar(
      title: const Text('Personal Expenses'),
      actions: [
        IconButton(
          onPressed: () => _showTransactionForm(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );
    final SizedBox txListWidget = SizedBox(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: ExpenseList(
        userTransactions: _userTransactions,
        deleteTransaction: _deleteTransaction,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Show chart'),
                    Switch(
                      value: _showChart,
                      onChanged: (newValue) =>
                          setState(() => _showChart = newValue),
                    ),
                  ],
                ),
              if (isLandscape)
                _showChart
                    ? SizedBox(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.7,
                        child: Chart(
                          recentTransactions: _recentTransactions,
                        ),
                      )
                    : txListWidget,
              if (!isLandscape)
                SizedBox(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Chart(
                    recentTransactions: _recentTransactions,
                  ),
                ),
              if (!isLandscape) txListWidget,
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showTransactionForm(context),
      ),
    );
  }
}
