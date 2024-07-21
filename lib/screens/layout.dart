import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
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

  NavigationBarTheme bottomNavbar() {
    return NavigationBarTheme(
      data: const NavigationBarThemeData(
          labelTextStyle: WidgetStatePropertyAll(TextStyle(
        color: ColorConstants.textColor,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w500,
        fontSize: 12.5,
      ))),
      child: NavigationBar(
        indicatorColor: ColorConstants.iconColor,
        backgroundColor: ColorConstants.backgroundColor,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) =>
            setState(() => _selectedIndex = index),
        elevation: 0,
        height: 70,
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Iconsax.home_1_copy,
              color: ColorConstants.iconColor,
            ),
            label: "Home",
            selectedIcon: Icon(
              Iconsax.home,
              color: ColorConstants.backgroundColor,
            ),
          ),
          NavigationDestination(
            icon: Icon(
              Iconsax.search_normal_copy,
              color: ColorConstants.iconColor,
            ),
            label: "Search",
            selectedIcon: Icon(
              Iconsax.search_normal,
              color: ColorConstants.backgroundColor,
            ),
          ),
          NavigationDestination(
            icon: Icon(
              Iconsax.save_2_copy,
              color: ColorConstants.iconColor,
            ),
            label: "Collection",
            selectedIcon: Icon(
              Iconsax.save_2,
              color: ColorConstants.backgroundColor,
            ),
          ),
          NavigationDestination(
            icon: Icon(
              Iconsax.folder_2_copy,
              color: ColorConstants.iconColor,
            ),
            label: "Directory",
            selectedIcon: Icon(
              Iconsax.folder_2,
              color: ColorConstants.backgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
