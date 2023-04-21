import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'demo_localization.dart';


class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString('languageCode', languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString('languageCode') ?? "en";
  return _locale(languageCode);
}

Locale _locale(String languageCode){
  switch (languageCode) {
    case "en":
      return Locale("en", 'US');
    case "hi":
      return Locale("hi", "IN");
    default:
      return Locale("en", 'US');
  }
}

String getTranslated(BuildContext context, String key) {
  print('final value is here 1 ${key}');
  return DemoLocalization.of(context)!.translate(key);
}

// String getToken() {
//   final claimSet = new JwtClaim(
//       issuer: 'eshop',
//       maxAge: const Duration(minutes: 5),
//       issuedAt: DateTime.now().toUtc());
//
//   String token = issueJwtHS256(claimSet, jwtKey);
//   print("token : $token ");
//
//   return token;
// }

// Map<String, String> get headers => {
//   "Authorization": 'Bearer ' + getToken(),
// };

dialogAnimate(BuildContext context, Widget dialge) {
  return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(opacity: a1.value, child: dialge),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      // pageBuilder: null
      pageBuilder: (context, animation1, animation2) {
        return Container();
      } //as Widget Function(BuildContext, Animation<double>, Animation<double>)
  );
}
