import 'package:flutter/material.dart';
import 'package:musiku/constants/color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(),
    );
  }

  AppBar header() {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorConstants.backgroundColor,
      actions: [
        IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/menu.svg",
                width: 25, height: 25))
      ],
      titleTextStyle: const TextStyle(
          color: ColorConstants.textColor,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w700,
          fontSize: 16),
      title: const Text("Musiku"),
    );
  }
}
