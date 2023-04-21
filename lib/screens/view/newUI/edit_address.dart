import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:http/http.dart' as http;
import '../../../constant/global.dart';
import '../models/add_address_model.dart';

class EditAddress extends StatefulWidget {
  final name, mobile, address, building, city, state, pincode, country, isSet;

  const EditAddress({Key? key, this.name, this.mobile, this.address, this.building, this.city, this.state, this.pincode, this.country, this.isSet}) : super(key: key);

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  late TextEditingController addressC;
  late TextEditingController nameC;
  late TextEditingController mobileC;
  late TextEditingController pincodeC;
  late TextEditingController cityC;
  late TextEditingController stateC;
  late TextEditingController buildingC;
  late TextEditingController countryC;

  double lat = 0.0;
  double long = 0.0;
  // String radioButtonItem = 'ONE';
  int id = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameC = TextEditingController(text: widget.name);
    mobileC = TextEditingController(text: widget.mobile);
    addressC = TextEditingController(text: widget.address);
    buildingC = TextEditingController(text: widget.building);
    cityC = TextEditingController(text: widget.city);
    stateC = TextEditingController(text: widget.state);
    countryC = TextEditingController(text: widget.country);
    pincodeC = TextEditingController(text: widget.pincode);
    id = int.parse(widget.isSet.toString());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: backgroundblack,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)
              )
          ),
          elevation: 0,
          title: Text(
            'Edit Address',
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
                if(model!.responseCode == "1"){
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg: "Address Added Successfully!",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: backgroundblack,
                      textColor: appColorWhite,
                      fontSize: 13.0);
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
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/update_address'));
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
