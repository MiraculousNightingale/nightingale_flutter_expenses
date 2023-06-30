import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:nightingale_flutter_expenses/theme_config.dart';
import 'package:nightingale_flutter_expenses/widgets/chart/chart.dart';
import 'package:provider/provider.dart';

import 'models/expense.dart';
import 'providers/expenses.dart';
import 'widgets/expense/expense_form.dart';
import 'widgets/expense/expense_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  // Localstore.instance.collection('expenses');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Expenses(),
      child: MaterialApp(
        title: 'Nightingale Flutter Expenses',
        theme: ThemeConfig.theme,
        home: const MainPage(),
      ),
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
      title: 'Transaction 1',
      amount: 228,
      type: ExpenseType.food,
      date: DateTime.now(),
      id: 'cock1',
    ),
    Expense(
      title: 'Transaction 2',
      amount: 322,
      type: ExpenseType.leisure,
      date: DateTime.now(),
      id: 'cock2',
    ),
    Expense(
      title: 'Transaction 3',
      amount: 822,
      type: ExpenseType.travel,
      date: DateTime.now(),
      id: 'cock3',
    ),
  ];

  void _showTransactionForm(BuildContext context) {
    final emptyExpense = Expense.empty();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (builderContext) {
        return ExpenseForm(
          expense: emptyExpense,
          isCreateMode: true,
        );
      },
    );
  }

  List<Expense> get _recentTransactions {
    return _userTransactions
        .where(
          (element) => element.date.isAfter(
            DateTime.now().subtract(const Duration(days: 7)),
          ),
        )
        .toList();
  }

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

    final providerExpenses = Provider.of<Expenses>(context, listen: false);

    final SizedBox expenseList = SizedBox(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: FutureBuilder(
          future: providerExpenses.fetchAndSetExpenses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return Consumer<Expenses>(builder: (context, value, child) {
              return ExpenseList(
                expenses: value.expenses,
              );
            });
          }),
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
                    : expenseList,
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
              if (!isLandscape) expenseList,
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
