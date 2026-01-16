import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokma_weather_app/bloc/help/bloc/help_bloc.dart';
import 'package:tokma_weather_app/bloc/weather/weather_bloc.dart';

import 'screens/help_screen.dart';
import 'screens/home_screen.dart';
import 'services/location_service.dart';
import 'services/storage_service.dart';
import 'services/weather_service.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

Future<void> setupDependencies() async {
  // Services
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<StorageService>(StorageService(prefs));
  getIt.registerSingleton<WeatherService>(WeatherService(http.Client()));
  getIt.registerSingleton<LocationService>(LocationService());

  // Blocs
  getIt.registerFactory<WeatherBloc>(
    () => WeatherBloc(
      weatherService: getIt<WeatherService>(),
      locationService: getIt<LocationService>(),
      storageService: getIt<StorageService>(),
    ),
  );

  getIt.registerFactory<HelpBloc>(
    () => HelpBloc(storageService: getIt<StorageService>()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<HelpBloc>()..add(CheckHelpStatus())),
        BlocProvider(create: (_) => getIt<WeatherBloc>()),
      ],
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),
          cardTheme: CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        home: BlocBuilder<HelpBloc, HelpState>(
          builder: (context, state) {
            if (state is HelpChecking) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            return state is HelpSkipped
                ? const HomeScreen()
                : const HelpScreen();
          },
        ),
      ),
    );
  }
}
