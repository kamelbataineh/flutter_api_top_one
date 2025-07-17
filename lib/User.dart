import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

List? user;

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}



class _UsersState extends State<Users> {
  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body:user != null? ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: user!.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> singleUser = user![index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // مسافة حول الكرت
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
                        singleUser['id'].toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text1(
                            '${singleUser['name']['firstname']} ${singleUser['name']['lastname']}',
                            size: 16,
                          ),

                          SizedBox(height: 4),
                          Text1(
                            singleUser['email'].toString(),
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
//
          },
        ):Center(child: CircularProgressIndicator()));
  }

  void getdata() async {
    final dio = Dio();
    final res = await dio.get('https://fakestoreapi.com/users');
    setState(() {
      user = res.data;
    });
  }



  Widget Text1(String txt, {double size = 5}) {
    return Text(
      txt,
      style: TextStyle(fontSize: size),
    );
  }

}

