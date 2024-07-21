import 'package:flutter/material.dart';
import 'package:musiku/constants/color.dart';

class CustomIconButton extends StatelessWidget {
  final IconData data;
  final VoidCallback onPressed;
  final Color? color;
  final double? size;
  const CustomIconButton(
      {super.key,
      required this.data,
      required this.onPressed,
      this.color,
      this.size});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        data,
        size: size ?? 25,
      ),
      onPressed: onPressed,
      color: color ?? ColorConstants.iconColor,
    );
  }
}

class CustomIcon extends StatelessWidget {
  final IconData data;
  final Color? color;
  final double? size;
  const CustomIcon({
    super.key,
    required this.data,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      data,
      color: color ?? ColorConstants.iconColor,
      size: size ?? 25,
    );
  }
}
