import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crud_product/controller/add_product_controller.dart';
import 'package:crud_product/data/model/products_model.dart';
import 'package:crud_product/data/repository/repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../data/shared_pref/shared_preferences.dart';

class ProductScreenController extends GetxController {
  final Repository repository = Get.find();
  RxList<ProductsModel> products = <ProductsModel>[].obs;
  // AddProductController addProductController = Get.put(AddProductController());
  // AddProductController addProductController = Get.find();
  List<ProductsModel>? productsModel = [];
  List<ProductsModel>? productsSP = [];
  RxBool isLoading = false.obs;
  ConnectivityResult? _connectivityResult;

  ProductScreenController() {
    getProduct();
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

  Future getProduct() async {
    products.clear();
    // var accessToken = await SPUtils.getValue(SPUtils.keyAccessToken);
    // await SPUtils.deleteKey(SPUtils.keyProducts);
    isLoading.value = true;
    // productsModel = await repository.getProductRequest();

    try{
      productsSP = await getSPDataList();
      if(productsSP != null) {
        products.addAll(productsSP!);
      }
    }catch(e){
      return e.toString();
    }finally{
      products.clear();
      productsModel = await repository.getProductRequest();
      if(productsModel != null) {

        ///get offline products
        ///store to server
        final localData = await SPUtils.getListValue(SPUtils.keyOfflineProducts);
        if(localData != null){
          if(localData.isNotEmpty){
            localData.map((product) async {
              await repository.postAddProduct(product.toRawJson());

                Future.delayed(const Duration(milliseconds: 200));

            }).toList();
          }
        }
        products.clear();
        productsModel = await repository.getProductRequest();

        ///clear local cache data
        final isCleared = await SPUtils.clearCache();
        if(isCleared){
          print('cache cleared');
        }
        products.addAll(productsModel!);
        ///set new product in SP
        SPUtils.setListValue(SPUtils.keyProducts, products);
        SPUtils.deleteKey(SPUtils.keyOfflineProducts);
      }
    }
    // if (productsModel != null) {
    //   /// delete list from old value
    //   // await SPUtils.deleteKey(SPUtils.keyProducts);
    //   products.addAll(productsModel!);
    //
    //   // if (addProductController.products.isNotEmpty) {
    //   //   List<ProductsModel> listMarge = [
    //   //     ...addProductController.products,
    //   //     ...productsSP!
    //   //   ];
    //   //   SPUtils.setListValue(SPUtils.keyProducts, listMarge);
    //   // }
    //
    //   ///set new product in SP
    //   SPUtils.setListValue(SPUtils.keyProducts, products);
    // }
    isLoading.value = false;

    /// get SP values
    // productsSP = await SPUtils.getListValue(SPUtils.keyProducts);
    // getSPDataList();
  }

  Future<List<ProductsModel>?> getSPDataList() async {
    return await SPUtils.getListValue(SPUtils.keyProducts);
  }

  void offlineProductSend(ProductsModel offlineProduct) async {
    final data = {
      "tenantId": 10,
      "name": offlineProduct.name,
      "description": offlineProduct.description,
      "isAvailable": offlineProduct.isAvailable,
    };

    bool isNetworkConnected = await checkInternetConnection();
    if (isNetworkConnected) {
      final response = await repository.postAddProduct(data);
      isLoading.value = true;
      if (response != null) {
        Fluttertoast.showToast(msg: 'Product Uploaded');
        await getProduct();
        isLoading.value = false;
      }
      isLoading.value = false;
    } else {
      Fluttertoast.showToast(msg: 'No Internet Connection');
    }
  }
}
