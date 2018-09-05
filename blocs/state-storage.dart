import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesNames {
  static String group(String id) => 'group-$id';
  static String user = 'user';
}

class StateStorage {
  static SharedPreferences prefs;

  static Future saveGroup(String groupId, String groupJson) =>
      prefs.setString(PreferencesNames.group(groupId), groupJson);
  static Future saveUser(String userJson) => prefs.setString(PreferencesNames.user, userJson);

  static String loadGroup(String groupId) => prefs.getString(PreferencesNames.group(groupId));
  static String loadUser() => prefs.getString(PreferencesNames.user);
}
