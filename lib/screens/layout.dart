import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musiku/components/floating_music.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/screens/home.dart';
import 'package:musiku/screens/search.dart';
import 'package:musiku/screens/collection.dart';
import 'package:musiku/screens/directory.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    // Home screen
    HomeScreen(),
    // Search screen
    const SearchScreen(),
    // collection screen
    const CollectionScreen(),
    // Directory screen
    const DirectoriesScreen()
  ];

  void onTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [_screens[_selectedIndex], FloatingMusic()],
      ),
      backgroundColor: ColorConstants.backgroundColor,
      bottomNavigationBar: bottomNavbar(),
    );
  }

  BottomNavigationBar bottomNavbar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: ColorConstants.modalBackgroundColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _selectedIndex,
      onTap: onTapped,
      items: [
        BottomNavigationBarItem(
          activeIcon: SvgPicture.asset("assets/icons/solid-home.svg",
              width: 26, height: 26),
          icon:
              SvgPicture.asset("assets/icons/home.svg", width: 26, height: 26),
          label: "Home",
        ),
        BottomNavigationBarItem(
            activeIcon: SvgPicture.asset("assets/icons/solid-search.svg",
                width: 26, height: 26),
            icon: SvgPicture.asset("assets/icons/search.svg",
                width: 26, height: 26),
            label: "Search"),
        BottomNavigationBarItem(
            activeIcon: SvgPicture.asset("assets/icons/solid-media-library.svg",
                width: 26, height: 26),
            icon: SvgPicture.asset("assets/icons/media-library.svg",
                width: 26, height: 26),
            label: "Collection"),
        BottomNavigationBarItem(
            activeIcon: SvgPicture.asset("assets/icons/solid-folder.svg",
                width: 26, height: 26),
            icon: SvgPicture.asset("assets/icons/folder.svg",
                width: 26, height: 26),
            label: "Directory")
      ],
    );
  }
}
