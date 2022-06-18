import 'package:crud_product/controller/middleware_controller.dart';
import 'package:crud_product/screen/login_screen.dart';
import 'package:crud_product/screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MiddlewareScreen extends StatelessWidget {
  const MiddlewareScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MiddlewareController>(
        init: MiddlewareController(),
        builder: (controller) {
          return controller.accessToken != null
              ? const ProductScreen()
              : LoginScreen();
        },
      ),
    );
  }
}
