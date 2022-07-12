import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  TransactionForm({Key? key}) : super(key: key);

  final titleInputCtrl = TextEditingController();
  final amountInputCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleInputCtrl,
              decoration: InputDecoration(
                labelText: 'Title',
                focusedBorder: OutlineInputBorder(
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
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: amountInputCtrl,
              decoration: InputDecoration(
                labelText: 'Amount',
                focusedBorder: OutlineInputBorder(
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
                //TODO: cock
              },
              child: Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
