import 'package:crud_product/controller/add_product_controller.dart';
import 'package:crud_product/controller/product_screen_controller.dart';
import 'package:crud_product/data/repository/repository.dart';
import 'package:get/get.dart';

class AddProductBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AddProductController());
    Get.lazyPut(() => Repository());
    Get.lazyPut(() => ProductScreenController());
  }

}