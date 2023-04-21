import 'package:ez/screens/view/newUI/fb_sign_in.dart';
import 'package:ez/screens/view/newUI/google_sign_in.dart';
import 'package:ez/screens/view/newUI/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez/constant/global.dart';

class Welcome2 extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<Welcome2> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appColorWhite,
        body:   Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 35),
                height:150,
                alignment: Alignment.bottomCenter,
                //child: Text("SCRAPY",style: TextStyle(color: Colors.black,fontFamily: 'Serif',fontWeight: FontWeight.bold,fontSize: 22),),
                child: Image.asset(
                  'assets/images/scrapyLogo1.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 220,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/welcome2.png',
                  fit: BoxFit.fill,
                ),
              ),
              // Text(appName,
              //     style: TextStyle(
              //         color: appColorBlack,
              //         fontSize: 25,
              //         fontWeight: FontWeight.bold,
              //         fontFamily: 'OpenSans',
              //         fontStyle: FontStyle.italic)),
              SizedBox(
                height: 60,
              ),
              normalButton(),
              //   SizedBox(height: 15,),
              // googleButton(),
              // SizedBox(height: 15,),
              //  fbButton(),

              // Container(
              //   height: 4,
              //   width: 150,
              //   decoration: BoxDecoration(
              //       color: Colors.grey,
              //       borderRadius: BorderRadius.all(Radius.circular(30))),
              // ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        // Stack(
        //   children: [
        //
        //     isLoading == true
        //         ? Center(
        //             child: loader(),
        //           )
        //         : Container()
        //   ],
        // )
    );
  }

  Widget normalButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        },
        child: SizedBox(
            height: 60,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                  color: appColorWhite,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              height: 50.0,
              // ignore: deprecated_member_use
              child: Center(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.phone,
                            color: backgroundblack,
                            size: 25,
                          )),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Login / Sign Up",
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
            )),
      ),
    );
  }

  Widget googleButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: InkWell(
        onTap: () {
          setState(() {
            isLoading = true;
          });

          signInWithGoogle(context).whenComplete(() {
            setState(() {
              isLoading = false;
            });
          }
          );
        },
        child: SizedBox(
            height: 60,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                  color: appColorWhite,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              height: 50.0,
              // ignore: deprecated_member_use
              child: Center(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          "assets/images/google.png",
                          height: 25,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Login With Google",
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
            )),
      ),
    );
  }

  Widget fbButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: InkWell(
        onTap: () {
          print("calling this function here");
          loginWithFacebook(context).whenComplete(() {
            setState(() {
              isLoading = false;
            });
          });
        },
        child: SizedBox(
            height: 60,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFF376aed),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              height: 50.0,
              // ignore: deprecated_member_use
              child: Center(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          "assets/images/facebook.png",
                          height: 30,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Login With Facebook",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: appColorWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
