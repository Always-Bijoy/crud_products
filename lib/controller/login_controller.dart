import 'package:crud_product/data/repository/repository.dart';
import 'package:crud_product/data/shared_pref/shared_preferences.dart';
import 'package:crud_product/screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final repository = Get.put(Repository());
  final TextEditingController usernameController =
      TextEditingController(text: 'asif');
  final TextEditingController passwordController =
      TextEditingController(text: 'password1');
  RxBool isLoading = false.obs;

  LoginController() {
    // login();
  }

  void login() async {
    isLoading.value = true;
    final data = {
      'userNameOrEmailAddress': usernameController.text,
      'password': passwordController.text,
    };

    final loginModel = await repository.postLogin(data);
    isLoading.value = false;
    if (loginModel != null) {
      SPUtils.setValue(SPUtils.keyAccessToken, loginModel.result?.accessToken);
      Get.offAll(const ProductScreen());
    }
  }
}
