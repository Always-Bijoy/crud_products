import 'dart:convert';

import 'package:crud_product/data/model/products_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPUtils {
  static const String keyAccessToken = "key_access_token";
  static const String keyUserId = "key_user_id";
  static const String keyProducts = "key_products";
  static const String keyOfflineProducts = "key_offline_products";

  // static Future<void> setAccessToken(String accessToken) async {
  //   await SharedPreferences.getInstance().then((prefs) {
  //     prefs.setString(keyAccessToken, accessToken);
  //   });
  // }

  static setValue(String key, String? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value!);
  }

  static setListValue(String key, List<ProductsModel> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(value.map((e) => e.toJson()).toList()));
  }

  //getListValue
  static Future<List<ProductsModel>?> getListValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final dataMap = jsonDecode(prefs.getString(key) ?? '[]') as List<dynamic>;

    return dataMap.map<ProductsModel>((item) {
      return ProductsModel.fromJson(item);
    }).toList();
  }

  static Future<String?> getValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var value = prefs.getString(key);
      return value;
    } catch (error) {
      return null;
    }
  }

  static deleteKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static Future<bool> clearCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(keyProducts);
  }

}
