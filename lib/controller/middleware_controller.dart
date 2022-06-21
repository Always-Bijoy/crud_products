import 'package:crud_product/controller/add_product_controller.dart';
import 'package:crud_product/data/repository/repository.dart';
import 'package:get/get.dart';

import '../data/shared_pref/shared_preferences.dart';

class MiddlewareController extends GetxController{
  // AddProductController addProductController = Get.put(AddProductController());
  // final repository = Get.put(Repository());
  // late Repository repository ;
  // late AddProductController addProductController;
  var accessToken;


  MiddlewareController(){
    // repository = Get.put(Repository());
    // addProductController = Get.put(AddProductController());
    getAccessToken();
  }

  void getAccessToken() async{
    accessToken = await SPUtils.getValue(SPUtils.keyAccessToken);
    update();
  }
}