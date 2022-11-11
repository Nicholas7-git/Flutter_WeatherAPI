import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_application/location.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  late double temperature;
  late String weatherIcon;
  late String cityName;

  // static const API_KEY = '13b0330de82df5042a1be3de54a9bf98';
  // Example API KEY
  static const API_KEY = '0f8c88146a435b8db9d6af1cacbbc02a';

  Future<dynamic> getWeatherData() async {
    LocationService locationService = LocationService();
    await locationService.getCurrentLocation();

    double lat = locationService.latitude;
    double lon = locationService.longitude;

    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$API_KEY'));

    if (response.statusCode == 200) {
      String data = response.body;
      var weatherData = jsonDecode(data);

      temperature = weatherData['main']['temp'];
      weatherIcon = weatherData['weather'][0]['icon'];
      cityName = weatherData['name'];
    } else {
      debugPrint(response.statusCode.toString());
    }
  }
}
