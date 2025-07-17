import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'Class_Weather.dart';
import 'package:geolocator/geolocator.dart';
class HomeWeather extends StatefulWidget {
  const HomeWeather({super.key});

  @override
  State<HomeWeather> createState() => _HomeWeatherState();
}

class _HomeWeatherState extends State<HomeWeather> {
  //////////////////////////////
  //////////////////////////////
  //////////////////////////////

  ClassWeather? classWeather;
  double lat = 13.5555;
  double lon = 33.4433;

  //////////////////////////////
  //////////////////////////////
  //////////////////////////////

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: classWeather == null
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF154c79),
                      Color(0xFF154c33),
                      Color(0xFF154c46),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "City Name : ${classWeather!.cityName}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Image.network(
                        "https://openweathermap.org/img/wn/${classWeather!.icon}@2x.png",
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Description : ${classWeather!.description}",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Temp : ${classWeather!.temp}°C",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void getWeather() async {

    Position ?position =await _determinePosition(context);
    if(position==null){
      return ;
    }
    lat=position.latitude;
    lon=position.longitude;
    Dio dio = Dio();
    Response response = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather',
      queryParameters: {
        "lat": lat,
        "lon": lon,
        "appid": "a4c38309b51e5a05e6d4cc4f90f5ee6a",
        "units": "metric",
      },
    );
    print(response.data.toString());

    Map<String, dynamic> mapData = response.data;
    setState(() {
      classWeather = ClassWeather.fromMap(mapData);
    });
  }


  Future<Position> _determinePosition(BuildContext context) async {
    try {
      // التحقق إذا كانت خدمة الموقع مفعّلة
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("خدمة تحديد الموقع غير مفعّلة")),
        );
        return Future.error('Location services are disabled.');
      }

      // التحقق من صلاحيات الوصول للموقع
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("تم رفض صلاحية الوصول للموقع")),
          );
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("تم رفض الصلاحية بشكل دائم. الرجاء التفعيل من الإعدادات.")),
        );
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // كل الشروط متوفرة - الحصول على الموقع
      Position position = await Geolocator.getCurrentPosition();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تم الحصول على الموقع بنجاح")),
      );
      return position;

    } catch (e) {
      // في حالة أي خطأ غير متوقع
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("حدث خطأ أثناء تحديد الموقع: $e")),
      );
      return Future.error(e);
    }
  }


}
