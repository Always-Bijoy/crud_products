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
  RxBool isConnected = false.obs;

  ProductScreenController() {
    checkInternet();
    getProduct();
  }

  checkInternet() async {
    isConnected = await checkInternetConnection();
  }

  // check internet connection
  Future<RxBool> checkInternetConnection() async {
    try {
      _connectivityResult = await Connectivity().checkConnectivity();
      if (_connectivityResult == ConnectivityResult.none) {
        return Future<RxBool>.value(false.obs);
      }
    } catch (e) {
      return Future<RxBool>.value(false.obs);
    }
    return Future<RxBool>.value(true.obs);
  }

  Future getProduct() async {
    await checkInternet();
    if (!isConnected.value) Fluttertoast.showToast(msg: 'You are offline');
    products.clear();
    isLoading.value = true;
    try {
      productsSP = await getSPDataList();
      if (productsSP != null) {
        products.addAll(productsSP!);
      }
    } catch (e) {
      return e.toString();
    } finally {
      products.clear();
      productsModel = await repository.getProductRequest();
      if (productsModel != null) {
        ///get offline products
        ///store to server
        final localData =
            await SPUtils.getListValue(SPUtils.keyOfflineProducts);
        if (localData != null) {
          if (localData.isNotEmpty) {

            for(ProductsModel product in localData){
              await repository.postAddProduct(product.toRawJson());
              Future.delayed(const Duration(milliseconds: 200));
            }
            //
            // localData.map((product) async {
            //   await repository.postAddProduct(product.toRawJson());
            //
            //   Future.delayed(const Duration(milliseconds: 200));
            // }).toList();
          }
        }
        // products.clear();
        productsModel = await repository.getProductRequest();

        products.addAll(productsModel!);

        ///set new product in SP
        SPUtils.setListValue(SPUtils.keyProducts, products);

        /// after set new products in SP
        /// need to fetch again
        productsSP = await getSPDataList();

        /// delete offline product
        SPUtils.deleteKey(SPUtils.keyOfflineProducts);
      }
    }
    isLoading.value = false;
  }

  Future<List<ProductsModel>?> getSPDataList() async {
    return await SPUtils.getListValue(SPUtils.keyProducts);
  }

// void offlineProductSend(ProductsModel offlineProduct) async {
//   final data = {
//     "tenantId": 10,
//     "name": offlineProduct.name,
//     "description": offlineProduct.description,
//     "isAvailable": offlineProduct.isAvailable,
//   };
//
//   bool isNetworkConnected = await checkInternetConnection();
//   if (isNetworkConnected) {
//     final response = await repository.postAddProduct(data);
//     isLoading.value = true;
//     if (response != null) {
//       Fluttertoast.showToast(msg: 'Product Uploaded');
//       await getProduct();
//       isLoading.value = false;
//     }
//     isLoading.value = false;
//   } else {
//     Fluttertoast.showToast(msg: 'No Internet Connection');
//   }
// }
}
