import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


class HomeScreen extends StatefulWidget {
  var token;

   HomeScreen({super.key,required this.token});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

 late String email;
 
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
 Map<String,dynamic> jsonDecodeData= JwtDecoder.decode(widget.token);
 email=jsonDecodeData['email'];
 }
 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Center(
  child: Text("Email Token ${email}"),
),
    );
  }
}
