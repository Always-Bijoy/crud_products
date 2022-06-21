import 'package:crud_product/binding/middleware_binding.dart';
import 'package:crud_product/controller/add_product_controller.dart';
import 'package:get/get.dart';

import '../controller/product_screen_controller.dart';

class RootBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MiddlewareBinding());
    Get.lazyPut(() => ProductScreenController(), fenix: true);
    // Get.lazyPut(() => AddProductController(), fenix: true);
  }

}