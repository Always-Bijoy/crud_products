import 'package:crud_product/data/model/products_model.dart';
import 'package:crud_product/data/repository/repository.dart';
import 'package:get/get.dart';

import '../data/shared_pref/shared_preferences.dart';

class ProductScreenController extends GetxController {
  final repository = Get.put(Repository());
  RxList<ProductsModel> products = <ProductsModel>[].obs;
  List<ProductsModel>? productsModel = [];
  // RxList<ProductsModel> productsSP = <ProductsModel>[].obs;
  var productsSP;
  RxBool isLoading = false.obs;

  ProductScreenController() {
    getProduct();
  }

  Future getProduct() async {
    products.clear();
    // var accessToken = await SPUtils.getValue(SPUtils.keyAccessToken);
    // await SPUtils.deleteKey(SPUtils.keyProducts);
    isLoading.value = true;
    productsModel = await repository.getProductRequest();
    if (productsModel != null) {
      /// delete list from old value
      await SPUtils.deleteKey(SPUtils.keyProducts);
      products.addAll(productsModel!);

      ///set new product in SP
      SPUtils.setListValue(SPUtils.keyProducts, products);
    }
    isLoading.value = false;

    /// get SP values
    // productsSP = await SPUtils.getListValue(SPUtils.keyProducts);
    getSPDataList();
  }

  getSPDataList() async {
    productsSP = await SPUtils.getListValue(SPUtils.keyProducts);
  }
}
