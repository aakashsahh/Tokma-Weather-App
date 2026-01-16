import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String locationName;
  final double tempC;
  final String conditionText;
  final String conditionIcon;
  final String lastUpdated;

  const Weather({
    required this.locationName,
    required this.tempC,
    required this.conditionText,
    required this.conditionIcon,
    required this.lastUpdated,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      locationName: json['location']['name'],
      tempC: json['current']['temp_c'].toDouble(),
      conditionText: json['current']['condition']['text'],
      conditionIcon: json['current']['condition']['icon'],
      lastUpdated: json['current']['last_updated'],
    );
  }

  @override
  List<Object?> get props => [
    locationName,
    tempC,
    conditionText,
    conditionIcon,
    lastUpdated,
  ];
}
