import 'package:ez/screens/view/newUI/welcome2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez/constant/global.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Expanded(
            //   child: SingleChildScrollView(
            //     child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),
                    Image.asset(
                      'assets/images/scrapyLogo1.png',
                      height: 200,
                    ),

                    // Text(appName,
                    //     style: TextStyle(
                    //         color: appColorWhite,
                    //         fontSize: 25,
                    //         fontWeight: FontWeight.bold,
                    //         fontFamily: 'Serif',
                    //     //    fontStyle: FontStyle.italic
                    //     )),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // Text('Your Hygiene App',
                    //     style: TextStyle(
                    //       color: appColorWhite,
                    //       fontSize: 14,
                    //     )),

                    Container(
                      child: Image.asset(
                        'assets/images/welcome1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                        'We make life easy with our best in class \n services at afforable rates.\n Impeccable for all.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: appColorBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 4,
                      width: 50,
                      decoration: BoxDecoration(
                          color: appColorWhite,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  ],
                ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Container(
                height: 45.0,
                width: MediaQuery.of(context).size.width,
                // ignore: deprecated_member_use
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: backgroundblack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    )
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Welcome2()),
                    );
                  },
                  // elevation: 10,
                  // color: backgroundblack,
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(15)),
                  // padding: EdgeInsets.all(0.0),
                  child: Text(
                    "GET STARTED",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: appColorWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Container(
            //   height: 4,
            //   width: 150,
            //   decoration: BoxDecoration(
            //       color: appColorWhite,
            //       borderRadius: BorderRadius.all(Radius.circular(30))),
            // ),
            SizedBox(
              height: 30,
            ),
          ],
        ));
  }
}
