import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:tokma_weather_app/constants/constants.dart';

import '../models/weather.dart';

class WeatherService {
  final http.Client client;

  WeatherService(this.client);

  Future<Weather> getWeatherByLocation(String location) async {
    final url =
        '${AppConstants.apiBaseUrl}/current.json'
        '?key=${AppConstants.apiKey}&q=$location';

    final response = await client.get(Uri.parse(url));

    debugPrint('Weather API Response: ${response.body}');

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      throw Exception('Location not found');
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<Weather> getWeatherByCoordinates(double lat, double lon) async {
    final url =
        '${AppConstants.apiBaseUrl}/current.json'
        '?key=${AppConstants.apiKey}&q=$lat,$lon';

    final response = await client.get(Uri.parse(url));

    debugPrint('Weather API cordinates: ${response.body}');

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
