import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spelling_app/screens/home_page.dart';
import 'package:spelling_app/services/controller.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => Controller(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
