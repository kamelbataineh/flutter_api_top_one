import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  String name;
  String email;
  String city;
  int id;

  UserDetails(
      {required this.id,
      required this.city,
      required this.email,
      required this.name});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Card(
        margin: EdgeInsets.all(20),
        child: ListTile(

          title: Row(
            children: [
              Text("Name : ${widget.name.toString()}"),
              Text("  Id : ${widget.id.toString()}"),
              Text("  city : ${widget.city.toString()}")
            ],
          ),
          subtitle: Text("Email : ${widget.email.toString()}"),
        ),
      ),
    );
  }
}
