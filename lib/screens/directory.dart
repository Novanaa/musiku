import 'package:flutter/material.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/sections/directory/header.dart';

class DirectoryScreen extends StatelessWidget {
  const DirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: ColorConstants.splashColor),
      child: const Scaffold(
        appBar: DirectoryHeader(),
      ),
    );
  }
}
