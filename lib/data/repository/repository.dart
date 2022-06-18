import 'package:crud_product/data/api_provider/api_provider.dart';
import 'package:crud_product/data/dio_service/http_service_impl.dart';
import 'package:crud_product/data/model/login_model.dart';
import 'package:crud_product/data/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Repository {
  late HttpServiceImpl _httpService;
  Repository() {
    _httpService = Get.put(HttpServiceImpl());
    _httpService.init();
  }

  Future<LoginModel?> postLogin(data) async {
    try {
      final response =
          await _httpService.postRequest(ApiProvider.loginUrl, data);
      debugPrint('Response from repo ${response.statusCode}, ${response.data}');
      final loginModel = LoginModel.fromJson(response.data);
      return loginModel;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<List<ProductsModel>?> getProductRequest() async {
    try {
      final response = await _httpService.getRequest(ApiProvider.productsUrl);
      debugPrint('Response from repo ${response.statusCode}, ${response.data}');
      final productsModel = (response.data as List)
          .map((e) => ProductsModel.fromJson(e))
          .toList();
      return productsModel;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future postAddProduct(data) async {
    try {
      final response = await _httpService.postRequest(ApiProvider.createProduct, data);
      debugPrint('Response from repo ${response.statusCode}, ${response.data}');
      return response.data;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
