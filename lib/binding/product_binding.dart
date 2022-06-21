import 'package:crud_product/screen/add_product_screen.dart';
import 'package:crud_product/screen/product_screen.dart';
import 'package:get/get.dart';

import '../data/repository/repository.dart';

class ProductBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => Repository());
    Get.lazyPut<ProductScreen>(() => const ProductScreen());
    // Get.lazyPut(() => const AddProductScreen());
    Get.put(const AddProductScreen());
  }
}