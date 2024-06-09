import 'package:flutter/material.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/sections/home/drawer.dart';
import 'package:musiku/sections/home/header.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: ColorConstants.splashColor),
      child: Scaffold(
        key: _key,
        appBar: HomeScreenHeader(
            openDrawer: () => _key.currentState?.openEndDrawer()),
        endDrawer: const HomeScreenDrawer(),
      ),
    );
  }
}
