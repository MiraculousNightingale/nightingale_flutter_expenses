import 'package:flutter/material.dart';

class ThemeConfig {
  static final defaultTheme = ThemeData();
  static final theme = defaultTheme.copyWith(
    useMaterial3: true,
    colorScheme: colorScheme,
    appBarTheme: appBarTheme,
    cardTheme: cardTheme,
    elevatedButtonTheme: elevatedButtonTheme,
    textTheme: textTheme,
  );

  static final colorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 96, 59, 181),
    onSecondary: Colors.black,
    onSecondaryContainer: Colors.black,
  );

  static const colorSchemeDark = null;

  static final appBarTheme = defaultTheme.appBarTheme.copyWith(
    backgroundColor: colorScheme.onPrimaryContainer,
    foregroundColor: colorScheme.primaryContainer,
  );

  static final cardTheme = defaultTheme.cardTheme.copyWith(
    color: colorScheme.secondaryContainer,
    margin: const EdgeInsets.symmetric(vertical: 8),
  );

  static final elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: colorScheme.primaryContainer,
    ),
  );

  static final textTheme = defaultTheme.textTheme.copyWith(
    titleSmall: TextStyle(
      fontWeight: FontWeight.bold,
      color: colorScheme.onSecondaryContainer,
      fontSize: 16,
    ),
  );
}
