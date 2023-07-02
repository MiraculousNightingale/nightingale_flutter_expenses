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

  late final Future<void> fetchExpensesFuture;

  @override
  void initState() {
    super.initState();
    fetchExpensesFuture =
        Provider.of<Expenses>(context, listen: false).fetchAndSetExpenses();
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

    final expenseList = SizedBox(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: FutureBuilder(
          future: fetchExpensesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return Consumer<Expenses>(
              builder: (context, value, child) =>
                  ExpenseList(expenses: value.expenses),
            );
          }),
    );

    final chart = Consumer<Expenses>(
      builder: (context, value, child) => _showTypeChart
          ? TypeChart(expenses: value.expenses)
          : Chart(recentTransactions: value.recentExpenses),
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
