import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  TransactionForm({
    required this.addTx,
    Key? key,
  }) : super(key: key);

  final Function addTx;

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
                addTx(titleInputCtrl.text, double.parse(amountInputCtrl.text));
              },
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
