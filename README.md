# Tokma Weather App

A simple Flutter weather application demonstrating clean architecture with BLoC pattern.

## Features

- 🌤️ Current weather display
- 📍 Location-based weather
- 💾 Remember last searched location
- ⏱️ Auto-skip help screen (5 seconds)
- 🎨 Material Design 3

## Setup

### 1. Prerequisites
- Flutter SDK 3.0+
- WeatherAPI key from https://www.weatherapi.com

### 2. Installation
```bash
git clone 
cd weather_app
flutter pub get
```

### 3. Configuration
Add your API key in `lib/constants.dart`:
```dart
static const String apiKey = 'YOUR_API_KEY';
```

### 4. Permissions

**Android** - Add to `AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
```

**iOS** - Add to `Info.plist`:
```xml
NSLocationWhenInUseUsageDescription
We need your location to show weather
```

### 5. Run
```bash
flutter run
```
## 🏗️ Architecture

This project follows **Clean Architecture** principles with a feature-based folder structure:

```
lib/
├── models/weather.dart           # Data models
├── services/         # Business logic layer
│   ├── weather_service.dart
│   ├── location_service.dart
│   └── storage_service.dart
├── bloc/             # State management
│   ├── weather_bloc.dart
│   └── help_bloc.dart
├── screens/          # UI screens
│   ├── help_screen.dart
│   └── home_screen.dart
├── widgets/          # Reusable components
│   ├── weather_display.dart
│   └── location_input.dart
├── theme/            # Material Theme configuration
│   └── app_theme.dart
├── extensions/       # Context extensions
│   └── context_extensions.dart
├── di/               # Dependency injection
│   └── service_locator.dart
├── constants.dart    # App constants
└── main.dart         # Entry point
```

## 📦 Dependencies

### Core Dependencies
- **flutter_bloc** (^8.1.3) - State management
- **get_it** (^7.6.4) - Dependency injection
- **equatable** (^2.0.5) - Value equality

### Features
- **http**  - HTTP client
- **geolocator**  - Location services
- **shared_preferences**  - Local storage
- **cached_network_image** - Image caching

## 🎨 Design System

The app uses **Material Design 3** with:
- Dynamic color schemes using `ColorScheme.fromSeed()`
- Light and dark theme support
- Consistent component styling
- Responsive layouts

## 🔧 Key Technologies

- **State Management**: BLoC Pattern
- **Dependency Injection**: GetIt
- **Navigation**: Flutter Navigator 2.0
- **Network**: HTTP package
- **Local Storage**: SharedPreferences
- **Location**: Geolocator
