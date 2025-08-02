import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_top_one/Api/config.dart';
import 'package:flutter_api_top_one/Api/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ////////////////////////////////////
  ///
  ///////////////////////////////////

  bool isPasswordVisible = false;
  bool isEmptyVar = false;

  ////////////////////////////////////
  ///
  ///////////////////////////////////

  late SharedPreferences sharedPreferences;

  ////////////////////////////////////
  ///
  ///////////////////////////////////
  void initPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPreferences();
  }

  LoginUserFun() async {
    print("LoginUserFun started");
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var reqOfBody = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      try {
        var response = await http.post(
          Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqOfBody),
        );

        print("Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");

        if (response.statusCode == 200) {
          var jsonRes = jsonDecode(response.body);

          if (jsonRes['status'] == true) {
            var myToken = jsonRes['token'];
            await sharedPreferences.setString('token', myToken);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(token: myToken),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('خطأ في البيانات')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('فشل الاتصال بالسيرفر')),
          );
        }
      } catch (e) {
        print("Exception: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ غير متوقع')),
        );
      }
    } else {
      setState(() {
        isEmptyVar = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock, size: 80, color: Colors.deepPurple),
                SizedBox(height: 16),
                Text(
                  "تسجيل الدخول",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 32),

                // Email
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                    errorText: isEmptyVar ? "This field cannot by empty" : null,
                  ),
                ),
                SizedBox(height: 16),

                // Password
                TextField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    errorText: isEmptyVar ? "This field cannot by empty" : null,
                    labelText: 'كلمة المرور',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 24),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: LoginUserFun,

                      // TODO: إرسال البيانات للسيرفر
                      // final email = emailController.text;
                      // final password = passwordController.text;
                      // print("Email: $email");
                      // print("Password: $password");

                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child:  Text(
                      "تسجيل الدخول",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
