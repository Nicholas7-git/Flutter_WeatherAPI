import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  late double latitude;
  late double longitude;

  Future<dynamic> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;

      debugPrint("Latitude : $latitude");
      debugPrint("Longitude : $longitude");
    } catch (e) {
      inspect(e);
    }
  }
}
