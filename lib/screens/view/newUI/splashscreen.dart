import 'dart:async';
import 'package:ez/constant/constant.dart';
import 'package:ez/constant/push_notification_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez/constant/global.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController? animationController;
  Animation<double>? animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed(App_Screen);
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation =
        new CurvedAnimation(parent: animationController!, curve: Curves.easeOut);

    animation!.addListener(() => this.setState(() {}));
    animationController!.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();

    getCurrentLocation().then((_) async {
      setState(() {});
    });
    PushNotificationService pushNotificationService = PushNotificationService(context: context);
   pushNotificationService.initialise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: appColorWhite,
        child: Center(
            child:
            //Text("SCRAPY",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 28,letterSpacing: 2),)
          Image.asset(
            'assets/images/scrapyLogo1.png',
            height: 200,
            fit: BoxFit.fill,
            // width: SizeConfig.blockSizeHorizontal * 50,
          ),
        ),
      ),
    );
  }
}
