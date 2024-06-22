import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/constants/common.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/model.dart';

void openSortMusicBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) => SortMusicBottomSheet(),
      isScrollControlled: true,
      backgroundColor: ColorConstants.modalBackgroundColor);
}

class SortMusicBottomSheet extends StatelessWidget {
  SortMusicBottomSheet({super.key});

  final SortMusicController sortMusicController =
      Get.put(SortMusicController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Column(
        children: [
          shortMusicBottomSheetHeader(),
          shortMusicBottomSheetOptionsList()
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

  Container shortMusicBottomSheetOptionsList() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Obx(
        () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: CommonConstants.sortMethodList
                .map(
                  (value) => InkWell(
                    onTap: () => onChecked(value),
                    borderRadius: BorderRadius.circular(5),
                    child: Row(
                      children: [
                        Radio(
                          value: value.id,
                          onChanged: (checkedId) {},
                          groupValue: sortMusicController.sortMusicState.value,
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
      ),
    );
  }

  void onChecked(SortMusicModel value) {
    sortMusicController.setSortMusicState(value.id);
    Get.back();
  }
}

void openRepeatModeBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) => const RepeatModeDrawer(),
      isScrollControlled: true,
      backgroundColor: ColorConstants.modalBackgroundColor);
}

class RepeatModeDrawer extends StatelessWidget {
  const RepeatModeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [repeatModeDrawerHeader(), repeatModeDrawerOptionsList()],
      ),
    );
  }

  Container repeatModeDrawerHeader() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: const Center(
        child: Text("Music Repeat Mode",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
      ),
    );
  }

  Container repeatModeDrawerOptionsList() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: CommonConstants.repeatModeList
              .map(
                (value) => InkWell(
                  onTap: () => onChecked(value),
                  borderRadius: BorderRadius.circular(5),
                  child: Row(
                    children: [
                      Radio(
                        value: value.id,
                        onChanged: (checkedId) {},
                        groupValue: 1,
                        activeColor: ColorConstants.textColor,
                      ),
                      Text(
                        value.name,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              )
              .toList()),
    );
  }

  void onChecked(RepeatModeModel value) {
    Get.back();
  }
}
