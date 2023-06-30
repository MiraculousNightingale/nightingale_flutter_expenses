import 'package:flutter/material.dart';
import 'package:nightingale_flutter_expenses/widgets/expense/expense_form_date_row.dart';
import 'package:provider/provider.dart';

import '../../models/expense.dart';
import '../../providers/expenses.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({
    required this.expense,
    required this.isCreateMode,
    Key? key,
  }) : super(key: key);

  final Expense expense;
  final bool isCreateMode;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleInputCtrl = TextEditingController();
  final _amountInputCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleInputCtrl.text = widget.expense.title;
    _titleInputCtrl.addListener(() {
      widget.expense.title = _titleInputCtrl.text;
    });
    _amountInputCtrl.text = widget.expense.amount.toString();
    _amountInputCtrl.addListener(() {
      widget.expense.amount = double.tryParse(_amountInputCtrl.text) ?? 0;
    });
  }

  @override
  void dispose() {
    _titleInputCtrl.dispose();
    _amountInputCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveExpense() async {
    final expense = widget.expense;

    if (expense.title.trim().isEmpty ||
        expense.amount <= 0 ||
        expense.type == ExpenseType.none ||
        expense.date.compareTo(Expense.emptyDate) == 0) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid data'),
          content: const Text(
            'All fields have to be filled and amount has to be larger than 0.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    if (widget.isCreateMode) {
      await Provider.of<Expenses>(
        context,
        listen: false,
      ).createExpense(expense);
      Navigator.of(context).pop();
      return;
    }

    // When editing existing record
    await Provider.of<Expenses>(context, listen: false).updateExpense(expense);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleInputCtrl,
            decoration: InputDecoration(
              labelText: 'Title',
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.deepPurpleAccent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey[900]!,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _amountInputCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Amount',
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.deepPurpleAccent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey[900]!,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text('Expense Type'),
              ),
              DropdownButton(
                value: widget.expense.type,
                items: [
                  for (final type in ExpenseType.values)
                    DropdownMenuItem(
                      value: type,
                      child: Text(
                        '${type.name[0].toUpperCase()}${type.name.substring(1)}',
                      ),
                    ),
                ],
                onChanged: (ExpenseType? value) {
                  setState(() {
                    widget.expense.type = value ?? ExpenseType.none;
                  });
                },
              ),
            ],
          ),
          ExpenseFormDateRow(expense: widget.expense),
          const SizedBox(
            height: 5,
          ),
          OutlinedButton(
            onPressed: () {
              _saveExpense();
            },
            child: Text(widget.isCreateMode ? 'Add Expense' : 'Save Expense'),
          ),
        ],
      ),
    );
  }
}
