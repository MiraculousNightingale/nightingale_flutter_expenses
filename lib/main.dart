import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:nightingale_flutter_expenses/theme_config.dart';
import 'package:nightingale_flutter_expenses/widgets/chart/chart.dart';
import 'package:provider/provider.dart';

import 'main_screen.dart';
import 'models/expense.dart';
import 'providers/expenses.dart';
import 'widgets/expense/expense_form.dart';
import 'widgets/expense/expense_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  // Localstore.instance.collection('expenses');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Expenses(),
      child: MaterialApp(
        title: 'Nightingale Flutter Expenses',
        theme: ThemeConfig.theme,
        home: const MainPage(),
      ),
    );
  }
}
