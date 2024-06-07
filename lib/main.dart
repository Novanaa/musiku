import 'package:flutter/material.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/components/text.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        body: Center(
          child: TextComponent(text: 'Hello, World!'),
        ),
      ),
    );
  }
}
