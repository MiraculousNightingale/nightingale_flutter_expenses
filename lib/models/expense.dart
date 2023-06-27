enum ExpenseType {
  none,
  food,
  travel,
  leisure,
  work,
}

class Expense {
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

  Expense.assignId(Expense expense)
      : id = 'random_ass id',
        title = expense.title,
        amount = expense.amount,
        type = expense.type,
        date = expense.date;

  final String id;
  String title;
  double amount;
  ExpenseType type;
  DateTime date;
  static final emptyDate = DateTime.fromMicrosecondsSinceEpoch(0);
}
