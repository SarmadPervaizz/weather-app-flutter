import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:minimal_weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';

  final String apikey;

  WeatherService(this.apikey);

  Future<Weather> getWeather(String cityName) async {
    final String url = '$BASE_URL?q=$cityName&appid=$apikey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print('response.statusCode == 200');
      final decJson = jsonDecode(response.body);
      print('decJson:$decJson');
      return Weather.fromJson(decJson);
    } else {
      print('response.statusCode != 200');
      throw Exception('Failed to load weather data!');
    }
  }

  Future<String> getCityName() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placeMarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    String? city = placeMarks[0].locality;

    return city ?? "";
  }
}
