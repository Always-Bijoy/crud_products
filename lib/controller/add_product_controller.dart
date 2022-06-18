import 'package:crud_product/controller/product_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../data/repository/repository.dart';

class AddProductController extends GetxController {
  final repository = Get.put(Repository());
  final productScreenController = Get.find<ProductScreenController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isAvailable = false;
  RxBool isLoading = false.obs;

  void addProduct() async{
    final data = {
      "tenantId": 10,
      "name": nameController.text,
      "description": descriptionController.text,
      "isAvailable": isAvailable
    };

    final response = await repository.postAddProduct(data);
    isLoading.value = true;
    if (response != null) {
      Fluttertoast.showToast(msg: 'Product Added');
      await productScreenController.getProduct();
      isLoading.value = false;
      Get.back();
    }
    isLoading.value = false;
  }
}
