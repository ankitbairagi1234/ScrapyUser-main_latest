import 'dart:convert';

import 'package:ez/Helper/session.dart';
import 'package:ez/screens/view/models/verifyOtpModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../block/login_bloc.dart';
import '../../../constant/global.dart';
import '../../../share_preference/preferencesKey.dart';
import '../models/LoginWithOtpModel.dart';
import 'newTabbar.dart';

class VerifyOtp extends StatefulWidget {
  String? otp, email;
   VerifyOtp({Key? key, this.otp, this.email}) : super(key: key);

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  var apiOtp;
  var inputOtp;
  ProgressDialog? pr;

  @override
  void initState() {
    apiOtp = widget.otp.toString();
    super.initState();
  }
  String? resendOtp;
  Future<LoginWithOtpModel?> loginWithOtp() async {
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/send_otp'));
    request.fields.addAll({
      'mobile': '${widget.email}',
      'device_token': ''
    });
    http.StreamedResponse response = await request.send();
    print(request);
    print(request.fields);
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      var results = LoginWithOtpModel.fromJson(json.decode(str));
      print("checking result here ${results.message} and ${results.otp}");

    setState(() {
      resendOtp = results.otp.toString();
      widget.otp = results.otp.toString();
    });

      // return LoginWithOtpModel.fromJson(json.decode(str));
    }
    else {
      print("checking fail response ${response.statusCode}");

    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColorWhite,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("${getTranslated(context, 'verification')}",style: TextStyle(color: backgroundblack),),
        leading: InkWell(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Container(
            child: Icon(Icons.arrow_back_ios,color: backgroundblack,),
          ),
        ),
      ),
      backgroundColor: appColorWhite,
      body: SafeArea(
        child:  ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 25),
          physics: ClampingScrollPhysics(),
          children: [
            Column(
              children: [
                // Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                //       child: CircleAvatar(
                //         backgroundColor: Colors.white,
                //         child: IconButton(
                //           onPressed: () {
                //             Navigator.pop(context);
                //           },
                //           icon: Icon(Icons.arrow_back_outlined),
                //           color: Colors.black,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),

                // CircleAvatar(
                //   backgroundColor: Colors.white,
                //   radius: 60,
                //   child: Image(
                //     image: AssetImage("assets/images/ez_logo.png"),
                //     fit: BoxFit.fill,
                //   ),
                // ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.02,
                // ),
                Text(
                  "${getTranslated(context, 'enterYour4DigitCode')}" + "\n ${resendOtp == null ? apiOtp : resendOtp}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  "${getTranslated(context, "don'tShareItWithAnyOther")}",
                  style: TextStyle(
                      color: Color(0xff767676),
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                SizedBox(
                  width: width * 0.8,
                  child: OTPTextField(
                    length: 4,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 60,
                    style: TextStyle(fontSize: 17),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.box,
                    onCompleted: (pin) {
                      setState(() {
                        inputOtp = pin;
                      });
                      print("Completed: " + pin);
                    },
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                // Text(
                //   "Enter 4 Digit OTP number Sent to your Email",
                //   style: TextStyle(
                //       color: Color(0xff767676),
                //       fontWeight: FontWeight.w500,
                //       fontSize: 14),
                // ),
                Text(
                  "${getTranslated(context, "didn'tReceived")}",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: (){
                    loginWithOtp();
                  },
                  child: Text(
                    "${getTranslated(context, 'resend')}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: backgroundblack,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: backgroundblack,
                    onPrimary: Colors.white,
                    shadowColor: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    minimumSize: Size(310, 50), //////// HERE
                  ),
                  onPressed: () {
                    print("checking both otp ${widget.otp} and ${inputOtp}");
                    if(widget.otp == inputOtp ) {
                      varifyOTP();
                    }
                    else{
                      Fluttertoast.showToast(msg: "Enter valid otp");
                    }
                  },
                  child: Text(
                    '${getTranslated(context, 'submit')}',
                    style: TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        )
        // Stack(
        //   children: [
        //     // CustomScrollView(
        //     //   scrollDirection: Axis.vertical,
        //     //   shrinkWrap: true,
        //     // ),
        //     /*Container(
        //       height: double.infinity,
        //       width: double.infinity,
        //       child: Column(
        //         children: [
        //           Container(
        //             height: height * 0.3,
        //             child: Image.asset(
        //               "assets/images/loginappbar.png",
        //               fit: BoxFit.fill,
        //             ),
        //           )
        //         ],
        //       ),
        //     ),*/
        //     ListView(
        //       shrinkWrap: true,
        //       physics: ClampingScrollPhysics(),
        //       children: [
        //         Column(
        //           children: [
        //             Row(
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
        //                   child: CircleAvatar(
        //                     backgroundColor: Colors.white,
        //                     child: IconButton(
        //                       onPressed: () {
        //                         Navigator.pop(context);
        //                       },
        //                       icon: Icon(Icons.arrow_back_outlined),
        //                       color: Colors.black,
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //
        //             CircleAvatar(
        //               backgroundColor: Colors.white,
        //               radius: 60,
        //               child: Image(
        //                 image: AssetImage("assets/images/ez_logo.png"),
        //                 fit: BoxFit.fill,
        //               ),
        //             ),
        //             SizedBox(
        //               height: MediaQuery.of(context).size.height * 0.02,
        //             ),
        //             Text(
        //               "ENTER YOUR 4 DIGIT CODE" + "\nOTP ${resendOtp == null ? apiOtp : resendOtp}",
        //               textAlign: TextAlign.center,
        //               style: TextStyle(
        //                   color: Colors.black,
        //                   fontWeight: FontWeight.w600,
        //                   fontSize: 20),
        //             ),
        //             SizedBox(
        //               height: height * 0.02,
        //             ),
        //             Text(
        //               "Don't share it with any other",
        //               style: TextStyle(
        //                   color: Color(0xff767676),
        //                   fontWeight: FontWeight.w500,
        //                   fontSize: 14),
        //             ),
        //             SizedBox(
        //               height: height * 0.04,
        //             ),
        //             SizedBox(
        //               width: width * 0.8,
        //               child: OTPTextField(
        //                 length: 4,
        //                 width: MediaQuery.of(context).size.width,
        //                 fieldWidth: 60,
        //                 style: TextStyle(fontSize: 17),
        //                 textFieldAlignment: MainAxisAlignment.spaceAround,
        //                 fieldStyle: FieldStyle.box,
        //                 onCompleted: (pin) {
        //                   setState(() {
        //                     inputOtp = pin;
        //                   });
        //                   print("Completed: " + pin);
        //                 },
        //               ),
        //             ),
        //             SizedBox(
        //               height: height * 0.01,
        //             ),
        //             Text(
        //               "Enter 4 Digit OTP number Sent to your Email",
        //               style: TextStyle(
        //                   color: Color(0xff767676),
        //                   fontWeight: FontWeight.w500,
        //                   fontSize: 14),
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   "Didn't Got Code? ",
        //                   style: TextStyle(
        //                       color: Colors.black,
        //                       fontWeight: FontWeight.w600,
        //                       fontSize: 14),
        //                 ),
        //                 TextButton(
        //                   onPressed: (){
        //                     loginWithOtp();
        //                   },
        //                   child: Text(
        //                     "Resend",
        //                     style: TextStyle(
        //                         color: Color(0xffF4B71E),
        //                         fontWeight: FontWeight.w600,
        //                         fontSize: 15),
        //                   ),
        //                 )
        //               ],
        //             ),
        //             SizedBox(
        //               height: height * 0.04,
        //             ),
        //             ElevatedButton(
        //               style: ElevatedButton.styleFrom(
        //                 primary: backgroundblack,
        //                 onPrimary: Colors.white,
        //                 shadowColor: Colors.white,
        //                 elevation: 3,
        //                 shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(8.0)),
        //                 minimumSize: Size(310, 50), //////// HERE
        //               ),
        //               onPressed: () => varifyOTP(),
        //               child: Text(
        //                 'Submit',
        //                 style: TextStyle(
        //                     fontWeight: FontWeight.w300, fontSize: 20),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ],
        //     )
        //   ],
        // ),
      ),
    );
  }

  Future varifyOTP() async {

    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/verify_otp'));
    request.fields.addAll({
      'mobile': '${widget.email}',
      'otp': '$inputOtp'
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      final jsonResponse = VerifyOtpModel.fromJson(json.decode(str));
      if(jsonResponse.responseCode == "1"){
        String userResponseStr = json.encode(jsonResponse);
        SharedPreferences preferences =
        await SharedPreferences.getInstance();
        preferences.setString(
            SharedPreferencesKey.LOGGED_IN_USERRDATA, userResponseStr);
        // Loader().hideIndicator(context);
        loginBloc.dispose();
        // pr!.hide();
        Fluttertoast.showToast(msg: "User Login Successfully");
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => TabbarScreen(),
          ),
              (Route<dynamic> route) => false,
        );
      }
      return VerifyOtpModel.fromJson(json.decode(str));
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
