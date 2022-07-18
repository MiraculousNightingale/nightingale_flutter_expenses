import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nightingale_flutter_expenses/views/chart/chart.dart';

import 'models/transaction.dart';
import 'views/transaction/transaction_form.dart';
import 'views/transaction/transaction_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.deepPurple[400],
        fontFamily: 'Quicksand',
        textTheme: const TextTheme(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        title: 'Transaction 1', amount: 228, date: DateTime.now(), id: 'cock1'),
    Transaction(
        title: 'Transaction 2', amount: 322, date: DateTime.now(), id: 'cock2'),
    Transaction(
        title: 'Transaction 3', amount: 822, date: DateTime.now(), id: 'cock3'),
  ];

  void _addTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      id: 'cock${Random().nextInt(256)}',
      date: DateTime.now(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _showTransactionForm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builderContext) {
          return TransactionForm(addTx: _addTransaction);
        });
  }

  List<Transaction> get _recentTransactions =>
      _userTransactions.where((element) =>
          element.date.isAfter(
            DateTime.now().subtract(const Duration(days: 7)))).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test text'),
        actions: [
          IconButton(
              onPressed: () => _showTransactionForm(context),
              icon: const Icon(Icons.add)),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _userTransactions.isEmpty ? const CircularProgressIndicator() : Chart(recentTransactions: _recentTransactions,),
              TransactionList(userTransactions: _userTransactions),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showTransactionForm(context),
      ),
    );
  }
}
