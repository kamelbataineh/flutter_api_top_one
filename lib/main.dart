import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_top_one/viewdata.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Viewdata(),
    );
  }

}