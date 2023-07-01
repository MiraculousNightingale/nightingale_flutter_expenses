import 'package:flutter/material.dart';
import 'package:nightingale_flutter_expenses/widgets/chart/type_chart.dart';
import 'package:provider/provider.dart';

import 'models/expense.dart';
import 'providers/expenses.dart';
import 'widgets/chart/chart.dart';
import 'widgets/expense/expense_form.dart';
import 'widgets/expense/expense_list.dart';

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
    return Provider.of<Expenses>(context, listen: false)
        .expenses
        .where(
          (element) => element.date.isAfter(
            DateTime.now().subtract(const Duration(days: 7)),
          ),
        )
        .toList();
  }

  bool _showChart = false;
  bool _showTypeChart = false;

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final AppBar appBar = AppBar(
      title: const Text('Personal Expenses'),
      actions: [
        IconButton(
          onPressed: () => setState(() {
            _showTypeChart = !_showTypeChart;
          }),
          icon: const Icon(Icons.swap_horiz),
        ),
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

    final chart = _showTypeChart
        ? TypeChart(expenses: providerExpenses.expenses)
        : Chart(recentTransactions: _recentTransactions);

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
                        child: chart,
                      )
                    : expenseList,
              if (!isLandscape)
                SizedBox(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: chart,
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
