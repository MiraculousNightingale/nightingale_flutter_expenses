import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nightingale_flutter_expenses/widgets/expense/expense_list_item.dart';

import '../../models/expense.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({
    required this.expenses,
    Key? key,
  }) : super(key: key);

  final List<Expense> expenses;

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 440,
      child: widget.expenses.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    const Text("There are no transactions yet"),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset('assets/image/waiting.png'),
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ExpenseListItem(expense: widget.expenses[index]);
              },
              itemCount: widget.expenses.length,
            ),
    );
  }
}
