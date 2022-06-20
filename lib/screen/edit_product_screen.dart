import 'package:crud_product/controller/edit_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EditProductController controller = Get.put(EditProductController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                ),
              ),
              TextFormField(
                controller: controller.descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
              Obx(() {
                return CheckboxListTile(
                  title: const Text('Available'),
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: false,
                  contentPadding: const EdgeInsets.all(0),
                  value: controller.isAvailable.value,
                  onChanged: (value) {
                    controller.isAvailable.value =
                        !controller.isAvailable.value;
                  },
                );
              }),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: controller.editProduct,
                child: const Text('Submit'),
              ),
            ],
          ),
          if (controller.isLoading.value)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
