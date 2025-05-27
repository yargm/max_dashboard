import 'package:get/get.dart';
import 'package:maxdash/controller/my_controller.dart';
import 'package:maxdash/model/product_model.dart';

class ProductController extends MyController {
  List<Product> product = [];

  @override
  void onInit() {
    Product.dummyList.then((value) {
      product = value;
      update();
    });
    super.onInit();
  }

  void createProduct() {
    Get.toNamed('/app/ecommerce/add_product');
  }
}
