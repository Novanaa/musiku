import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:musiku/components/icon.dart';
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
            prefixIcon: const CustomIcon(
              data: Iconsax.search_normal_copy,
              size: 24,
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
