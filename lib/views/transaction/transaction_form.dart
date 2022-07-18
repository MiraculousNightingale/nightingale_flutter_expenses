import 'package:flutter/material.dart';

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
  final titleInputCtrl = TextEditingController();

  final amountInputCtrl = TextEditingController();

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
              controller: titleInputCtrl,
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
              controller: amountInputCtrl,
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
              height: 5,
            ),
            OutlinedButton(
              onPressed: () {
                final String enteredTitle = titleInputCtrl.text;
                final double? enteredAmount =
                    double.tryParse(amountInputCtrl.text);
                if (enteredAmount != null &&
                    (enteredTitle.isNotEmpty || enteredAmount > 0)) {
                  widget.addTx(enteredTitle, enteredAmount);
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
