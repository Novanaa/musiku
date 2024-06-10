import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musiku/constants/color.dart';

class SearchScreenBar extends StatefulWidget {
  final void Function(String text) onTextChanged;
  const SearchScreenBar({super.key, required this.onTextChanged});

  @override
  State<SearchScreenBar> createState() => _SearchScreenBarState();
}

class _SearchScreenBarState extends State<SearchScreenBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
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
        ));
  }

  void onTextfieldChanged(String text) {
    widget.onTextChanged(text);
  }
}
