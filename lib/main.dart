import 'package:flutter/material.dart';
import 'package:musiku/screens/layout.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Layout(),
      theme: ThemeData(splashColor: Colors.transparent),
    );
  }
}
