import 'dart:convert';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:ez/Helper/session.dart';
import 'package:ez/models/uProfileModal.dart';
import 'package:ez/screens/view/newUI/booking.dart';
import 'package:ez/screens/view/newUI/changePassword.dart';
import 'package:ez/screens/view/newUI/notificationScreen.dart';
import 'package:ez/screens/view/newUI/welcome2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:ez/constant/global.dart';
import 'package:ez/constant/sizeconfig.dart';
import 'package:ez/screens/view/newUI/login.dart';
import 'package:ez/screens/view/models/getUserModel.dart';
import 'package:ez/share_preference/preferencesKey.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:toast/toast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  bool? back;
  Profile({this.back});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _username = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _email  = TextEditingController();

  // File? selectedImage;
  // String? imageUrl;

   File? imagePath;
  // String? filePath;
  // File? selectedImage;
  String? filePath;
  GeeUserModel? model;
  bool? isLoading = false;
  bool? isLoad = false;
  //final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position? currentLocation;
  String? _currentAddress;
  String? _emailAddress;

 // XFile? image = await picker.pickImage(source: ImageSource.gallery);
  @override
  void initState() {
    _getAddressFromLatLng();
    super.initState();
   Future.delayed(Duration.zero,(){
     return  getUserDataApicall();
   });
  }

  getUserDataApicall() async {
    setState(() {
      isLoading = true;
    });

    try {
      Map<String, String> headers = {
        'content-type': 'application/x-www-form-urlencoded',
      };
      var map = new Map<String, dynamic>();
      map['user_id'] = userID;

      final response = await client.post(Uri.parse("${baseUrl()}/user_data"),
          headers: headers, body: map);
      print(map.toString());
      var dic = json.decode(response.body);
      Map<String, dynamic> userMap = jsonDecode(response.body);
      model = GeeUserModel.fromJson(userMap);
      userEmail = model!.user!.email!;
      userMobile = model!.user!.mobile!;
      _username.text = model!.user!.username!;
      _mobile.text = model!.user!.mobile!;
      _address.text = model!.user!.address ?? "";
      _email.text = model!.user!.email ?? "";
      print("GetUserData>>>>>>");
      print("checking address here ${_address.text} and ${_mobile.text}");
      print(dic);

      setState(() {
        isLoading = false;
      });
    } on Exception {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "No Internet connection");
      throw Exception('No Internet connection');
    }
  }

  Future getUserCurrentLocation() async {
    await Geolocator.getCurrentPosition().then((position) {
      if (mounted)
        setState(() {
          currentLocation = position;
        });
    });
  }

  _getAddressFromLatLng() async {
    getUserCurrentLocation().then((_) async {
      try {
        List<Placemark> p = await placemarkFromCoordinates(
            currentLocation!.latitude, currentLocation!.longitude);

        Placemark place = p[0];

        setState(() {
          _currentAddress = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}";
          print(_currentAddress);
        });
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: appColorWhite,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)
              )
          ),
          backgroundColor: backgroundblack,
          elevation: 0,
          title: Text(
            '${getTranslated(context, 'profile')}',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: widget.back == true
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (widget.back == true) {
                      Navigator.pop(context);
                    }
                  },
                )
              : Container(),
          actions: [
            // IconButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => NotificationList()),
            //       );
            //     },
            //     icon: Icon(
            //       Icons.notifications_outlined,
            //       color: appColorWhite,
            //     )),
            Container(width: 10),
          ],
        ),
        body: isLoading == true
            ? Center(
                child: Image.asset("assets/images/loader1.gif"),
              )
            : Stack(
                children: [
                model == null ? Container(child: Center(child: CircularProgressIndicator(color: backgroundblack,))) :  _userInfo(),
                  isLoad == true ? Center(child: load()) : Container()
                ],
              )
    );
  }

  Widget _userInfo() {
    return model!.user != null
        ? Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 15,
                    ),
                    profilePic(model!.user!),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 2,
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      controller: _username,
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                      decoration: InputDecoration.collapsed(
                        hintText: "Enter Name",
                        hintStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(height: 10),
                    Row(
                      children: [
                        // Container(
                        //   child: Card(
                        //     elevation: 5,
                        //     shape: CircleBorder(),
                        //     child: Padding(
                        //       padding:
                        //       const EdgeInsets.all(10),
                        //       child: Icon(
                        //         Icons.email_outlined,
                        //         size: 25,
                        //         color: Colors.cyan,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Container(
                        //   width: 30,
                        // ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                                model!.user!.email!.length > 0
                                    ? model!.user!.email!
                                    : "Logged in with social account",
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight:
                                    FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(height: 10),
                    Text(
                      _currentAddress != null
                          ? _currentAddress!
                          : "please wait..",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 14),
                    ),

                    Container(height: 20),
                    Padding(
                      padding: EdgeInsets.only(left: 12,right: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Container(
                                      height: 180,
                                    ),
                                  ),
                                ),
                                Container(
                                  //elevation: 0,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 0,right: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(height: 10),
                                        Row(
                                          children: [
                                            Container(
                                              child: Card(
                                                color:  backgroundblack,
                                                elevation: 5,
                                                shape: CircleBorder(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Icon(
                                                    Icons.local_phone_outlined,
                                                    size: 25,
                                                    color: appColorWhite,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 30,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Mobile Number",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey[600],
                                                        fontSize: 12),
                                                  ),
                                                  Container(height: 3),
                                                  TextFormField(
                                                    controller: _mobile,
                                                    maxLines: 1,
                                                    maxLength: 10,
                                                      validator: (value){
                                                      if(value!.length != 10){
                                                        return "Enter valid number";
                                                      }
                                                      return null;
                                                      },
                                                    keyboardType: TextInputType.phone,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                    decoration: InputDecoration(

                                                    counterText: "",
                                                      hintText: "Enter Mobile",
                                                      hintStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(height: 10),
                                        Row(
                                          children: [
                                            Container(
                                              child: Card(
                                                elevation: 5,
                                                shape: CircleBorder(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Icon(
                                                    Icons.email_outlined,
                                                    size: 25,
                                                    color: Colors.cyan,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 30,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Email",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey[600],
                                                        fontSize: 12),
                                                  ),
                                                  Container(height: 3),
                                                  // Text(
                                                  //   model!.user!.email!.length > 0
                                                  //       ? model!.user!.email!
                                                  //       : "Logged in with social account",
                                                  //   maxLines: 1,
                                                  //   style: TextStyle(
                                                  //       color: Colors.black,
                                                  //       fontWeight:
                                                  //           FontWeight.bold,
                                                  //       fontSize: 14),
                                                  // ),
                                                  TextFormField(
                                                    controller: _email,
                                                    maxLines: 1,
                                                    keyboardType: TextInputType.emailAddress,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 14),
                                                    decoration:
                                                    InputDecoration
                                                      (
                                                      hintText: "Enter email",
                                                      hintStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(height: 10),
                                        Row(
                                          children: [
                                            Container(
                                              child: Card(
                                                color:  backgroundblack,
                                                elevation: 5,
                                                shape: CircleBorder(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Icon(
                                                    Icons.location_on_outlined,
                                                    size: 27,
                                                    color: appColorWhite,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 30,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Address",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey[600],
                                                        fontSize: 12),
                                                  ),
                                               //   Container(height: 1),
                                                  TextFormField(
                                                    controller: _address,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                    decoration:
                                                         InputDecoration
                                                            (
                                                      hintText: "Enter Address",
                                                      hintStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(height: 20),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 10, right: 15),
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       InkWell(
                          //         onTap: () {
                          //           Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) =>
                          //                     BookingScreen(back: true)),
                          //           );
                          //         },
                          //         child: Container(
                          //           decoration: BoxDecoration(
                          //               shape: BoxShape.circle,
                          //               color: Colors.black45),
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: Icon(
                          //               Icons.format_list_bulleted_rounded,
                          //               color: appColorWhite,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       Text(
                          //         "Bookings",
                          //         style: TextStyle(
                          //             color: Colors.black45,
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 12),
                          //       ),
                          //       //Container(height: 10),
                          //       // InkWell(
                          //       //   onTap: () {
                          //       //     Navigator.push(
                          //       //       context,
                          //       //       MaterialPageRoute(
                          //       //           builder: (context) => ChangePass()),
                          //       //     );
                          //       //   },
                          //       //   child: Container(
                          //       //     decoration: BoxDecoration(
                          //       //         shape: BoxShape.circle,
                          //       //         color: Colors.black45),
                          //       //     child: Padding(
                          //       //       padding: const EdgeInsets.all(8.0),
                          //       //       child: Icon(
                          //       //         Icons.lock_open_rounded,
                          //       //         color: appColorWhite,
                          //       //       ),
                          //       //     ),
                          //       //   ),
                          //       // ),
                          //       // Text(
                          //       //   "Password",
                          //       //   style: TextStyle(
                          //       //       color: Colors.black45,
                          //       //       fontWeight: FontWeight.bold,
                          //       //       fontSize: 12),
                          //       // ),
                          //       Container(height: 10),
                          //       InkWell(
                          //         onTap: () {
                          //           Alert(
                          //             context: context,
                          //             title: "Log out",
                          //             desc: "Are you sure you want to log out?",
                          //             style: AlertStyle(
                          //                 isCloseButton: false,
                          //                 descStyle: TextStyle(
                          //                     fontFamily: "MuliRegular",
                          //                     fontSize: 15),
                          //                 titleStyle: TextStyle(
                          //                     fontFamily: "MuliRegular")),
                          //             buttons: [
                          //               DialogButton(
                          //                 child: Text(
                          //                   "OK",
                          //                   style: TextStyle(
                          //                       color: Colors.white,
                          //                       fontSize: 16,
                          //                       fontFamily: "MuliRegular"),
                          //                 ),
                          //                 onPressed: () async {
                          //                   setState(() {
                          //                     userID = '';
                          //
                          //                     userEmail = '';
                          //                     userMobile = '';
                          //                     likedProduct = [];
                          //                     likedService = [];
                          //                   });
                          //                   // signOutGoogle();
                          //                  // signOutFacebook();
                          //                   preferences!
                          //                       .remove(SharedPreferencesKey
                          //                           .LOGGED_IN_USERRDATA)
                          //                       .then((_) {
                          //                     Navigator.of(context)
                          //                         .pushAndRemoveUntil(
                          //                       MaterialPageRoute(
                          //                         builder: (context) =>
                          //                             Welcome2(),
                          //                       ),
                          //                       (Route<dynamic> route) => false,
                          //                     );
                          //                   });
                          //
                          //                   Navigator.of(context,
                          //                           rootNavigator: true)
                          //                       .pop();
                          //                 },
                          //                 color:backgroundblack,
                          //                     // Color.fromRGBO(0, 179, 134, 1.0),
                          //               ),
                          //               DialogButton(
                          //                 child: Text(
                          //                   "Cancel",
                          //                   style: TextStyle(
                          //                       color: Colors.white,
                          //                       fontSize: 16,
                          //                       fontFamily: "MuliRegular"),
                          //                 ),
                          //                 onPressed: () {
                          //                   Navigator.of(context,
                          //                           rootNavigator: true)
                          //                       .pop();
                          //                 },
                          //              color: backgroundblack,
                          //               ),
                          //             ],
                          //           ).show();
                          //         },
                          //         child: Container(
                          //           decoration: BoxDecoration(
                          //               shape: BoxShape.circle,
                          //               color: Colors.black45),
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: Icon(
                          //               Icons.logout,
                          //               color: appColorWhite,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       Text(
                          //         "Logout",
                          //         style: TextStyle(
                          //             color: Colors.black45,
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 12),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 55, right: 55),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              updateAPICall();
                            },
                            child: SizedBox(
                                height: 50,
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
                                            "${getTranslated(context,'update')}",
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
                          SizedBox(height: 10,),
                          InkWell(
                            onTap: () {
                              Alert(
                                context: context,
                                title: "Log out",
                                desc: "Are you sure you want to log out?",
                                style: AlertStyle(
                                    isCloseButton: false,
                                    descStyle:
                                    TextStyle(fontFamily: "MuliRegular", fontSize: 15),
                                    titleStyle: TextStyle(fontFamily: "MuliRegular")),
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "OK",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: "MuliRegular"),
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        userID = '';

                                        userEmail = '';
                                        userMobile = '';
                                        likedProduct = [];
                                        likedService = [];
                                      });
                                      // signOutGoogle();
                                      //signOutFacebook();
                                      preferences!
                                          .remove(SharedPreferencesKey.LOGGED_IN_USERRDATA)
                                          .then((_) {
                                        Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => Welcome2(),
                                          ),
                                              (Route<dynamic> route) => false,
                                        );
                                      });

                                      Navigator.of(context, rootNavigator: true).pop();
                                    },
                                    color: backgroundblack,
                                    // color: Color.fromRGBO(0, 179, 134, 1.0),
                                  ),
                                  DialogButton(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: "MuliRegular"),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true).pop();
                                    },
                                    color: backgroundblack,
                                    // gradient: LinearGradient(colors: [
                                    //   Color.fromRGBO(116, 116, 191, 1.0),
                                    //   Color.fromRGBO(52, 138, 199, 1.0)
                                    // ]),
                                  ),
                                ],
                              ).show();
                            },
                            child: SizedBox(
                                height: 50,
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
                                            "${getTranslated(context, 'logout')}",
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 5,
                    ),
                  ],
                ),
              ),
            ],
          )
        : Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "No data found",
                style:
                    TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 6.5),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 3,
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal! * 60,
                height: SizeConfig.blockSizeVertical! * 7,
                child: CupertinoButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => Login(),
                      ),
                    )
                  },
                  color: Color(0xFF1E3C72),
                  borderRadius: new BorderRadius.circular(30.0),
                  child: new Text(
                    "Login Now",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.blockSizeHorizontal! * 3.5),
                  ),
                ),
              ),
            ],
          ));
  }

  Widget profilePic(User user) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        userImg(user),
        InkWell(
          onTap: (){
            openImageFromCamOrGallary(context);
          },
          child: Container(
              decoration: BoxDecoration(
                color: backgroundblack,
                borderRadius: BorderRadius.circular(100)
              ),
              child: Padding(
                padding:  EdgeInsets.all(5.0),
                child: Icon(Icons.edit,color: appColorWhite,),
              )),
        )
        // editIconForPhoto(),
      ],
    );
  }

  Widget userImg(User user) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: () {
          // openImageFromCamOrGallary(context);
        },
        child: Container(
          height: 150,
          width: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: imagePath == null
                ? user.profilePic != null
                    ? Image.network(
                        user.profilePic!,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object? exception,
                            StackTrace? stackTrace) {
                          return Icon(Icons.person, size: 100);
                        },
                      )
                    : Icon(Icons.person, size: 100)
                : Image.file(imagePath!, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  Widget editIconForPhoto() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      padding: EdgeInsets.all(5),
      child: Container(
          child: InkWell(
        onTap: () {
          openImageFromCamOrGallary(context);
        },
        child: Image.asset('assets/images/logo.png', height: 25),
      )),
    );
  }

  void containerForSheet<T>({BuildContext? context, Widget? child}) {
    showCupertinoModalPopup<T>(
      context: context!,
      builder: (BuildContext context) => child!,
    ).then<void>((T? value) {});
  }

  openImageFromCamOrGallary(BuildContext context) {
    containerForSheet<String>(
      context: context,
      child: CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(
              "Camera",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            onPressed: () {
              getImageFromCamera();
              Navigator.of(context, rootNavigator: true).pop("Discard");
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              "Photo & Video Library",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            onPressed: () {
              getImageFromGallery();
              Navigator.of(context, rootNavigator: true).pop("Discard");
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          isDefaultAction: true,
          onPressed: () {
            // Navigator.pop(context, 'Cancel');
            Navigator.of(context, rootNavigator: true).pop("Discard");
          },
        ),
      ),
    );
  }

  // Future getImageFromCamera() async {
  //   // ignore: deprecated_member_use
  //   final ImagePicker _picker = ImagePicker();
  //   XFile? image = await _picker.pickImage(
  //       source: ImageSource.camera, imageQuality: 30);
  //        setState(() {
  //          imagePath = image as File;
  //   });
  // }

  Future<void> getImageFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imagePath =  File(pickedFile.path);
        // imagePath = File(pickedFile.path) ;
        // filePath = imagePath!.path.toString();
      });
    }
  }

  // Future getImageFromGallery() async {
  //   // ignore: deprecated_member_use
  //   final ImagePicker _picker = ImagePicker();
  //   File image = (await _picker.pickImage(
  //       source: ImageSource.gallery, imageQuality: 30)) as File;
  //   setState(() {
  //     selectedImage = image;
  //   });
  // }
  Future<void> getImageFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imagePath =  File(pickedFile.path);
        // imagePath = File(pickedFile.path) ;
        // filePath = imagePath!.path.toString();
      });
    }
  }


  updateAPICall() async {
    closeKeyboard();
    UpdatePro editProfileModal;

    setState(() {
      isLoad = true;
    });

    var uri = Uri.parse('${baseUrl()}/user_edit');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    print(uri.toString());

    request.headers.addAll(headers);
    request.fields['email'] = model!.user!.email.toString();
    request.fields['username'] = _username.text;
    request.fields['mobile'] = _mobile.text;
    request.fields['address'] = _address.text;
    request.fields['city'] = model!.user!.city.toString();
    request.fields['country'] = model!.user!.country.toString();
    request.fields['id'] = userID;
    print(request.fields.toString());

    if (imagePath != null) {
      request.files.add(
          await http.MultipartFile.fromPath('profile_pic', imagePath!.path));
    }
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    editProfileModal = UpdatePro.fromJson(userData);

    if (editProfileModal.responseCode == "1") {
      setState(() {
        isLoad = false;
      });

      Flushbar(
        title: "Success",
        message: editProfileModal.message,
        duration: Duration(seconds: 3),
        icon: Icon(
          Icons.done,
          color: appColorOrange,
          size: 35,
        ),
      )..show(context);
    } else {
      setState(() {
        isLoad = false;
      });
      Flushbar(
        title: "Error",
        message: editProfileModal.message,
        duration: Duration(seconds: 3),
        icon: Icon(
          Icons.error,
          color: Colors.red,
        ),
      )..show(context);
    }
  }
}
