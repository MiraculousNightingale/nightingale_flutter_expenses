import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nightingale_flutter_expenses/widgets/expense/expense_form_date_row.dart';

import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({
    required this.addExpense,
    required this.expense,
    Key? key,
  }) : super(key: key);

  final Function addExpense;
  final Expense expense;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleInputCtrl = TextEditingController();
  final _amountInputCtrl = TextEditingController();
  DateTime? _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedDate = value;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _titleInputCtrl.addListener(() {
      widget.expense.title = _titleInputCtrl.text;
    });
    _amountInputCtrl.addListener(() {
      widget.expense.amount = double.tryParse(_amountInputCtrl.text) ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
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
            //onSubmitted: ,
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
          ExpenseFormDateRow(expense: widget.expense),
          const SizedBox(
            height: 5,
          ),
          OutlinedButton(
            onPressed: () {
              final String enteredTitle = _titleInputCtrl.text;
              final double? enteredAmount =
                  double.tryParse(_amountInputCtrl.text);
              if (enteredAmount != null &&
                  _selectedDate != null &&
                  (enteredTitle.isNotEmpty || enteredAmount > 0)) {
                widget.addExpense(enteredTitle, enteredAmount, _selectedDate);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add Transaction'),
          ),
        ],
      ),
    );
  }
}
