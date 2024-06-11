import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musiku/components/placeholder.dart';
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

class DirectorySearchScreen extends StatefulWidget {
  const DirectorySearchScreen({super.key});

  @override
  State<DirectorySearchScreen> createState() => _DirectorySearchScreenState();
}

class _DirectorySearchScreenState extends State<DirectorySearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: ColorConstants.iconColor,
        title: directorySearchBar(),
        titleSpacing: -0,
      ),
      body: ListView(
        children: const [SearchWelcomeScreen()],
      ),
    );
  }

  // TODO: Implement directory search feature
  void onTextfieldChanged(String text) {}

  Container directorySearchBar() {
    return Container(
      padding: const EdgeInsets.only(right: 15),
      child: TextField(
        onChanged: onTextfieldChanged,
        style: const TextStyle(
            color: ColorConstants.textColor,
            fontWeight: FontWeight.w500,
            fontSize: 13.5),
        cursorColor: ColorConstants.textColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorConstants.inputColor,
          prefixIcon: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/search.svg"),
            color: ColorConstants.iconColor,
          ),
          hintText: "What are you looking for?",
          hintStyle: const TextStyle(
              color: ColorConstants.textColor,
              fontWeight: FontWeight.w500,
              fontSize: 13.5),
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
