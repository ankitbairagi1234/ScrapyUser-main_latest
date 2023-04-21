import 'package:ez/screens/view/newUI/searchProduct.dart';
import 'package:flutter/material.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';

import '../../../constant/global.dart';
import 'notificationScreen.dart';




class CustomAppBar extends StatefulWidget {


  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _getLocation(context) async {
  LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PlacePicker(
        "AIzaSyCqQW9tN814NYD_MdsLIb35HRY65hHomco",
      )));
  //print("location result here ${result} and ${result.latLng} ");
  List locationData = result.latLng.toString().split("(");
  print(
      "ook now ${locationData} and ${locationData[0]} and ${locationData[1]}");
  List finalData = locationData[1].toString().split(",");
  print("final answer ${finalData} and ${finalData[0]} and ${finalData[1]}");
  // print("checking adderss detail ${result.country!.name.toString()} and ${result.locality.toString()} and ${result.country!.shortName.toString()} ");
  setState(() {
    // addressC.text = result.formattedAddress.toString();
    // cityC.text = result.locality.toString();
    // stateC.text = result.administrativeAreaLevel1!.name.toString();
    // countryC.text = result.country!.name.toString();
    // lat = result.latLng!.latitude;
    // long = result.latLng!.longitude;
    // pincodeC.text = result.postalCode.toString();
   });
}
String? _currentAddress;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: backgroundblack,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        elevation: 0,
        leading: InkWell(
          onTap: (){
            _scaffoldKey.currentState!.openDrawer();          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              minRadius: 20,
              maxRadius: 20,
              child: Icon(Icons.person, color: backgroundblack,),
            ),
          ),
        ),
        title:    InkWell(
          onTap: () {
            _getLocation(context);
            // getUserCurrentLocation();
            print("tapped");
          },
          child: Container(
            padding: EdgeInsets.only(left: 0),
            // decoration: BoxDecoration(
            //   color: appColorWhite,
            // ),
            child:   Padding(
              padding: const EdgeInsets.all(0.0),
              child: Text(
                _currentAddress != null
                    ? _currentAddress!
                    : "please wait..",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14),
              ),
            ),
          ),
        ),
        centerTitle: false,
        actions: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey[100],
            child: IconButton(
              icon: Icon(
                Icons.search,
                color: backgroundblack,
                size: 20,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchProduct()),
                );
              },
            ),
          ),
          Container(width: 10),

          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey[100],
            child: IconButton(
              icon: Icon(
                Icons.notifications,
                color: backgroundblack,
                size: 20,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationList()),
                );
              },
            ),
          ),
          Container(width: 10),
        ],
      ),
    );

  }
}
