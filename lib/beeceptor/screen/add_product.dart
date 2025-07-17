import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/ProductModel.dart';

class AddProduct extends StatefulWidget {
  final Productmodel? productmodel;

  const AddProduct(this.productmodel, {super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  bool isPost = false;
  bool isEdit = false;

  @override
  void initState() {
    super.initState();

    if (widget.productmodel != null) {
      isEdit = true;
      nameController.text = widget.productmodel!.name ?? '';
      priceController.text = widget.productmodel!.price.toString();
      descriptionController.text = widget.productmodel!.description ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Product' : 'Add Product'),
      ),
      body: isPost
          ? const Center(child: LinearProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: addProduct,
                child: Text(isEdit ? 'Update Product' : 'Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addProduct() async {
    Dio dio = Dio();

    Map<String, dynamic> data = {
      "name": nameController.text.trim(),
      "description": descriptionController.text.trim(),
      "price": double.tryParse(priceController.text.trim()) ?? 0,
    };

    setState(() {
      isPost = true;
    });

    try {
      Response res;

      if (isEdit) {
        res = await dio.put(
          'https://mp9b1d05df1bbc5801a6.free.beeceptor.com/api/kamel/${widget.productmodel!.id}',
          data: data,
        );
      } else {
        res = await dio.post(
          'https://mp9b1d05df1bbc5801a6.free.beeceptor.com/api/kamel',
          data: data,
        );
      }

      print(res.data);
    } catch (e) {
      print("Error during request: $e");
    }

    setState(() {
      isPost = false;
    });

    Navigator.of(context).pop(true);

    // Clear the fields
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
  }
}
