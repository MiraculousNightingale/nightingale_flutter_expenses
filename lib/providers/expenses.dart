import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

import '../models/expense.dart';

class Expenses with ChangeNotifier {
  final _localstore = Localstore.instance;
  final _expenses = <Expense>[];

  List<Expense> get expenses => [..._expenses];

  Future<void> fetchAndSetExpenses() async {
    final expenseDocs = await _localstore.collection('expenses').get();
    if (expenseDocs != null) {
      _expenses.clear();
      for (final doc in expenseDocs.entries) {
        _expenses.add(Expense.fromLocalstore(doc.key, doc.value));
      }
      notifyListeners();
    }
  }

  Future<void> createExpense(Expense expense) async {
    await _localstore.collection('expenses').doc().set({
      Expense.keyTitle: expense.title,
      Expense.keyAmount: expense.amount,
      Expense.keyType: expense.type.name,
      Expense.keyDate: expense.date.microsecondsSinceEpoch,
    });
    _expenses.add(expense);
    notifyListeners();
  }

  Future<void> updateExpense(Expense expense) async {
    await _localstore
        .collection('expenses')
        .doc(expense.id)
        .set(expense.toJson());
    final index = _expenses.indexWhere((element) => element.id == expense.id);
    _expenses[index] = expense;
    notifyListeners();
  }

  int removeExpenseFromList(String id) {
    final index = _expenses.indexWhere((element) => element.id == id);
    _expenses.removeAt(index);
    notifyListeners();
    return index;
  }

  void insertExpenseIntoList(int atIndex, Expense expense) {
    _expenses.insert(atIndex, expense);
    notifyListeners();
  }

  Future<void> deleteExpenseFromLocalstore(String id) async {
    await _localstore.collection('expenses').doc(id).delete();
  }
}
