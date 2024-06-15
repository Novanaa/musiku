import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:musiku/constants/color.dart';
import 'package:musiku/screens/layout.dart';
import 'package:flutter/services.dart';
import 'package:musiku/utils/app_init.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MainApp()));
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  applicationInit().then((value) => FlutterNativeSplash.remove());
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
