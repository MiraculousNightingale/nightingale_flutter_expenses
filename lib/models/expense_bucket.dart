import 'package:flutter/material.dart';

import 'expense.dart';

class ExpenseBucket {
  const ExpenseBucket({required this.type, required this.expenses});

  ExpenseBucket.forType(List<Expense> allExpenses, this.type)
      : expenses =
            allExpenses.where((element) => element.type == type).toList();

  final ExpenseType type;
  final List<Expense> expenses;

  double get totalExpenses => expenses.fold(
      0, (previousValue, element) => previousValue + element.amount);

  IconData get typeIcon => Expense.expenseTypeToIconMap[type] ?? Icons.deselect;
}
