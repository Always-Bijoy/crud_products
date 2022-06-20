import 'package:crud_product/data/api_provider/api_provider.dart';
import 'package:crud_product/data/dio_service/http_service.dart';
import 'package:crud_product/data/shared_pref/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpServiceImpl implements HttpService {
  late Dio _dio;

  @override
  Future<Response> getRequest(String url) async {
    Response response;
    try {
      response = await _dio.get(url);
      debugPrint(response.toString());
    } on DioError catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  @override
  Future<Response> postRequest(String url, data) async {
    Response response;
    try {
      response = await _dio.post(url, data: data);
      debugPrint(response.toString());
    } on DioError catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  @override
  void init() async {
    var accessToken = await SPUtils.getValue(SPUtils.keyAccessToken);
    _dio = Dio(BaseOptions(
      baseUrl: ApiProvider.baseUrl,
      headers: {
        "Authorization": "Bearer $accessToken",
        "Abp.TenantId": 10,
      },
    ));
  }
}
