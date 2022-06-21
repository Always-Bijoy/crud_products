import 'package:crud_product/binding/add_product_binding.dart';
import 'package:crud_product/binding/middleware_binding.dart';
import 'package:crud_product/binding/product_binding.dart';
import 'package:crud_product/binding/root_binding.dart';
import 'package:crud_product/screen/add_product_screen.dart';
import 'package:crud_product/screen/middleware_screen.dart';
import 'package:crud_product/screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      initialBinding: RootBinding(),
      getPages: [
        GetPage(
            name: '/',
            page: () => const MiddlewareScreen(),
            binding: MiddlewareBinding()),
        GetPage(
            name: '/productScreen',
            page: () => const ProductScreen(),
            binding: ProductBinding()),
        GetPage(
            name: '/addProduct',
            page: () => const AddProductScreen(),
            binding: AddProductBinding())
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
