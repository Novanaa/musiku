import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/sections/directory/item.dart';

class DirectoryListBuilder extends StatelessWidget {
  DirectoryListBuilder({super.key});

  final DirectoryController directoryController =
      Get.put(DirectoryController());

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Obx(() => ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 10),
            itemCount: directoryController.directory.length,
            itemBuilder: (BuildContext context, int index) =>
                DirectoryItem(item: directoryController.directory[index]))));
  }
}
