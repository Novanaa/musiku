import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musiku/components/placeholder.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/model.dart';
import 'package:musiku/sections/directory/builder.dart';
import 'package:musiku/sections/directory/header.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:musiku/components/music.dart';

class DirectoriesScreen extends StatelessWidget {
  const DirectoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: ColorConstants.splashColor),
      child: Scaffold(
        appBar: const DirectoryHeader(),
        body: Column(
          children: [DirectoryListBuilder()],
        ),
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

// ignore: must_be_immutable
class DirectoryScreen extends StatelessWidget {
  DirectoryScreen({super.key});

  Directory directory = Get.arguments["directory"];

  final MusicController musicController = Get.put(MusicController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: directoryScreenAppBar(),
      body: Column(
        children: [directoryScreenMusicList()],
      ),
    );
  }

  Flexible directoryScreenMusicList() {
    List<SongModel> music = musicController.music
        .where((item) => item.data.contains(directory.path))
        .toList();

    return Flexible(
        child: ListView.builder(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      itemCount: music.length,
      itemBuilder: (BuildContext context, int index) =>
          Music(song: music[index]),
    ));
  }

  AppBar directoryScreenAppBar() {
    return AppBar(
      backgroundColor: ColorConstants.headerBackgroundColor,
      foregroundColor: ColorConstants.textColor,
      titleSpacing: 5,
      title: Text(
        directory.name,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
