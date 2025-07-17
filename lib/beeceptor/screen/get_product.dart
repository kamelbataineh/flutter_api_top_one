import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../Class_info.dart';
import '../model/ProductModel.dart';
import 'add_product.dart';

class GetProduct extends StatefulWidget {
  const GetProduct({super.key});

  @override
  State<GetProduct> createState() => _GetProductState();
}

class _GetProductState extends State<GetProduct> {
  List<Productmodel>? products;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      setState(() {
        isLoading = true;
      });

      final dio = Dio();
      Response res = await dio.get('$baseUrl/kamel'); 
      print("Response data: ${res.data}");

      List productList = res.data;
      products = [];

      for (var item in productList) {
        Productmodel product = Productmodel.toMap(item);
        products!.add(product);
      }
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteProduct(Productmodel product) async {
    setState(() {
      isLoading = true;
    });

    try {
      final dio = Dio();
      await dio.delete('https://mp9b1d05df1bbc5801a6.free.beeceptor.com/api/kamel/${product.id}');
      await fetchProducts();
    } catch (e) {
      print("Error deleting product: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProduct(null)),
              ).then((value) {
                if (value == true) {
                  fetchProducts();
                }
              });
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : products == null || products!.isEmpty
          ? const Center(child: Text('No products found'))
          : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: products!.length,
        itemBuilder: (context, index) {
          final product = products![index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Text(
                      product.id.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.description.toString(),
                          style: const TextStyle(fontSize: 16),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Price: \$${product.price.toString()}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  // Added buttons for Edit and Delete side by side
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddProduct(product),
                        ),
                      ).then((value) {
                        if (value == true) {
                          fetchProducts();
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteProduct(product),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
