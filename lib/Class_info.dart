class User{
  int id;
  String email;
  String username;
  String city;


  User(this.id,this.email,this.username,this.city);

  factory User.toMap(Map<String, dynamic> map) {
    String city = map['address']['city'];

    return User(
      map['id'],
      map['email'],
      map['username'],
      city,
    );
  }

}

const String baseUrl = 'https://mp9b1d05df1bbc5801a6.free.beeceptor.com/api';