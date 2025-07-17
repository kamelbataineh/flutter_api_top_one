class ClassWeather {
  String? cityName;
  String? description;
  String? icon;
  double? temp;

  ClassWeather(
      this.cityName,
      this.description,
      this.icon,
      this.temp,
      );

  factory ClassWeather.fromMap(Map<String, dynamic> map) {
    List weatherList = map['weather'];

    return ClassWeather(
      map['name'],
      weatherList[0]['description'],
      weatherList[0]['icon'],
      map['main']['temp'].toDouble(),
    );
  }
}
