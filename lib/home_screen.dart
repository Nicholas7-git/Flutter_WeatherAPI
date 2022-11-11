// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_application/location.dart';
import 'package:weather_application/weather.dart';
import 'package:weather_application/weather_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;

  WeatherService weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
    checkGps();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          debugPrint("Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getWeather();
      }
    } else {
      debugPrint("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  void getWeather() async {
    await weatherService.getWeatherData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WeatherScreen(weatherService: weatherService);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitRipple(
        color: Colors.white,
        size: 50,
      ),
    );
  }
}
