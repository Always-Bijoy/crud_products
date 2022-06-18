import 'package:crud_product/controller/product_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../data/model/products_model.dart';
import '../data/repository/repository.dart';

class EditProductController extends GetxController{
  final repository = Get.put(Repository());
  final productScreenController = Get.find<ProductScreenController>();
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  RxBool isAvailable = false.obs;
  RxBool isLoading = false.obs;
  late int id;

  late ProductsModel product;


  EditProductController(){
    product = Get.arguments;
    nameController = TextEditingController(text: product.name);
    descriptionController = TextEditingController(text: product.description);
    id = product.id!;
    isAvailable.value = product.isAvailable!;
  }

  void editProduct() async{
    final data = {
      "tenantId": 10,
      "name": nameController.text,
      "description": descriptionController.text,
      "isAvailable": isAvailable,
      "id": id
    };

    final response = await repository.postAddProduct(data);
    isLoading.value = true;
    if (response != null) {
      Fluttertoast.showToast(msg: 'Product Edited SuccessFully');
      await productScreenController.getProduct();
      isLoading.value = false;
      Get.back();
    }
    isLoading.value = false;
  }
}