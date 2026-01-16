part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class LoadInitialWeather extends WeatherEvent {}

class LoadWeatherByLocation extends WeatherEvent {
  final String location;
  const LoadWeatherByLocation(this.location);
  @override
  List<Object> get props => [location];
}

class LoadWeatherByCurrentLocation extends WeatherEvent {}
