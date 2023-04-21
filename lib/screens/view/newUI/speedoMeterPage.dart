import 'package:flutter/material.dart';

import '../../../constant/global.dart';

class SpeedoMeterPage extends StatefulWidget {
  const SpeedoMeterPage({Key? key}) : super(key: key);

  @override
  State<SpeedoMeterPage> createState() => _SpeedoMeterPageState();
}

class _SpeedoMeterPageState extends State<SpeedoMeterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorWhite,
      appBar: AppBar(
        backgroundColor: backgroundblack,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)
            )
        ),
        elevation: 2,
        title: Text(
          "",
          style: TextStyle(
            fontSize: 20,
            color: appColorWhite,
          ),
        ),
        centerTitle: true,
        leading:  Padding(
          padding: const EdgeInsets.all(12),
          child: RawMaterialButton(
            shape: CircleBorder(),
            padding: const EdgeInsets.all(0),
            fillColor: Colors.white,
            splashColor: Colors.grey[400],
            child: Icon(
              Icons.arrow_back,
              size: 20,
              color: appColorBlack,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Container(
        child:Center(
          child: Text("Speedometer page here"),
        ),
      ),
    );
  }
}
