import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

List? products;

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: products != null
            ? ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: products!.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> singleProduct = products![index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        singleProduct['id'].toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text1(
                            singleProduct['title'].toString(),
                            size: 16,
                          ),
                          SizedBox(height: 4),
                          Text1(
                            'السعر: \$${singleProduct['price'].toString()}',
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
            : Center(child: CircularProgressIndicator()));
  }

  void getdata() async {
    final dio = Dio();
    final res = await dio.get('https://fakestoreapi.com/products');
    setState(() {
      products = res.data;
    });
  }

  Widget Text1(String txt, {double size = 5}) {
    return Text(
      txt,
      style: TextStyle(fontSize: size),
      maxLines: 2,
      overflow: TextOverflow.fade,
    );
  }
}