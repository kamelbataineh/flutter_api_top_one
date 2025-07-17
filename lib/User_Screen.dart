
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'Class_info.dart';
import 'User_details.dart';

List<User>? userList;

class UserScreen extends StatefulWidget {

  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    geteUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: userList == null || userList!.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(

              itemCount: userList!.length,
              itemBuilder: (context, index) {
                User user = userList![index];

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: InkWell(
                    onTap:() {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>UserDetails(id: user.id, city: user.city, email: user.email, name: user.username)
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            child: Text(
                              user.id.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "UserName : ${user.username.toString()}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ), Text(
                                  "City : ${user.city.toString()}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Email : ${user.email.toString()}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void geteUsers() async {
    Dio dio = Dio();
    Response res = await dio.get('https://fakestoreapi.com/users');

    List resListOFUser = res.data;
    userList = [];
    for (int i = 0; i < resListOFUser.length; i++) {
      Map<String, dynamic> userMap = resListOFUser[i];
      User user = User.toMap(userMap);
     setState(() {

      userList!.add(user);
     });
    }
  }
}
