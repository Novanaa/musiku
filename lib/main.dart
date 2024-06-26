import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/screens/layout.dart';
import 'package:flutter/services.dart';
import 'package:musiku/utils/events.dart';

void main() {
  Get.put(SortMusicController());
  Get.put(MusicController());
  Get.put(DirectoryController());
  Get.put(CurrentMusicPlayedController());
  Get.put(RepeatModeController());
  Get.put(PlaylistController());
  Get.put(FavoritesMusicController());

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MainApp()));
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  onApplicationInit().then((value) => FlutterNativeSplash.remove());
  onApplicationTerminated();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Layout(),
      theme: ThemeData(
          splashColor: Colors.transparent,
          fontFamily: "Poppins",
          scaffoldBackgroundColor: ColorConstants.backgroundColor,
          textTheme: Theme.of(context).textTheme.apply(
              fontFamily: "Poppins",
              displayColor: ColorConstants.textColor,
              bodyColor: ColorConstants.textColor)),
    );
  }
}
