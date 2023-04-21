import 'dart:convert';

import 'package:ez/screens/view/models/add_address_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:http/http.dart' as http;
import '../../../constant/global.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {

  TextEditingController addressC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController mobileC = TextEditingController();
  TextEditingController pincodeC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController stateC = TextEditingController();
  TextEditingController buildingC = TextEditingController();
  TextEditingController countryC = TextEditingController();
  double lat = 0.0;
  double long = 0.0;
  // String radioButtonItem = 'ONE';
  int id = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(userName != '' || userMobile != ''){
      nameC.text = userName;
      mobileC.text = userMobile;
    }
  }
  String? _currentAddress;
  String? homelat,homeLong;
  Position? currentLocation;

  // getUserCurrentLocation() async {
  //   LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
  //       builder: (context) => PlacePicker(
  //         "AIzaSyCqQW9tN814NYD_MdsLIb35HRY65hHomco",
  //       )));
  //   print("checking adderss detail ${result.country!.name.toString()} and ${result.locality.toString()} and ${result.country!.shortName.toString()} ");
  //   setState(() {
  //     addressC.text = result.formattedAddress.toString();
  //     cityC.text = result.locality.toString();
  //     stateC.text = result.administrativeAreaLevel1!.name.toString();
  //     countryC.text = result.country!.name.toString();
  //     lat = result.latLng!.latitude;
  //     long = result.latLng!.longitude;
  //     pincodeC.text = result.postalCode.toString();
  //   });
  // }

  Future getUserCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) {
      if (mounted)
        setState(() {
          currentLocation = position;
          homelat = currentLocation!.latitude.toString();
          homeLong = currentLocation!.longitude.toString();
        });
    });
    _getAddressFromLatLng();
  }

  _getAddressFromLatLng() async {
    getUserCurrentLocation().then((_) async {
      try {
        List<Placemark> p = await placemarkFromCoordinates(
            currentLocation!.latitude, currentLocation!.longitude);
        Placemark place = p[0];
        setState(() {
          _currentAddress =
          "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}";
          //"${place.name}, ${place.locality},${place.administrativeArea},${place.country}";

          addressC.text = _currentAddress.toString();
          cityC.text = place.locality.toString();
          stateC.text = place.administrativeArea.toString();
          countryC.text = place.country.toString();
          lat = double.parse(homelat.toString());
          long = double.parse(homeLong.toString());
          pincodeC.text = place.postalCode.toString();
        });
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: backgroundblack,
          elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)
            )
        ),
          title: Text(
            'Add Address',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: 30.0),
            _userName(context),
            Container(height: 10.0),
            _mobile(context),
            Container(height: 10.0),
            _addressField(context),
            Container(height: 10.0),
            _building(context),
            Container(height: 10.0),
            _city(context),
            Container(height: 10.0),
            _state(context),
            Container(height: 10.0),
            _country(context),
            Container(height: 10.0),
            _pincode(context),
            Container(height: 10.0),
            _addressType(context),
            Container(height: 20.0),
            InkWell(
              onTap: () async {
                AddAddressModel? model = await addAddress();
                if(buildingC.text == "" || cityC.text == "" || stateC.text == "" || countryC.text  == "" || pincodeC.text == ""){
                  // if (model!.responseCode == "1") {
                  //   Navigator.pop(context);
                  //   Fluttertoast.showToast(
                  //       msg: "Address Added Successfully!",
                  //       toastLength: Toast.LENGTH_LONG,
                  //       gravity: ToastGravity.BOTTOM,
                  //       timeInSecForIosWeb: 1,
                  //       backgroundColor: backgroundblack,
                  //       textColor: appColorWhite,
                  //       fontSize: 13.0);
                  // }
                  const snackBar = SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('All fields are required'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                else{
                  if (model!.responseCode == "1") {
                    Navigator.pop(context,true);
                    Fluttertoast.showToast(
                        msg: "Address Added Successfully!",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: backgroundblack,
                        textColor: appColorWhite,
                        fontSize: 13.0);
                  }

                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                          color: backgroundblack,
                          border: Border.all(color: Colors.grey),
                          borderRadius:
                          BorderRadius.all(Radius.circular(15))),
                      height: 50.0,
                      // ignore: deprecated_member_use
                      child: Center(
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "ADD ADDRESS",
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _addressField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: CustomtextField(
        readOnly: true,
        controller: addressC,
        maxLines: 1,
        labelText: "Address",
        hintText: "Enter Address",
        textInputAction: TextInputAction.next,
        suffixIcon: Icon(Icons.location_searching),
        onTap: (){
          _getLocation();
        },
      ),
    );
  }

  Widget _userName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: CustomtextField(
        controller: nameC,
        maxLines: 1,
        labelText: "User Name",
        hintText: "Enter User Name",
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _mobile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: CustomtextField(
        controller: mobileC,
        maxLines: 1,
        maxLength: 10,
        labelText: "User Mobile",
        hintText: "Enter Mobile Number",
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _pincode(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: CustomtextField(
        controller: pincodeC,
        maxLines: 1,
        // maxLength: 10,
        labelText: "Pincode",
        hintText: "Enter Pincode",
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _city(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: CustomtextField(
        controller: cityC,
        maxLines: 1,
        labelText: "City",
        hintText: "Enter City",
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _state(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: CustomtextField(
        controller: stateC,
        maxLines: 1,
        labelText: "State",
        hintText: "Enter State",
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _building(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: CustomtextField(
        controller: buildingC,
        maxLines: 1,
        labelText: "Building, Floor",
        hintText: "Enter Building, Floor, Flat no.",
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _country(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: CustomtextField(
        controller: countryC,
        maxLines: 1,
        labelText: "Country",
        hintText: "Enter Country",
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _addressType(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Radio(
            value: 0,
            groupValue: id,
            activeColor: backgroundblack,
            onChanged: (val) {
              setState(() {
                id = 0;
              });
            },
          ),
          Text(
            'HOME',
            style: new TextStyle(fontSize: 12.0),
          ),

          Radio(
            value: 1,
            groupValue: id,
            activeColor: backgroundblack,
            onChanged: (val) {
              setState(() {
                id = 1;
              });
            },
          ),
          Text(
            'WORK',
            style: new TextStyle(
              fontSize: 12.0,
            ),
          ),

          Radio(
            value: 2,
            groupValue: id,
            activeColor: backgroundblack,
            onChanged: (val) {
              setState(() {
                id = 2;
              });
            },
          ),
          Text(
            'OTHER',
            style: new TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  _getLocation() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
          "AIzaSyCqQW9tN814NYD_MdsLIb35HRY65hHomco",
        )));
     print("checking adderss detail ${result.country!.name.toString()} and ${result.locality.toString()} and ${result.country!.shortName.toString()} ");
    setState(() {
      addressC.text = result.formattedAddress.toString();
      cityC.text = result.locality.toString();
      stateC.text = result.administrativeAreaLevel1!.name.toString();
      countryC.text = result.country!.name.toString();
      lat = result.latLng!.latitude;
      long = result.latLng!.longitude;
      pincodeC.text = result.postalCode.toString();
    });
  }

  Future<AddAddressModel?> addAddress() async {
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/add_address'));
    request.fields.addAll({
      'user_id': '$userID',
      'address': '${addressC.text.toString()}',
      'building': '${buildingC.text.toString()}',
      'city': '${cityC.text.toString()}',
      'state': '${stateC.text.toString()}',
      'country': '${countryC.text.toString()}',
      'is_default': '1',
      'type': '$id',
      'lat': '$lat',
      'lng': '$long',
      'name': '${nameC.text.toString()}',
      'pincode': '${pincodeC.text.toString()}',
      'alt_mobile': '${mobileC.text.toString()}',
    });

    print(request);
    print(request.fields);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      return AddAddressModel.fromJson(json.decode(str));
    }
    else {
      return null;
    }
  }
}
