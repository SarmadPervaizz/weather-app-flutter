import 'package:flutter/material.dart';
import 'package:minimal_weather_app/pages/weather_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      // darkTheme: ThemeData.dark(),
      home: WeatherPage(),
    );
  }
}
