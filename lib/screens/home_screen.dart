import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokma_weather_app/bloc/weather/weather_bloc.dart';

import '../extensions/context_extensions.dart';
import '../widgets/location_input.dart';
import '../widgets/weather_display.dart';
import 'help_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      appBar: AppBar(
        backgroundColor: context.colorScheme.primary,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud, color: context.colorScheme.onPrimary),
            const SizedBox(width: 12),
            Text(
              'Weather App',
              style: context.textTheme.headlineSmall?.copyWith(
                color: context.colorScheme.onPrimary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.help_outline,
              color: context.colorScheme.onPrimary,
            ),
            onPressed: () => context.push(const HelpScreen()),
            tooltip: 'Help',
          ),
        ],
      ),
      body: BlocConsumer<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherError) {
            context.showErrorSnackBar(state.message);
          }
        },
        builder: (context, state) {
          if (state is WeatherInitial) {
            context.read<WeatherBloc>().add(LoadInitialWeather());
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    'Loading weather...',
                    style: context.textTheme.bodyLarge,
                  ),
                ],
              ),
            );
          }

          if (state is WeatherLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: context.colorScheme.onPrimary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Fetching weather data...',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is WeatherError) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  LocationInput(
                    initialLocation: null,
                    onSubmit: (location) {
                      if (location.isEmpty) {
                        context.read<WeatherBloc>().add(
                          LoadWeatherByCurrentLocation(),
                        );
                      } else {
                        context.read<WeatherBloc>().add(
                          LoadWeatherByLocation(location),
                        );
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: context.colorScheme.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Oops! Something went wrong',
                          style: context.textTheme.titleLarge?.copyWith(
                            color: context.colorScheme.error,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.message,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is WeatherLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  LocationInput(
                    initialLocation: state.savedLocation,
                    onSubmit: (location) {
                      if (location.isEmpty) {
                        context.read<WeatherBloc>().add(
                          LoadWeatherByCurrentLocation(),
                        );
                      } else {
                        context.read<WeatherBloc>().add(
                          LoadWeatherByLocation(location),
                        );
                      }
                    },
                  ),
                  WeatherDisplay(weather: state.weather),
                  const SizedBox(height: 16),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
