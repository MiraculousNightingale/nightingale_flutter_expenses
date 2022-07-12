import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nightingale_flutter_expenses/views/transaction/transaction_view.dart';

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
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test text'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Chart'),
            ),
            TransactionView(),
          ],
        ),
      ),
    );
  }
}


