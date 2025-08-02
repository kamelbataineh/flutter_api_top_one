import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isEmptyToCheck = false;

  // final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Create Account'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              // TextField(
              //   controller: _nameController,
              //   decoration: const InputDecoration(
              //     labelText: 'Full Name',
              //     border: OutlineInputBorder(),
              //     prefixIcon: Icon(Icons.person),
              //   ),
              // ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                  errorText: isEmptyToCheck ? "not valid" : null,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  errorText: isEmptyToCheck ? "not valid" : null,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  register();
                  // print('Signed up: ${_nameController.text}, ${_emailController.text}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Sign Up', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      //post
      var bodyOFregister = {
        "email": _emailController.text,
        "password": _passwordController.text,
      };
      //Postman ==> Headers ==> Content-Type || application/json
      var response = await http.post(
        Uri.parse(registration),
          headers: {
            "Content-Type": "application/json",
          },
        body: jsonEncode(bodyOFregister),);
      var jsonResponse=jsonDecode(response.body);
      print(jsonResponse['status']);
    } else {
      isEmptyToCheck = !isEmptyToCheck;
    }
  }
}
