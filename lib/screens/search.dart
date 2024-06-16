import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musiku/components/music.dart';
import 'package:musiku/components/placeholder.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/sections/search/search_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String keyword = "";

  final MusicController musicController = Get.put(MusicController());

  dynamic searchMusic() {
    List<SongModel> musicList = [];
    if (keyword.isNotEmpty) {
      musicList.addAll(musicController.music.where((value) =>
          value.displayName.toLowerCase().contains(keyword.toLowerCase()) ||
          value.data.toLowerCase().contains(keyword.toLowerCase())));
    }

    if (keyword.isEmpty) return const SearchWelcomeScreen();

    if (musicList.isEmpty) return const SearchNotFoundPlaceholder();

    return Flexible(
        child: ListView.builder(
      itemCount: musicList.length,
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      itemBuilder: (BuildContext context, int index) =>
          Music(song: musicList[index]),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchScreenAppBar(),
      body: Column(
        children: [searchMusic()],
      ),
    );
  }

  AppBar searchScreenAppBar() {
    return AppBar(
      backgroundColor: ColorConstants.backgroundColor,
      centerTitle: true,
      titleSpacing: -0,
      title: SearchScreenBar(
        onTextChanged: (String text) => setState(() => keyword = text),
      ),
    );
  }
}
