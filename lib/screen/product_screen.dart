import 'package:crud_product/controller/product_screen_controller.dart';
import 'package:crud_product/screen/add_product_screen.dart';
import 'package:crud_product/screen/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put<ProductScreenController>(ProductScreenController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => Get.to(const AddProductScreen())),
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Obx(
        () => Stack(
          children: [
            controller.productsSP != null
                ? ListView.builder(
                    itemCount: controller.productsSP.length,
                    itemBuilder: (context, index) {
                      final data = controller.productsSP[index];
                      return ListTile(
                        onTap: () {
                          data.isDownloaded != true
                              ? Get.to(const EditProductScreen(),
                                  arguments: data)
                              : Get.to(const AddProductScreen(),
                                  arguments: data);
                        },
                        leading: data.isAvailable == true
                            ? const Icon(Icons.check_circle_sharp)
                            : const Icon(Icons.radio_button_unchecked_sharp),
                        title: Text(data.name ?? ''),
                        subtitle: Text(data.description ?? ''),
                        trailing: data.isDownloaded
                            ? IconButton(
                                icon: const Icon(Icons.upload),
                                onPressed: () => Get.to(
                                    const EditProductScreen(),
                                    arguments: data),
                              )
                            : const SizedBox(),
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
