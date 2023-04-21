import 'package:ez/screens/view/newUI/welcome.dart';
import 'package:flutter/material.dart';
import 'package:ez/screens/view/newUI/newTabbar.dart';
import 'package:ez/share_preference/preferencesKey.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constant/global.dart';

class AppScreen extends StatelessWidget {
  final SharedPreferences prefs;
  AppScreen(this.prefs);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _handleCurrentScreen(prefs),
    );
  }

  Widget _handleCurrentScreen(SharedPreferences prefs) {
    String? data = prefs.getString(SharedPreferencesKey.LOGGED_IN_USERRDATA);
    preferences = prefs;
    if (data == null) {
      return WelcomeScreen();
    } else {
      return TabbarScreen();

    }
  }
}
