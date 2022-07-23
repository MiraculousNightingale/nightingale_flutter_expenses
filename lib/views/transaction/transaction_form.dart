import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({
    required this.addTx,
    Key? key,
  }) : super(key: key);

  final Function addTx;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
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
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        //decoration: const BoxDecoration(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Selected'
                        : DateFormat.yMMMd().format(_selectedDate!),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _presentDatePicker();
                  },
                  child: const Text(
                    'Choose Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
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
                  widget.addTx(enteredTitle, enteredAmount, _selectedDate);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
