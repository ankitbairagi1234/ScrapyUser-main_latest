import 'dart:convert';

import 'package:ez/constant/global.dart';
import 'package:ez/constant/sizeconfig.dart';
import 'package:ez/screens/view/models/changePass_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
// import 'package:toast/toast.dart';

class ChangePass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ChangePass> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  ChangePassModal? changePassModal;
  bool isLoading = false;

  final TextEditingController _passController = TextEditingController();
  final TextEditingController _npassController = TextEditingController();
  final TextEditingController _cpassController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  _apiCall() async {
    setState(() {
      isLoading = true;
    });
    var uri = Uri.parse('${baseUrl()}/change_password');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields['user_id'] = userID;
    request.fields['password'] = _passController.text;
    request.fields['npassword'] = _npassController.text;
    request.fields['cpassword'] = _cpassController.text;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    changePassModal = ChangePassModal.fromJson(userData);
    print(responseData);

    if (changePassModal!.responseCode == "1") {
      Fluttertoast.showToast(msg: changePassModal!.message!);
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: changePassModal!.message!);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: appColorWhite,
      body: Stack(
        children: [
          Scaffold(
              backgroundColor: appColorWhite,
              appBar: AppBar(
                backgroundColor: appColorWhite,
                elevation: 2,
                title: Text(
                  "Change Password",
                  style: TextStyle(
                      fontSize: 20,
                      color: appColorBlack,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: appColorBlack,
                    )),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(height: 50.0),
                      applogo(),
                      Container(height: 30.0),
                      _passTextfield(context),
                      Container(height: 10.0),
                      _npassTextfield(context),
                      Container(height: 10.0),
                      _cpassTextfield(context),
                      Container(height: 30.0),
                      _loginButton(context),
                    ],
                  ),
                ),
              )),
          isLoading == true
              ? Center(
                  child: loader(),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: InkWell(
        onTap: () async {
          if (_passController.text.isNotEmpty &&
              _npassController.text.isNotEmpty &&
              _cpassController.text.isNotEmpty) {
            if (_npassController.text == _cpassController.text) {
              _apiCall();
            } else {
              Fluttertoast.showToast(msg: "Password do not match");
            }
          } else {
            Fluttertoast.showToast(msg: "Password do not match");
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
                        appColorGreen,
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

  Widget applogo() {
    return Column(
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 70,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _passTextfield(BuildContext context) {
    return CustomtextField(
      controller: _passController,
      maxLines: 1,
      textInputAction: TextInputAction.next,
      hintText: 'Enter Old Password',
      prefixIcon:
          Container(margin: EdgeInsets.all(10.0), child: Icon(Icons.lock)),
    );
  }

  Widget _npassTextfield(BuildContext context) {
    return CustomtextField(
      controller: _npassController,
      maxLines: 1,
      textInputAction: TextInputAction.next,
      hintText: 'Enter New Password',
      prefixIcon:
          Container(margin: EdgeInsets.all(10.0), child: Icon(Icons.lock)),
    );
  }

  Widget _cpassTextfield(BuildContext context) {
    return CustomtextField(
      controller: _cpassController,
      maxLines: 1,
      textInputAction: TextInputAction.next,
      hintText: 'Enter Confirm Password',
      prefixIcon:
          Container(margin: EdgeInsets.all(10.0), child: Icon(Icons.lock)),
    );
  }
}
