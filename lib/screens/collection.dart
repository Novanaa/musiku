import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musiku/components/placeholder.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/sections/collection/header.dart';
import 'package:musiku/sections/collection/list.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: ColorConstants.splashColor),
      child: const Scaffold(
        body: CollectionList(),
        appBar: CollectionHeader(),
      ),
    );
  }
}

class CollectionSearchScreen extends StatefulWidget {
  const CollectionSearchScreen({super.key});

  @override
  State<CollectionSearchScreen> createState() => _CollectionSearchScreenState();
}

class _CollectionSearchScreenState extends State<CollectionSearchScreen> {
  String keyword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: collectionSearchScreenAppBar(),
      // TODO: Implement search user collection feature
      body: const SearchWelcomeScreen(),
    );
  }

  void onTextfieldChanged(String text) {
    setState(() => keyword = text);
  }

  AppBar collectionSearchScreenAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: ColorConstants.iconColor,
      title: collectionSearchBar(),
      titleSpacing: -0,
    );
  }

  Container collectionSearchBar() {
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
