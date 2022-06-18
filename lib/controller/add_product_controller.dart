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
  RxBool isAvailable = false.obs;
  RxBool isLoading = false.obs;
  // Rx<SingingCharacter?> character = SingingCharacter.lafayette.obs;


  getValue(value){
    isAvailable.value = value;
    print(isAvailable.value);
    update();
  }

  void addProduct() async{
    final data = {
      "tenantId": 10,
      "name": nameController.text,
      "description": descriptionController.text,
      "isAvailable": isAvailable.value
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
enum SingingCharacter { lafayette, jefferson }