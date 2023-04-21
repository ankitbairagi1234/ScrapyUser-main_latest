import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ez/screens/view/newUI/forgetpass.dart';
import 'package:ez/screens/view/newUI/newTabbar.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:html/dom.dart' as dom;

//const Color backgroundblack = Color(0xFFEB6C67);
//const Color backgroundblack = Color(0xFF05c3dd);
const Color backgroundblack = Color(0xFF00FFFF);
// Color(0xFF0151A3);
const Color backgroundgrey = Color(0xFFf4f7f8);
const Color splashColor = Color(0xFFEB6C67);
const Color appColorGreen = Color(0xFF3A3C3C);
const Color appColorOrange = Color(0xFF536F16);
const Color appColorBlack = Colors.black;
const Color appGreen = Color(0XFF1ea36d);

String stripSecret = '';
String stripPublic = '';

String rozSecret = '';
String rozPublic = 'rzp_test_rcbv2RXtgmOyTf';

const Color appColorWhite = Colors.white;
SharedPreferences? preferences;
String userID = '';
String userEmail = '';
String userName = '';
String userMobile = '';
String userCity = '';
String userPic = '';
String wallet = '';
var likedProduct = [];
var likedService = [];
var destinationList = [];

String appName = 'SCRAPY';

Client client = Client();

closeKeyboard() {
  return SystemChannels.textInput.invokeMethod('TextInput.hide');
}
String baseUrl() {
  //return 'https://developmentalphawizz.com/antsnest/api';
  //return 'https://developmentalphawizz.com/kabadi/api';
  return "https://developmentalphawizz.com/Kabadi/api";
}
String imageUrl() {
  return "https://developmentalphawizz.com/Kabadi/uploads/";
}
String? imageUrl1(){
  return "https://developmentalphawizz.com/Kabadi//uploads/scrap_image/";
}

void forgoterrorDialog(BuildContext context, String message, {bool? button}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(height: 10.0),
            Text(message, textAlign: TextAlign.center),
            Container(height: 30.0),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width - 100,
              // ignore: must_be_immutable
              child: TextButton(
                onPressed: button == null
                    ? () => Navigator.pop(context)
                    : () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => ForgetPass(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

// ignore: must_be_immutable
class CustomtextField extends StatefulWidget {
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplate;
  final Function(String)? onSubmitted;
  final dynamic controller;
  final int? maxLines;
  final int? maxLength;
  final dynamic onChange;
  final String? errorText;
  final String? hintText;
  final String? labelText;
  bool obscureText = false;
  bool readOnly = false;
  bool autoFocus = false;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  CustomtextField({
    this.keyboardType,
    this.onTap,
    this.focusNode,
    this.textInputAction,
    this.onEditingComplate,
    this.onSubmitted,
    this.controller,
    this.maxLines,
    this.onChange,
    this.errorText,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.readOnly = false,
    this.autoFocus = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
  });

  @override
  _CustomtextFieldState createState() => _CustomtextFieldState();
}

class _CustomtextFieldState extends State<CustomtextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      readOnly: widget.readOnly,
      textInputAction: widget.textInputAction,
      onTap: widget.onTap,
      autofocus: widget.autoFocus,
      maxLines: widget.maxLines,
      onEditingComplete: widget.onEditingComplate,
      onSubmitted: widget.onSubmitted,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      onChanged: widget.onChange,
      maxLength: widget.maxLength,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: appColorWhite,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
        counterText: "",
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        errorStyle: TextStyle(color: Colors.black),
        errorText: widget.errorText,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: widget.hintText,
        focusColor: Colors.black,
        labelStyle: TextStyle(color: Colors.black, fontSize: 14),
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SearchField extends StatefulWidget {
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplate;
  final Function(String)? onSubmitted;
  final dynamic controller;
  final int? maxLines;
  final dynamic onChange;
  final String? errorText;
  final String? hintText;
  final String? labelText;
  bool obscureText = false;
  bool readOnly = false;
  bool autoFocus = false;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  SearchField({
    this.keyboardType,
    this.onTap,
    this.focusNode,
    this.textInputAction,
    this.onEditingComplate,
    this.onSubmitted,
    this.controller,
    this.maxLines,
    this.onChange,
    this.errorText,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.readOnly = false,
    this.autoFocus = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      readOnly: widget.readOnly,
      textInputAction: widget.textInputAction,
      onTap: widget.onTap,
      autofocus: widget.autoFocus,
      maxLines: widget.maxLines,
      onEditingComplete: widget.onEditingComplate,
      onSubmitted: widget.onSubmitted,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      onChanged: widget.onChange,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        errorStyle: TextStyle(color: Colors.white),
        errorText: widget.errorText,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: widget.hintText,
        labelStyle:
            TextStyle(color: Color(0XFF106C6F), fontWeight: FontWeight.bold),
        hintStyle:
            TextStyle(color: Color(0XFF106C6F), fontWeight: FontWeight.bold),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0XFF106C6F), width: 1.8),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0XFF106C6F), width: 1.8),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

Html applyHtml(context, String html, {TextStyle? style}) {
  return Html(
    blockSpacing: 0,
    data: html,
    defaultTextStyle: style ??
        Theme.of(context).textTheme.bodyText1!.merge(TextStyle(fontSize: 14)),
    useRichText: false,
    customRender: (node, children) {
      if (node is dom.Element) {
        switch (node.localName) {
          case "br":
            return SizedBox(
              height: 0,
            );
          case "p":
            return Padding(
              padding: EdgeInsets.only(top: 0, bottom: 0),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.start,
                  children: children,
                ),
              ),
            );
        }
      }
      return null;
    },
  );
}

// ignore: must_be_immutable
class SearchFieldnormal extends StatefulWidget {
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplate;
  final Function(String)? onSubmitted;
  final dynamic controller;
  final int? maxLines;
  final dynamic onChange;
  final String? errorText;
  final String? hintText;
  final String? labelText;
  bool obscureText = false;
  bool readOnly = false;
  bool autoFocus = false;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  SearchFieldnormal({
    this.keyboardType,
    this.onTap,
    this.focusNode,
    this.textInputAction,
    this.onEditingComplate,
    this.onSubmitted,
    this.controller,
    this.maxLines,
    this.onChange,
    this.errorText,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.readOnly = false,
    this.autoFocus = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  _SearchFieldnormalState createState() => _SearchFieldnormalState();
}

class _SearchFieldnormalState extends State<SearchFieldnormal> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      readOnly: widget.readOnly,
      textInputAction: widget.textInputAction,
      onTap: widget.onTap,
      autofocus: widget.autoFocus,
      maxLines: widget.maxLines,
      onEditingComplete: widget.onEditingComplate,
      onSubmitted: widget.onSubmitted,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      onChanged: widget.onChange,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(14.0),
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 20,
        ),
        errorStyle: TextStyle(color: Colors.white),
        errorText: widget.errorText,
        hintText: widget.hintText,
        labelStyle:
            TextStyle(color: Color(0XFF106C6F), fontWeight: FontWeight.bold),
        hintStyle:
            TextStyle(color: Color(0XFF003F4F), fontWeight: FontWeight.bold),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0XFF106C6F), width: 1.8),
          borderRadius: BorderRadius.circular(14),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0XFF106C6F), width: 1.8),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}

class CustomButtom extends StatelessWidget {
  final Color? color;
  final String? title;
  final VoidCallback? onPressed;
  CustomButtom({
    this.color,
    this.title,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      // ignore: deprecated_member_use
      child: ElevatedButton(
        onPressed: onPressed,
        // shape:
        //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        // padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              color: appColorOrange, borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 400.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              title!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButtom1 extends StatelessWidget {
  final Color? color;
  final String? title;
  final VoidCallback? onPressed;
  CustomButtom1({
    this.color,
    this.title,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color,
          onPrimary: Colors.grey,
          onSurface: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(80)),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 400.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              title!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

void errorDialog(BuildContext context, String message, {bool? button}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(height: 10.0),
            Text(message, textAlign: TextAlign.center),
            Container(height: 30.0),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width - 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TabbarScreen()),
                  );
                  // Navigator.pop(context);
                },
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

void errorDialogForget(BuildContext context, String message, {bool? button}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(height: 10.0),
            Text(message, textAlign: TextAlign.center),
            Container(height: 30.0),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width - 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Navigator.pop(context);
                },
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

void loginerrorDialog(BuildContext context, String message, {bool? button}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(height: 10.0),
            Text(message, textAlign: TextAlign.center),
            Container(height: 30.0),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width - 100,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => TabbarScreen()),
                  // );
                  Navigator.pop(context);
                },
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

class Loader {
  void showIndicator(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Center(
            child: Material(
          type: MaterialType.transparency,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white.withOpacity(0.7),
              ),
              Center(child: CupertinoActivityIndicator())
            ],
          ),
        ));
      },
    );
  }

  void hideIndicator(BuildContext context) {
    Navigator.pop(context);
  }
}

dynamic safeQueries(BuildContext context) {
  return (MediaQuery.of(context).size.height >= 812.0 ||
      MediaQuery.of(context).size.height == 812.0 ||
      (MediaQuery.of(context).size.height >= 812.0 &&
          MediaQuery.of(context).size.height <= 896.0 &&
          Platform.isIOS));
}

// ignore: must_be_immutable
class ReviewtextField extends StatefulWidget {
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplate;
  final Function(String)? onSubmitted;
  final dynamic controller;
  final int? maxLines;
  final dynamic onChange;
  final String? errorText;
  final String? hintText;
  final String? labelText;
  bool obscureText = false;
  bool readOnly = false;
  bool autoFocus = false;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  ReviewtextField({
    this.keyboardType,
    this.onTap,
    this.focusNode,
    this.textInputAction,
    this.onEditingComplate,
    this.onSubmitted,
    this.controller,
    this.maxLines,
    this.onChange,
    this.errorText,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.readOnly = false,
    this.autoFocus = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  _ReviewtextFieldState createState() => _ReviewtextFieldState();
}

class _ReviewtextFieldState extends State<ReviewtextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      readOnly: widget.readOnly,
      textInputAction: widget.textInputAction,
      onTap: widget.onTap,
      autofocus: widget.autoFocus,
      maxLines: widget.maxLines,
      onEditingComplete: widget.onEditingComplate,
      onSubmitted: widget.onSubmitted,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      onChanged: widget.onChange,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        errorStyle: TextStyle(color: Colors.black),
        errorText: widget.errorText,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: widget.hintText,
        labelStyle: TextStyle(color: Color(0xFF106C6F)),
        hintStyle: TextStyle(color: Colors.black),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.8),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

LocationData? locationData;

Future<LocationData?> getCurrentLocation() async {
  print("getCurrentLocation");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('currentLat') && prefs.containsKey('currentLon')) {
    locationData = LocationData.fromMap({
      "latitude": prefs.getDouble('currentLat'),
      "longitude": prefs.getDouble('currentLon')
    });
  } else {
    setCurrentLocation().then((value) {
      if (prefs.containsKey('currentLat') && prefs.containsKey('currentLon')) {
        locationData = LocationData.fromMap({
          "latitude": prefs.getDouble('currentLat'),
          "longitude": prefs.getDouble('currentLon')
        });
      }
    });
  }
  return locationData;
}

Future<LocationData?> setCurrentLocation() async {
  var location = new Location();
  location.requestService().then((value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      locationData = await location.getLocation();
      await prefs.setDouble('currentLat', locationData!.latitude!);
      await prefs.setDouble('currentLon', locationData!.longitude!);
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
    }
  });
  return locationData;
}

// ignore: must_be_immutable
class CustomtextField2 extends StatefulWidget {
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplate;
  final Function(String)? onSubmitted;
  final dynamic controller;
  final int? maxLines;
  final dynamic onChange;
  final String? errorText;
  final String? hintText;
  final String? labelText;
  bool obscureText = false;
  bool readOnly = false;
  bool autoFocus = false;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  CustomtextField2({
    this.keyboardType,
    this.onTap,
    this.focusNode,
    this.textInputAction,
    this.onEditingComplate,
    this.onSubmitted,
    this.controller,
    this.maxLines,
    this.onChange,
    this.errorText,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.readOnly = false,
    this.autoFocus = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  _CustomtextField2State createState() => _CustomtextField2State();
}

class _CustomtextField2State extends State<CustomtextField2> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      readOnly: widget.readOnly,
      textInputAction: widget.textInputAction,
      onTap: widget.onTap,
      autofocus: widget.autoFocus,
      maxLines: widget.maxLines,
      onEditingComplete: widget.onEditingComplate,
      onSubmitted: widget.onSubmitted,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      onChanged: widget.onChange,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14.0, horizontal: 14),
        errorStyle: TextStyle(color: Colors.white),
        errorText: widget.errorText,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black45),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: widget.hintText,
        labelStyle: TextStyle(color: Colors.black45),
        hintStyle: TextStyle(color: Colors.black45),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54, width: 1.8),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54, width: 1.8),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

Widget loader() {
  return Container(
    height: 60,
    width: 60,
    padding: EdgeInsets.all(15.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Colors.transparent),
    child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
  );
}

void bookDialog(BuildContext context, String message, {bool? button}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(height: 10.0),
            Text(message, textAlign: TextAlign.center),
            Container(height: 30.0),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width - 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

Widget ingenieriaTextfield(
    {Widget? prefixIcon,
    Function(String)? onChanged,
    List<TextInputFormatter>? inputFormatters,
    String? hintText,
    VoidCallback? onTap,
    TextEditingController? controller,
    int? maxLines,
    TextInputType? keyboardType}) {
  return TextField(
    controller: controller,
    onTap: onTap,
    inputFormatters: inputFormatters,
    maxLines: maxLines,
    keyboardType: keyboardType,
    onChanged: onChanged,
    style: TextStyle(color: Colors.black, fontSize: 15),
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15),
      filled: true,
      contentPadding: EdgeInsets.only(top: 30.0, left: 10.0),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(0),
      ),
      fillColor: Colors.transparent,
    ),
  );
}

Widget load() {
  return Center(
    child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(appColorOrange)),
              )),
        )),
  );
}
