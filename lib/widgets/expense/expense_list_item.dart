import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/expense.dart';
import '../../providers/expenses.dart';
import 'expense_form.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem({required this.expense, Key? key}) : super(key: key);

  final Expense expense;

  // Experimenting with delete confirmation
  // Not perfect though, if the app is closed
  // I doubt the future will execute

  // I assume such confirmation would better be handled by the server with
  // two requests, one to initiate confirmation waiting and the other to execute
  Future<void> _deleteExpense(BuildContext context) async {
    final provExpenses = Provider.of<Expenses>(context, listen: false);
    final removedIndex = provExpenses.removeExpenseFromList(expense.id);
    final sm = ScaffoldMessenger.of(context);
    sm.removeCurrentSnackBar();
    Future.delayed(
      const Duration(seconds: 4),
      () {
        if (!provExpenses.expenses.contains(expense)) {
          provExpenses.deleteExpenseFromLocalstore(expense.id);
        }
      },
    );
    sm.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense record was removed!'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            provExpenses.insertExpenseIntoList(removedIndex, expense);
          },
        ),
      ),
    );
  }

  void _showEditingForm(BuildContext context) {
    // View.of(context) can be used to consistently get screen padding and size(if needed)
    // MediaQuery padding values don't work since this widget's context has no padding.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (builderContext) {
        return ExpenseForm(
          expense: expense,
          isCreateMode: false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                '\$${expense.amount}',
              ),
            ),
          ),
        ),
        title: Text(
          expense.title,
          style: theme.textTheme.titleSmall,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(expense.date),
          style: theme.textTheme.titleSmall,
        ),
        trailing: mq.size.width > 460
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _showEditingForm(context),
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    label: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _deleteExpense(context),
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    label: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => _showEditingForm(context),
                    icon: const Icon(Icons.edit),
                    color: Colors.black,
                  ),
                  IconButton(
                    onPressed: () => _deleteExpense(context),
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.red[900],
                  ),
                ],
              ),
      ),
    );
  }
}
