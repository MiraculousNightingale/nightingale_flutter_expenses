import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    required this.userTransactions,
    Key? key,
  }) : super(key: key);

  final List<Transaction> userTransactions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: userTransactions.map((transaction) {
        return Card(
            child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.deepPurple[100],
                border: Border.all(color: Colors.deepPurple, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(
                '\$ ${transaction.amount}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat.yMMMd().format(transaction.date),
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ],
        ));
      }).toList(),
    );
  }
}
