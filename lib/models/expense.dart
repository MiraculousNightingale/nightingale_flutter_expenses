class Expense {
  Expense(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});

  Expense.empty()
      : id = '',
        title = '',
        amount = 0,
        date = DateTime.fromMicrosecondsSinceEpoch(0);

  Expense.assignId(Expense expense)
      : id = 'random_ass id',
        title = expense.title,
        amount = expense.amount,
        date = expense.date;

  final String id;
  String title;
  double amount;
  DateTime date;
}
