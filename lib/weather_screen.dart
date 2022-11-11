import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_application/weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key, required this.weatherService});

  final WeatherService weatherService;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double? temperature;
  String? weatherIcon;
  String? cityName;

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  void updateUI() {
    setState(() {
      temperature = widget.weatherService.temperature;
      weatherIcon = widget.weatherService.weatherIcon;
      cityName = widget.weatherService.cityName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Image(
                image: NetworkImage(
                    'http://openweathermap.org/img/wn/$weatherIcon@2x.png'),
              ),
              Text(
                '$cityName',
                style: GoogleFonts.redressed(fontSize: 40),
              ),
              Text(
                '$temperature Celcius',
                style: GoogleFonts.montserrat(fontSize: 40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
