import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokma_weather_app/constants/constants.dart';

class StorageService {
  final SharedPreferences prefs;

  StorageService(this.prefs);

  Future<bool> isHelpSkipped() async {
    return prefs.getBool(AppConstants.helpSkippedKey) ?? false;
  }

  Future<void> setHelpSkipped(bool value) async {
    await prefs.setBool(AppConstants.helpSkippedKey, value);
  }

  String? getSavedLocation() {
    return prefs.getString(AppConstants.savedLocationKey);
  }

  Future<void> saveLocation(String location) async {
    await prefs.setString(AppConstants.savedLocationKey, location);
  }

  Future<void> clearLocation() async {
    await prefs.remove(AppConstants.savedLocationKey);
  }
}
