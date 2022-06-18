import 'package:crud_product/controller/product_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put<ProductScreenController>(ProductScreenController());
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            controller.products.isNotEmpty
                ? ListView.builder(
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Product $index'),
                      );
                    })
                : const SizedBox(),
            if (controller.isLoading.value)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
