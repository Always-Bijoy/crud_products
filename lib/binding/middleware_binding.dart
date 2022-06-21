import 'package:crud_product/controller/add_product_controller.dart';
import 'package:crud_product/controller/middleware_controller.dart';
import 'package:crud_product/screen/middleware_screen.dart';
import 'package:get/get.dart';

import '../data/repository/repository.dart';

class MiddlewareBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>Repository());
    Get.lazyPut<MiddlewareController>(() => MiddlewareController(), fenix: true);
    // Get.lazyPut(() => AddProductController());
  }

}