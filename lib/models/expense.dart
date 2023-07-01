import 'package:flutter/material.dart';

enum ExpenseType {
  none,
  food,
  travel,
  leisure,
  work,
}

class Expense {
  static ExpenseType expenseTypeFromString(String str) {
    return ExpenseType.values
        .firstWhere((element) => element.name.compareTo(str) == 0);
  }

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
  });

  Expense.empty()
      : id = '',
        title = '',
        amount = 0,
        type = ExpenseType.none,
        date = emptyDate;

  Expense.fromExpense(Expense expense)
      : id = expense.id,
        title = expense.title,
        amount = expense.amount,
        type = expense.type,
        date = expense.date;

  Expense.fromLocalstore(String key, Map<String, dynamic> value)
      : id = key.replaceFirst('/expenses/', ''),
        title = value[keyTitle],
        amount = value[keyAmount],
        type = expenseTypeFromString(value[keyType]),
        date = DateTime.fromMicrosecondsSinceEpoch(value[keyDate]);

  Map<String, dynamic> toJson() => {
        keyTitle: title,
        keyAmount: amount,
        keyType: type.name,
        keyDate: date.microsecondsSinceEpoch,
      };

  final String id;
  String title;
  double amount;
  ExpenseType type;
  DateTime date;
  static final emptyDate = DateTime.fromMicrosecondsSinceEpoch(0);

  static const keyTitle = 'title';
  static const keyAmount = 'amount';
  static const keyType = 'type';
  static const keyDate = 'date';

  static const expenseTypeToIconMap = {
    ExpenseType.food: Icons.restaurant,
    ExpenseType.leisure: Icons.chair,
    ExpenseType.none: Icons.deselect,
    ExpenseType.travel: Icons.travel_explore,
    ExpenseType.work: Icons.work,
  };

  IconData get typeIcon => expenseTypeToIconMap[type] ?? Icons.deselect;
}
