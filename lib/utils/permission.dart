import 'package:get/route_manager.dart';
import 'package:musiku/screens/welcome.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> checkPermission() async {
  bool isGranted = await Permission.storage.isGranted;

  if (!isGranted) Get.to(const WelcomeScreen());
}
