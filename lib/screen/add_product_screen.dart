import 'package:crud_product/controller/add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddProductController controller = Get.put(AddProductController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
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
                onPressed: controller.addProduct,
                child: const Text('Add'),
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
