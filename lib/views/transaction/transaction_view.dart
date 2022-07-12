import 'package:flutter/material.dart';

import '../../models/transaction.dart';
import 'transaction_form.dart';
import 'transaction_list.dart';

class TransactionView extends StatefulWidget {
  const TransactionView({Key? key}) : super(key: key);

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  final List<Transaction> _getTransactions = [
    Transaction(
        title: 'Transaction 1', amount: 228, date: DateTime.now(), id: 'cock1'),
    Transaction(
        title: 'Transaction 2', amount: 322, date: DateTime.now(), id: 'cock2'),
    Transaction(
        title: 'Transaction 3', amount: 822, date: DateTime.now(), id: 'cock3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionForm(),
        TransactionList(userTransactions: _getTransactions),
      ],
    );
  }
}