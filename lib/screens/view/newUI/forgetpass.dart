import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ez/constant/global.dart';
import 'package:ez/constant/sizeconfig.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:toast/toast.dart';

class ForgetPass extends StatefulWidget {
  @override
  _ForgetPassState createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final TextEditingController _emailController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: appColorWhite,
      body: Stack(
        children: [
          _loginForm(context),
          isLoading == true
              ? Center(
                  child: loader(),
                )
              : Container()
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                applogo(),
                Container(height: 50.0),
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Forgot Password",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'OpenSansBold',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Enter your email",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 30.0),
                _emailTextfield(context),
                Container(height: 10.0),
                Container(height: 20.0),
                _loginButton(context),
                Container(height: 40.0),
                _dontHaveAnAccount(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget applogo() {
    return Column(
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 50,
        ),
        SizedBox(
          height: 10,
        ),
        Text(appName,
            style: TextStyle(
                color: appColorBlack,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                fontStyle: FontStyle.italic)),
        SizedBox(
          height: 5,
        ),
        Text('Your Hygiene App',
            style: TextStyle(
              color: appColorBlack,
              fontSize: 12,
            )),
      ],
    );
  }

  Widget _emailTextfield(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: CustomtextField(
        controller: _emailController,
        maxLines: 1,
        labelText: "Email",
        hintText: "Enter Email",
        textInputAction: TextInputAction.next,
        prefixIcon: Icon(Icons.email),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: InkWell(
        onTap: () async {
          SystemChannels.textInput.invokeMethod('TextInput.hide');

          Pattern pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regex = new RegExp(pattern.toString());
          if (regex.hasMatch(_emailController.text)) {
            setState(() {
              isLoading = true;
            });
            try {
              final response = await client
                  .post(Uri.parse('${baseUrl()}/forgot_pass'), body: {
                "email": _emailController.text.trim(),
              });

              if (response.statusCode == 200) {
                Map<String, dynamic> dic = json.decode(response.body);
                if (dic['status'] == 1) {
                  Fluttertoast.showToast(msg: "New Password has been sent to your email");
                  Navigator.pop(context);
                } else {
                  Fluttertoast.showToast(msg: "Enter valid E-mail");
                }
                setState(() {
                  isLoading = false;
                });
              } else {
                setState(() {
                  isLoading = false;
                });
                Fluttertoast.showToast(msg: "Some error occurs");
              }
            } on Exception {
              setState(() {
                isLoading = false;
              });
              Fluttertoast.showToast(msg: "Email incorrect or No Internet connection");
              throw Exception('Email incorrect or No Internet connection');
            }
          } else {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "Enter valid E-mail");
          }
        },
        child: SizedBox(
            height: 60,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        backgroundblack,
                        backgroundgrey,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              height: 50.0,
              // ignore: deprecated_member_use
              child: Center(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "SUBMIT",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: appColorWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget _dontHaveAnAccount(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "BACK TO SIGN IN PAGE",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: appColorBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
