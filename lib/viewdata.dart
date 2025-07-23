import 'package:flutter/material.dart';
import 'package:flutter_api_top_one/register/sign_up.dart';
import 'Product.dart';
import 'User.dart';
import 'User_Screen.dart';
import 'app_weather/Home_Weather.dart';
import 'beeceptor/screen/add_product.dart';
import 'beeceptor/screen/get_product.dart';

class Viewdata extends StatefulWidget {
  const Viewdata({super.key});

  @override
  State<Viewdata> createState() => _ViewdataState();
}

class _ViewdataState extends State<Viewdata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Product()),
                );
              },
              child: Text("GET Product"),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Users()),
                );
              },
              child: Text("GET Info User"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserScreen()),
                );
              },
              child: Text("GET Info User 2"),
            ),
          ),
          Row(
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GetProduct()),
                    );
                  },
                  child: Text("GetProduct_Productmodel"),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddProduct(null)),
                    );
                  },
                  child: Text("add product"),
                ),
              ),
            ],
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeWeather()),
                );
              },
              child: Text("View Weather"),
            ),
          ), Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              child: Text("registerUser + API"),
            ),
          ),
        ],
      ),
    );
  }
}
