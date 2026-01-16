import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokma_weather_app/models/weather.dart';
import 'package:tokma_weather_app/services/location_service.dart';
import 'package:tokma_weather_app/services/storage_service.dart';
import 'package:tokma_weather_app/services/weather_service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService weatherService;
  final LocationService locationService;
  final StorageService storageService;
  WeatherBloc({
    required this.weatherService,
    required this.locationService,
    required this.storageService,
  }) : super(WeatherInitial()) {
    on<LoadInitialWeather>(_onLoadInitialWeather);
    on<LoadWeatherByLocation>(_onLoadWeatherByLocation);
    on<LoadWeatherByCurrentLocation>(_onLoadWeatherByCurrentLocation);
  }
  Future<void> _onLoadInitialWeather(
    LoadInitialWeather event,
    Emitter<WeatherState> emit,
  ) async {
    final savedLocation = storageService.getSavedLocation();

    if (savedLocation != null && savedLocation.isNotEmpty) {
      add(LoadWeatherByLocation(savedLocation));
    } else {
      add(LoadWeatherByCurrentLocation());
    }
  }

  Future<void> _onLoadWeatherByLocation(
    LoadWeatherByLocation event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherService.getWeatherByLocation(event.location);
      await storageService.saveLocation(event.location);
      emit(WeatherLoaded(weather, event.location));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

  Future<void> _onLoadWeatherByCurrentLocation(
    LoadWeatherByCurrentLocation event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final position = await locationService.getCurrentLocation();
      final weather = await weatherService.getWeatherByCoordinates(
        position.latitude,
        position.longitude,
      );
      await storageService.clearLocation();
      emit(WeatherLoaded(weather, null));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
