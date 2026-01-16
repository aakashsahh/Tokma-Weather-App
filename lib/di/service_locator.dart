import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokma_weather_app/bloc/help/bloc/help_bloc.dart';
import 'package:tokma_weather_app/bloc/weather/weather_bloc.dart';

import '../services/location_service.dart';
import '../services/storage_service.dart';
import '../services/weather_service.dart';

final sl = GetIt.instance;

/// Initialize all dependencies
Future<void> setupServiceLocator() async {
  // External Dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);
  sl.registerSingleton<http.Client>(http.Client());

  sl.registerLazySingleton<StorageService>(
    () => StorageService(sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<WeatherService>(
    () => WeatherService(sl<http.Client>()),
  );

  sl.registerLazySingleton<LocationService>(() => LocationService());

  // BLoCs - Factory to get a new instance each time
  sl.registerFactory<WeatherBloc>(
    () => WeatherBloc(
      weatherService: sl<WeatherService>(),
      locationService: sl<LocationService>(),
      storageService: sl<StorageService>(),
    ),
  );

  sl.registerFactory<HelpBloc>(
    () => HelpBloc(storageService: sl<StorageService>()),
  );
}

/// Clear all registered dependencies
void resetServiceLocator() {
  sl.reset();
}
