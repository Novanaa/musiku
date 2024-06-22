import 'package:flutter/material.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/model.dart';

void openSortMusicBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) => const SortMusicBottomSheet(),
      isScrollControlled: true,
      backgroundColor: ColorConstants.modalBackgroundColor);
}

class SortMusicBottomSheet extends StatefulWidget {
  const SortMusicBottomSheet({super.key});

  @override
  State<SortMusicBottomSheet> createState() => _SortMusicBottomSheetState();
}

class _SortMusicBottomSheetState extends State<SortMusicBottomSheet> {
  int selectedId = 1;

  @override
  void initState() {
    super.initState();
    // TODO: Implement get sort music method on init state
    setState(() => selectedId = 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Column(
        children: [
          shortMusicBottomSheetHeader(),
          shotMusicBottomSheetOptionsList()
        ],
      ),
    );
  }

  Container shortMusicBottomSheetHeader() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: const Center(
          child: Text("Pick music categories!",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16))),
    );
  }

  Container shotMusicBottomSheetOptionsList() {
    List<SortMusicModel> sortMethodList = [
      SortMusicModel(id: 1, title: "Recently music added"),
      SortMusicModel(id: 2, title: "Lately music added"),
      SortMusicModel(id: 3, title: "By alphabet (ascending)"),
      SortMusicModel(id: 4, title: "By alphabet (descending)"),
    ];

    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: sortMethodList
              .map(
                (value) => InkWell(
                  onTap: () => setState(() => selectedId = value.id),
                  borderRadius: BorderRadius.circular(5),
                  child: Row(
                    children: [
                      Radio(
                        value: value.id,
                        onChanged: (checkedId) {},
                        groupValue: selectedId,
                        activeColor: ColorConstants.textColor,
                      ),
                      Text(
                        value.title,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              )
              .toList()),
    );
  }
}
