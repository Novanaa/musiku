import 'package:get/get.dart';
import 'package:musiku/controller.dart';
import 'package:musiku/utils/permission.dart';

Future<void> applicationInit() async {
  final MusicController musicController = Get.put(MusicController());
  bool isPermissionGranted = await checkPermission();

  if (isPermissionGranted) {
    musicController.getMusic();
  }
}
