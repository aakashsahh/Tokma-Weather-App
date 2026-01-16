import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String locationName;
  final String region;
  final String country;
  final double tempC;
  final double tempF;
  final String conditionText;
  final String conditionIcon;
  final String lastUpdated;
  final int isDay;

  // Additional weather details
  final double feelsLikeC;
  final double feelsLikeF;
  final int humidity;
  final double windKph;
  final double windMph;
  final String windDir;
  final double visKm;
  final double visMiles;
  final double pressureMb;
  final int cloud;
  final double uv;
  final double gustKph;

  const Weather({
    required this.locationName,
    required this.region,
    required this.country,
    required this.tempC,
    required this.tempF,
    required this.conditionText,
    required this.conditionIcon,
    required this.lastUpdated,
    required this.isDay,
    required this.feelsLikeC,
    required this.feelsLikeF,
    required this.humidity,
    required this.windKph,
    required this.windMph,
    required this.windDir,
    required this.visKm,
    required this.visMiles,
    required this.pressureMb,
    required this.cloud,
    required this.uv,
    required this.gustKph,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      locationName: json['location']['name'] as String,
      region: json['location']['region'] as String,
      country: json['location']['country'] as String,
      tempC: (json['current']['temp_c'] as num).toDouble(),
      tempF: (json['current']['temp_f'] as num).toDouble(),
      conditionText: json['current']['condition']['text'] as String,
      conditionIcon: json['current']['condition']['icon'] as String,
      lastUpdated: json['current']['last_updated'] as String,
      isDay: json['current']['is_day'] as int,
      feelsLikeC: (json['current']['feelslike_c'] as num).toDouble(),
      feelsLikeF: (json['current']['feelslike_f'] as num).toDouble(),
      humidity: json['current']['humidity'] as int,
      windKph: (json['current']['wind_kph'] as num).toDouble(),
      windMph: (json['current']['wind_mph'] as num).toDouble(),
      windDir: json['current']['wind_dir'] as String,
      visKm: (json['current']['vis_km'] as num).toDouble(),
      visMiles: (json['current']['vis_miles'] as num).toDouble(),
      pressureMb: (json['current']['pressure_mb'] as num).toDouble(),
      cloud: json['current']['cloud'] as int,
      uv: (json['current']['uv'] as num).toDouble(),
      gustKph: (json['current']['gust_kph'] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => [
    locationName,
    region,
    country,
    tempC,
    tempF,
    conditionText,
    conditionIcon,
    lastUpdated,
    isDay,
    feelsLikeC,
    feelsLikeF,
    humidity,
    windKph,
    windMph,
    windDir,
    visKm,
    visMiles,
    pressureMb,
    cloud,
    uv,
    gustKph,
  ];
}
