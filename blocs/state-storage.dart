import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesNames {
  static String user = 'user';
}

class StateStorage {
  static SharedPreferences prefs;

  static Future saveUser(String userJson) =>
      prefs.setString(PreferencesNames.user, userJson);

  static String loadUser() => prefs.getString(PreferencesNames.user);
}
