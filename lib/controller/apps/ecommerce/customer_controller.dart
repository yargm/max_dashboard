import 'package:get/get.dart';
import 'package:maxdash/controller/my_controller.dart';
import 'package:maxdash/model/customer.dart';

class CustomerController extends MyController {
  List<Customer> customers = [];

  @override
  void onInit() {
    super.onInit();
    Customer.dummyList.then((value) {
      customers = value;
      update();
    });
  }

  void goToDashboard() {
    Get.toNamed('/dashboard/ecommerce');
  }
}
