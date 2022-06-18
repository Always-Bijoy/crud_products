import 'package:crud_product/data/api_provider/api_provider.dart';
import 'package:crud_product/data/model/products_model.dart';
import 'package:crud_product/data/repository/repository.dart';
import 'package:get/get.dart';

import '../data/shared_pref/shared_preferences.dart';

class ProductScreenController extends GetxController {
  final repository = Get.put(Repository());
  RxList<ProductsModel> products = <ProductsModel>[].obs;
  RxBool isLoading = false.obs;
  ProductScreenController() {
    getProduct();
  }

  Future getProduct() async {
    products.clear();
    var accessToken = await SPUtils.getValue(SPUtils.keyAccessToken);
    print(accessToken);
    isLoading.value = true;
    final productsModel =
        await repository.getProductRequest();
    if (productsModel != null) {
      products.addAll(productsModel.obs);
    }
    isLoading.value = false;
  }
}
