import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weather_app/models/weather_model.dart';
import 'package:minimal_weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('3295c671681fa3f65bcf13935c7b5bf6');

  Weather? _weather;

  _fetchWeather() async {
    try {
      String cityName = await _weatherService.getCityName();

      print('cityName:$cityName');

      final weather = await _weatherService.getWeather(cityName);

      setState(() {
        _weather = weather;
        print('setState');
      });
    } catch (e) {
      print('error fethcing weather:$e');
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App'),backgroundColor: Colors.orange),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //city name
            Text(
              _weather?.cityName ?? "Loading City..",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.normal,
                color: Colors.black,
              ),
            ),

            //animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition), height: 150, width: 150),

            //temp in degrees
            Text(
              '${_weather?.temperature.round() ?? ''} °C',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                color: Colors.black,
              ),
            ),

            //weather condition
            Text(
              _weather?.mainCondition ?? 'loading',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
