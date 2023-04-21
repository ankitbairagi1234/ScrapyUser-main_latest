import 'package:ez/constant/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:ez/models/login_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ez/screens/view/newUI/newTabbar.dart';
import 'package:ez/share_preference/preferencesKey.dart';

final FacebookLogin facebookSignIn = new FacebookLogin();

Future<String> loginWithFacebook(BuildContext context) async {
  print("working this function here");
  final FacebookLoginResult result = await facebookSignIn.logIn(permissions: [
    FacebookPermission.publicProfile,
    FacebookPermission.email
  ]);
    print("checking login status ${result.status}");
  switch (result.status) {
    case FacebookLoginStatus.success:
      final FacebookAccessToken? accessToken = result.accessToken;

      final graphResponse = await http.get(Uri.parse('https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${accessToken!.token}'));

      final profile = JSON.jsonDecode(graphResponse.body);

      if (accessToken.token != null) {
        print(profile);
        print("Name:" + profile['name'].toString());
        print("FBID:" + accessToken.userId.toString());
        print("Image:" + profile['picture']['data']['url'].toString());

        userDataPost(
            context,
            profile['name'].toString(),
            accessToken.userId.toString(),
            profile['picture']['data']['url'].toString());
      }

      break;
    case FacebookLoginStatus.cancel:
      Flushbar(
        title: "cancelled",
        message: "Login cancelled",
        duration: Duration(seconds: 3),
        icon: Icon(
          Icons.error,
          color: Colors.red,
        ),
      )..show(context);
      // _showMessage('Login cancelled by the user.');
      break;
    case FacebookLoginStatus.error:
      Flushbar(
        title: "Something went wrong",
        message: 'Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.error}',
        duration: Duration(seconds: 3),
        icon: Icon(
          Icons.error,
          color: Colors.red,
        ),
      )..show(context);
      // _showMessage('Something went wrong with the login process.\n'
      //     'Here\'s the error Facebook gave us: ${result.errorMessage}');
      break;
  }
  return 'signInWithGoogle succeeded: $result';
}

userDataPost(
    BuildContext context, String name, String token, String image) async {
  LoginModel socialModel;

  var uri = Uri.parse('${baseUrl()}/social_login');
  var request = new http.MultipartRequest("Post", uri);
  Map<String, String> headers = {
    "Accept": "application/json",
  };
  request.headers.addAll(headers);
  request.fields.addAll({
    'username': name,
    'email': "",
    'type': 'facebook',
    'facebook_id': token,
    'image_url': image,
    //"device_token": token
  });
  var response = await request.send();
  print(response.statusCode);
  String responseData = await response.stream.transform(utf8.decoder).join();
  var userData = json.decode(responseData);
  socialModel = LoginModel.fromJson(userData);

  if (socialModel.responseCode == "1") {
    String userResponseStr = json.encode(userData);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(
        SharedPreferencesKey.LOGGED_IN_USERRDATA, userResponseStr);
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => TabbarScreen(),
      ),
      (Route<dynamic> route) => false,
    );
  } else {
    Flushbar(
      title: "Failure",
      message: "Facebook login fail!",
      duration: Duration(seconds: 3),
      icon: Icon(
        Icons.error,
        color: Colors.red,
      ),
    )..show(context);
  }
  print(responseData);
}

void signOutFacebook() async {
  print("FBSIGNOUT");
  await facebookSignIn.logOut();
}
