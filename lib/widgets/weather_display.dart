import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tokma_weather_app/extensions/context_extensions.dart';

import '../models/weather.dart';

class WeatherDisplay extends StatelessWidget {
  final Weather weather;

  const WeatherDisplay({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main Weather Card
        _buildMainWeatherCard(context),

        const SizedBox(height: 16),

        // Weather Details Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weather Details',
                style: context.textTheme.titleLarge?.copyWith(
                  color: context.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildWeatherDetailsGrid(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMainWeatherCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.colorScheme.primary.withValues(alpha: 0.2),
            context.colorScheme.primary.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Location
          Text(
            weather.locationName,
            style: context.textTheme.headlineMedium?.copyWith(
              color: context.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            weather.country,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onPrimary,
            ),
          ),

          const SizedBox(height: 24),

          // Temperature and Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Weather Icon
              CachedNetworkImage(
                imageUrl: 'https:${weather.conditionIcon}',
                width: 100,
                height: 100,
                placeholder: (context, url) => const SizedBox(
                  width: 100,
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  size: 100,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),

              const SizedBox(width: 16),

              // Temperature
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        weather.tempC.toStringAsFixed(0),
                        style: TextStyle(
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.onPrimary,
                          height: 1,
                        ),
                      ),
                      const Text(
                        '°C',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    weather.conditionText,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Last Updated
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.3,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Updated: ${weather.lastUpdated}',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetailsGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _buildDetailCard(
          context,
          icon: Icons.thermostat,
          title: 'Feels Like',
          value: '${weather.feelsLikeC.toStringAsFixed(1)}°C',
          subtitle: '${weather.feelsLikeF.toStringAsFixed(1)}°F',
        ),
        _buildDetailCard(
          context,
          icon: Icons.water_drop,
          title: 'Humidity',
          value: '${weather.humidity}%',
          subtitle: weather.humidity > 70 ? 'High' : 'Normal',
        ),
        _buildDetailCard(
          context,
          icon: Icons.air,
          title: 'Wind Speed',
          value: '${weather.windKph.toStringAsFixed(1)} km/h',
          subtitle: weather.windDir,
        ),
        _buildDetailCard(
          context,
          icon: Icons.visibility,
          title: 'Visibility',
          value: '${weather.visKm.toStringAsFixed(1)} km',
          subtitle: _getVisibilityText(weather.visKm),
        ),
        _buildDetailCard(
          context,
          icon: Icons.compress,
          title: 'Pressure',
          value: '${weather.pressureMb.toStringAsFixed(0)} mb',
          subtitle: _getPressureText(weather.pressureMb),
        ),
        _buildDetailCard(
          context,
          icon: Icons.wb_sunny,
          title: 'UV Index',
          value: weather.uv.toStringAsFixed(1),
          subtitle: _getUVText(weather.uv),
        ),
        _buildDetailCard(
          context,
          icon: Icons.cloud,
          title: 'Cloud Cover',
          value: '${weather.cloud}%',
          subtitle: _getCloudText(weather.cloud),
        ),
        _buildDetailCard(
          context,
          icon: Icons.storm,
          title: 'Wind Gust',
          value: '${weather.gustKph.toStringAsFixed(1)} km/h',
          subtitle: 'Max speed',
        ),
      ],
    );
  }

  Widget _buildDetailCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.colorScheme.secondary.withValues(alpha: 0.25),
            context.colorScheme.primary.withValues(alpha: 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colorScheme.outlineVariant, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onPrimary.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: context.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onPrimary.withValues(alpha: 0.5),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  String _getVisibilityText(double visKm) {
    if (visKm >= 10) return 'Excellent';
    if (visKm >= 5) return 'Good';
    if (visKm >= 2) return 'Moderate';
    if (visKm >= 1) return 'Poor';
    return 'Very Poor';
  }

  String _getPressureText(double pressureMb) {
    if (pressureMb > 1020) return 'High';
    if (pressureMb < 1000) return 'Low';
    return 'Normal';
  }

  String _getUVText(double uv) {
    if (uv >= 11) return 'Extreme';
    if (uv >= 8) return 'Very High';
    if (uv >= 6) return 'High';
    if (uv >= 3) return 'Moderate';
    return 'Low';
  }

  String _getCloudText(int cloud) {
    if (cloud >= 75) return 'Overcast';
    if (cloud >= 50) return 'Cloudy';
    if (cloud >= 25) return 'Partly Cloudy';
    return 'Clear';
  }
}
