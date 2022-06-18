import 'package:get/get.dart';

import '../data/shared_pref/shared_preferences.dart';

class MiddlewareController extends GetxController{
  var accessToken;


  MiddlewareController(){
    getAccessToken();
  }

  void getAccessToken() async{
    accessToken = await SPUtils.getValue(SPUtils.keyAccessToken);
    update();
  }
}