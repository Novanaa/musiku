import 'package:flutter/material.dart';
import "package:musiku/constants/color.dart";

class TextComponent extends StatelessWidget {
  final String text;
  const TextComponent({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: ColorConstants.textColor),
    );
  }
}
