import 'package:get/get.dart';
import 'package:maxdash/controller/my_controller.dart';

class Error500Controller extends MyController {
  void goToDashboardScreen() {
    Get.back();
  }
}
