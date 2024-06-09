import 'package:flutter/material.dart';
import 'package:musiku/constants/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musiku/sections/home/drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: ColorConstants.splashColor),
      child: Scaffold(
        key: _key,
        appBar: header(),
        endDrawer: const HomeScreenDrawer(),
      ),
    );
  }

  AppBar header() {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorConstants.backgroundColor,
      actions: [
        IconButton(
            onPressed: () {
              _key.currentState?.openEndDrawer();
            },
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
