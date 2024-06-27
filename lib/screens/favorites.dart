import 'package:flutter/material.dart';
import 'package:musiku/constants/color.dart';

class FavoritesMusicScreen extends StatelessWidget {
  const FavoritesMusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: favoritesMusicScreenAppBar(),
    );
  }

  AppBar favoritesMusicScreenAppBar() {
    return AppBar(
      title: const Text("Favorites Music"),
      elevation: 0,
      titleTextStyle: const TextStyle(
          color: ColorConstants.textColor,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w700,
          fontSize: 17),
      backgroundColor: ColorConstants.backgroundColor,
      foregroundColor: ColorConstants.textColor,
    );
  }
}
