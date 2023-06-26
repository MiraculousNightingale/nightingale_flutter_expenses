import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/expense.dart';

class ExpenseFormDateRow extends StatefulWidget {
  const ExpenseFormDateRow({required this.expense, Key? key}) : super(key: key);

  final Expense expense;

  @override
  State<ExpenseFormDateRow> createState() => _ExpenseFormDateRowState();
}

class _ExpenseFormDateRowState extends State<ExpenseFormDateRow> {
  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
      widget.expense.date = pickedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateText = _selectedDate == null
        ? 'No Date Selected'
        : DateFormat.yMMMd().format(_selectedDate!);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(dateText),
        ),
        ElevatedButton(
          onPressed: _pickDate,
          child: const Text(
            'Choose Date',
          ),
        ),
      ],
    );
  }
}
