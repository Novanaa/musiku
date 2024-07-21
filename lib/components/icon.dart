import 'package:flutter/material.dart';
import 'package:musiku/constants/color.dart';

class CustomIconButton extends StatelessWidget {
  final IconData data;
  final VoidCallback onPressed;
  final Color? color;
  const CustomIconButton(
      {super.key, required this.data, required this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(data),
      onPressed: onPressed,
      color: color ?? ColorConstants.iconColor,
    );
  }
}

class CustomIcon extends StatelessWidget {
  final IconData data;
  final Color? color;
  const CustomIcon({super.key, required this.data, this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(
      data,
      color: color ?? ColorConstants.iconColor,
    );
  }
}
