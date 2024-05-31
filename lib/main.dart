import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:main/navigation.dart';

void main() async {
  await initializeDateFormatting();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sharad Calendar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const Navigation(),
    );
  }
}