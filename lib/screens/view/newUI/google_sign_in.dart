import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant/global.dart';
import '../../../models/login_modal.dart';
import '../../../share_preference/preferencesKey.dart';
import 'newTabbar.dart';
import 'package:http/http.dart' as http;

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String? name;
String? email;
String? imageUrl;
String? userId;
String data = "";

Future<String> signInWithGoogle(BuildContext context) async {
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  // final FirebaseUser user = await FirebaseAuth.instance.signInWithGoogle(
  //   accessToken: googleAuth.accessToken,
  //   idToken: googleAuth.idToken,
  // );

  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final User? user = authResult.user;

  // Checking if email and name is null
  assert(user!.email != null);
  assert(user!.displayName != null);
  assert(user!.photoURL != null);

  if(user != null){
    name = user.displayName;
    email = user.email;
    imageUrl = user.photoURL;
    userId = user.uid;
  }

  print(name);
  print(email);
  print(imageUrl);

  // Only taking the first part of the name, i.e., First Name
  // if (name.contains(" ")) {
  //   name = name.substring(0, name.indexOf(" "));
  // }

  assert(!user!.isAnonymous);
  assert(await user!.getIdToken() != null);

  final User currentUser = _auth.currentUser!;
  assert(user!.uid == currentUser.uid);

  if (user!.uid != null) {
    // FirebaseMessaging().getToken().then((token) {
    //   print("👌👌👌👌👌👌👌👌👌👌👌👌👌👌");

    //   _userDataPost(context);
    // });
    _userDataPost(context);
  }

  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Sign Out");
}

_userDataPost(BuildContext context) async {
  FirebaseMessaging.instance.getToken().then((token) async {
    LoginModel socialModel;

    var uri = Uri.parse('${baseUrl()}/social_login');
    var request = new http.MultipartRequest("Post", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields.addAll({
      'username': name.toString(),
      'email': email.toString(),
      'type': 'google',
      'facebook_id': userId.toString(),
      'image_url': imageUrl.toString(),
      "device_token": token.toString()
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
        message: "Google login fail!",
        duration: Duration(seconds: 3),
        icon: Icon(
          Icons.error,
          color: Colors.red,
        ),
      )..show(context);
    }
    print(responseData);
  });
}
