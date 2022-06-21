import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crud_product/controller/product_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../data/model/products_model.dart';
import '../data/repository/repository.dart';
import '../data/shared_pref/shared_preferences.dart';

class AddProductController extends GetxController {
  Repository repository = Get.find();
  ProductScreenController productScreenController = Get.find();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  RxBool isAvailable = false.obs;
  RxBool isLoading = false.obs;
  ConnectivityResult? _connectivityResult;
  RxList<ProductsModel> products = <ProductsModel>[].obs;

  ProductsModel? offlineProduct;

  AddProductController() {
    offlineProduct = Get.arguments;
  }

  // check internet connection
  Future<bool> checkInternetConnection() async {
    try {
      _connectivityResult = await Connectivity().checkConnectivity();
      if (_connectivityResult == ConnectivityResult.none) {
        return Future<bool>.value(false);
      }
    } catch (e) {
      return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }

  void addProduct() async {
    final data = {
      "tenantId": 10,
      "name": nameController.text,
      "description": descriptionController.text,
      "isAvailable": isAvailable.value
    };
    bool isConnected = await checkInternetConnection();
    if (isConnected) {
      final response = await repository.postAddProduct(data);
      print('response type: ${response.runtimeType}');
      isLoading.value = true;
      if (response != null) {
        Fluttertoast.showToast(msg: 'Product Added');
        // await productScreenController.getProduct();
        isLoading.value = false;
        Get.back();
      }
      isLoading.value = false;
    } else {
      products.add(ProductsModel(
          tenantId: 10,
          name: nameController.text,
          description: descriptionController.text,
          isAvailable: isAvailable.value,
          isDownloaded: true));

      SPUtils.setListValue(SPUtils.keyOfflineProducts, products);

      Fluttertoast.showToast(msg: 'No Internet Connection');
      var productsSP = await SPUtils.getListValue(SPUtils.keyProducts);

      /// marge new product with old SP product
      var listMarge = [...products, ...productsSP!];
      SPUtils.setListValue(SPUtils.keyProducts, listMarge);

      /// refresh product list in product screen
      productScreenController.getSPDataList();
    }
  }
}
