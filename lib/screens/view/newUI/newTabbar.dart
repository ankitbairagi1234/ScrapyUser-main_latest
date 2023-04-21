import 'dart:convert';

import 'package:ez/Helper/session.dart';
import 'package:ez/screens/view/models/getUserModel.dart';
import 'package:ez/screens/view/newUI/AddScrap.dart';
import 'package:ez/screens/view/newUI/Change_Language.dart';
import 'package:ez/screens/view/newUI/faq_screen.dart';
import 'package:ez/screens/view/newUI/feedback.dart';
import 'package:ez/screens/view/newUI/help.dart';
import 'package:ez/screens/view/newUI/price.dart';
import 'package:ez/screens/view/newUI/searchProduct.dart';
import 'package:ez/screens/view/newUI/walletScreen.dart';
import 'package:ez/screens/view/newUI/welcome2.dart';
import 'package:flutter/material.dart';
import 'package:ez/constant/global.dart';
import 'package:ez/screens/view/newUI/profile.dart';
import 'package:ez/screens/view/newUI/booking.dart';
import 'package:ez/screens/view/newUI/home1.dart';
import 'package:ez/share_preference/preferencesKey.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';
import 'categoriesScreen.dart';
import 'notificationScreen.dart';

// ignore: must_be_immutable
class TabbarScreen extends StatefulWidget {
  int? currentIndex;
  @override
  _TabbarScreenState createState() => _TabbarScreenState();
}

class _TabbarScreenState extends State<TabbarScreen> {
  int _currentIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Position? currentLocation;

  Future getUserCurrentLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) {
      if (mounted)
        setState(() {
          currentLocation = position;
          homelat = currentLocation!.latitude;
          homeLong = currentLocation!.longitude;
          prefs.setString('lati', "${homelat.toString()}");
          prefs.setString("longi", "${homeLong.toString()}");
        });
    });

  }

  _getAddressFromLatLng() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getUserCurrentLocation().then((_) async {
      try {
        List<Placemark> p = await placemarkFromCoordinates(
            currentLocation!.latitude, currentLocation!.longitude);
        Placemark place = p[0];
        setState(() {
          _currentAddress =
              "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}";
          //"${place.name}, ${place.locality},${place.administrativeArea},${place.country}";
          print("ooo ${_currentAddress}");
          prefs.setString('address', "${_currentAddress}");
        });
      } catch (e) {
        print(e);
      }
    });
  }

  String? _currentAddress;
  List<dynamic> _handlePages = [
    HomeScreen(),
    // StoreScreenNew(),
    CategoriesScreen(),
    // StoreScreen(),
    AddScrapPage(),
    Price(),
    BookingScreen(),
  ];

  _getLocation() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
          "AIzaSyCqQW9tN814NYD_MdsLIb35HRY65hHomco",
          // "AIzaSyCK3y1HjzAS3RGDTwGE6EITRzmimOBGGoQ",
        )));
    print("checking adderss detail ${result.locality}");
    setState(() {
       _currentAddress = result.formattedAddress.toString();
       print("checking current address ${_currentAddress}");
      // cityC.text = result.locality.toString();
      // stateC.text = result.administrativeAreaLevel1!.name.toString();
      // countryC.text = result.country!.name.toString();
      // lat = result.latLng!.latitude;
      // long = result.latLng!.longitude;
      // pincodeC.text = result.postalCode.toString();
    });
  }

  _getPickLocation() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
          "AIzaSyCqQW9tN814NYD_MdsLIb35HRY65hHomco",
          // "AIzaSyCK3y1HjzAS3RGDTwGE6EITRzmimOBGGoQ",
        )));
    print(
        "checking adderss detail ${result.country!.name.toString()} and ${result.locality.toString()} and ${result.country!.shortName.toString()} ");
    setState(() {
      _currentAddress = result.formattedAddress.toString();
      String  pickLat = result.latLng!.latitude.toString();
      String pickLong = result.latLng!.longitude.toString();
      // cityC.text = result.locality.toString();
      // stateC.text = result.administrativeAreaLevel1!.name.toString();
      // countryC.text = result.country!.name.toString();
      // lat = result.latLng!.latitude;
      // long = result.latLng!.longitude;
      // pincodeC.text = result.postalCode.toString();
      print("this is picked LAT LONG $pickLat @@ $pickLong");
    });
  }
  int? selectLan;

  @override
  void initState() {
    new Future.delayed(Duration.zero, () {
      languageList = [
        getTranslated(context, 'ENGLISH_LAN'),
        getTranslated(context, 'HINDI_LAN'),
      ];
    });
    getUserDataFromPrefs();
   // _getLocation();
    getCurrentLocation();
    _getAddressFromLatLng();

    super.initState();
    Future.delayed(Duration(milliseconds: 300),(){
      return getUserDataApicall();
    });
  }

GeeUserModel? model;
  String? userImage;

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
      userImage = model!.user!.profilePic;
      // _username.text = model!.user!.username!;
      // _mobile.text = model!.user!.mobile!;
      // _address.text = model!.user!.address ?? "";
      // _email.text = model!.user!.email ?? "";
      // print("GetUserData>>>>>>");
      // print("checking address here ${_address.text} and ${_mobile.text}");
      // print(dic);

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


  getUserDataFromPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userDataStr =
        preferences.getString(SharedPreferencesKey.LOGGED_IN_USERRDATA);
    Map<String, dynamic> userData = json.decode(userDataStr!);
    print(userData);

    setState(() {
      userID = userData['user_id'];
    });
  }

  bool isLoading = false;

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit an App?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                //return true when click on "Yes"
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }




  // @override
  // void initState() {
  //   new Future.delayed(Duration.zero, () {
  //     languageList = [
  //       getTranslated(context, 'ENGLISH_LAN'),
  //       getTranslated(context, 'HINDI_LAN'),
  //     ];
  //   });
  //   super.initState();
  //   //  getProfile();
  // }
  final GlobalKey<FormState> _changePwdKey = GlobalKey<FormState>();
  void openChangeLanguageBottomSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Form(
                  key: _changePwdKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      bottomSheetHandle(),
                      bottomsheetLabel("CHOOSE_LANGUAGE_LBL"),
                      StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter setModalState) {
                          return SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: getLngList(context, setModalState)),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
  Widget getHeading(String title) {
    print("here is title value ${title}");
    return Text(
      getTranslated(context, title).toString(),
      style: Theme.of(context).textTheme.headline6!.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.black),
    );
  }
  Widget bottomSheetHandle() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.black),
        height: 5,
        width: MediaQuery.of(context).size.width * 0.3,
      ),
    );
  }

  Widget bottomsheetLabel(String labelName) => Padding(
    padding: const EdgeInsets.only(top: 30.0, bottom: 20),
    child: getHeading(labelName),
  );
  List<String> langCode = ["en", "hi"];
  List<String?> languageList = [];
  List<Widget> getLngList(BuildContext ctx, StateSetter setModalState) {
    return languageList
        .asMap()
        .map(
          (index, element) => MapEntry(
          index,
          InkWell(
            onTap: () {
              if (mounted)
                setState(() {
                  selectLan = index;
                  _changeLan(langCode[index], ctx);
                });
              setModalState((){});
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 25.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectLan == index
                                ? Colors.grey
                                : Colors.white,
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: selectLan == index
                              ? Icon(
                            Icons.check,
                            size: 17.0,
                            color: Colors.black,
                          )
                              : Icon(
                              Icons.check_box_outline_blank,
                              size: 15.0,
                              color:Colors.white
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: 15.0,
                          ),
                          child: Text(
                            languageList[index].toString(),
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                color: Colors.black),
                          ))
                    ],
                  ),
                  // index == languageList.length - 1
                  //     ? Container(
                  //         margin: EdgeInsetsDirectional.only(
                  //           bottom: 10,
                  //         ),
                  //       )
                  //     : Divider(
                  //         color: Theme.of(context).colorScheme.lightBlack,
                  //       ),
                ],
              ),
            ),
          )),
    )
        .values
        .toList();
  }

  void _changeLan(String language, BuildContext ctx) async {
    Locale _locale = await setLocale(language);

    MyApp.setLocale(ctx, _locale);
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        key: _scaffoldKey,
        body: _handlePages[_currentIndex],
        appBar: AppBar(
          backgroundColor: backgroundblack,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          elevation: 0,
          leading: InkWell(
            onTap: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                minRadius: 20,
                maxRadius: 20,
                child: Icon(
                  Icons.person,
                  color: backgroundblack,
                ),
              ),
            ),
          ),
          title: _currentIndex == 4
              ? Text("${getTranslated(context, 'myOrders')}")
              : InkWell(
                  onTap: () {
                    _getLocation();
                    // _getPickLocation();
                   // getUserCurrentLocation();
                    print("tapped");
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 0),
                    // decoration: BoxDecoration(
                    //   color: appColorWhite,
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 0.0),
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
            // CircleAvatar(
            //   radius: 18,
            //   backgroundColor: Colors.grey[100],
            //   child: IconButton(
            //     icon: Icon(
            //       Icons.search,
            //       color: backgroundblack,
            //       size: 20,
            //     ),
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => SearchProduct()),
            //       );
            //     },
            //   ),
            // ),
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
        drawer: getDrawer(),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(0),
            topLeft: Radius.circular(0),
          ),
          child: BottomNavigationBar(
            selectedIconTheme: IconThemeData(color: backgroundblack),
            selectedItemColor: backgroundblack,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            selectedLabelStyle:
                TextStyle(fontWeight: FontWeight.bold, color: backgroundblack),
            unselectedLabelStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            // type: BottomNavigationBarType.shifting,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: <BottomNavigationBarItem>[
              _currentIndex == 0
                  ? BottomNavigationBarItem(
                      icon:
                      Image.asset(
                        'assets/images/home2.png',
                        height: 25,
                        color: backgroundblack,
                      ),
                      label: "${getTranslated(context, 'HOME')}")
                  : BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/home.png',
                        height: 25,
                      ),
                      label: "${getTranslated(context, 'HOME')}",
                    ),
              /* _currentIndex == 1
                  ? BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/service2.png',
                        height: 25,
                        color: appColorOrange,
                      ),
                      label: "Services")
                  : BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/service1.png',
                        height: 25,
                      ),
                      label: "Services"),*/
              _currentIndex == 1
                  ? BottomNavigationBarItem(
                      icon: Icon(
                        Icons.category,
                        color: backgroundblack,
                      ),
                      label: "${getTranslated(context, 'category')}")
                  : BottomNavigationBarItem(
                      icon: Icon(
                        Icons.category,
                        // color: appColorOrange,
                      ),
                      label: "${getTranslated(context, 'category')}"),
              _currentIndex == 2
                  ? BottomNavigationBarItem(icon: Icon(Icons.add), label: '${getTranslated(context, 'add')}')
                  : BottomNavigationBarItem(
                      icon: Icon(Icons.add), label: "${getTranslated(context, 'add')}"),
              _currentIndex == 3
                  ? BottomNavigationBarItem(
                      icon: Icon(
                        Icons.price_change_outlined,
                        color: backgroundblack,
                        size: 24,
                      ),
                      label: "${getTranslated(context, 'price')}")
                  : BottomNavigationBarItem(
                      icon: Icon(Icons.price_change_outlined), label: "${getTranslated(context, 'price')}"),
              _currentIndex == 4
                  ? BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/order2.png',
                        height: 25,
                        color: backgroundblack,
                      ),
                      label: '${getTranslated(context, 'orders')}')
                  : BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/order.png',
                        height: 25,
                        color: Colors.grey
                      ),
                      label: "${getTranslated(context, 'orders')}"),
            ],
          ),
        ),
      ),
    );
  }

  getDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: backgroundblack,
            ), //BoxDecoration
            child: Row(
              children: [
                SizedBox(
                  height: 20,
                ),
                userImage == null || userImage == ""
                    ? CircleAvatar(
                        backgroundColor: appColorWhite,
                        radius: 40,
                        child: Icon(
                          Icons.person,
                          color: appColorBlack,
                        ),
                      )
                    : InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(back: true,)));
                  },
                  child: CircleAvatar(
                          radius: 40,
                          backgroundColor: appColorWhite,
                          backgroundImage: NetworkImage(userImage!),
                        ),
                    ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(back: true,)));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$userName",
                          style: TextStyle(fontSize: 18, color: appColorWhite),
                        ),
                        Text(
                          "$userEmail",
                          style: TextStyle(color: appColorWhite),
                        ),
                        SizedBox(height: 8,),
                       InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(back: true,)));
                            },
                         child:  Row(
                           children: [
                             Text("${getTranslated(context, 'edit')}",style: TextStyle(color: Colors.black),),
                             SizedBox(height: 5,),
                             Icon(Icons.edit,color: Colors.black,size: 15,)
                           ],),
                       ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ), //DrawerHeader
          // ListTile(
          //   // leading:  Icon(
          //   //   Icons.home,
          //   //   color: backgroundblack,
          //   // ),
          //   title:  Text('${getTranslated(context, 'HOME')}'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => TabbarScreen()),
          //     );
          //   },
          // ),
          ListTile(
            leading:  Icon(
              Icons.wallet,
              color: backgroundblack,
            ),
            title:  Text('${getTranslated(context, 'wallet')}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyWallet()),
              );
            },
          ),

        /// language section
          ListTile(
            leading: const Icon(
              Icons.bar_chart_rounded,
              color: backgroundblack,
            ),
            title: Text("${getTranslated(context, 'language')}"),
            onTap: (){
              Future.delayed(Duration(seconds: 0),(){
                return openChangeLanguageBottomSheet();
              });
          //  Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeLanguageScreen()));
            },
          ),


          // ListTile(
          //   leading: const Icon(
          //     Icons.chat,
          //     color: backgroundblack,
          //   ),
          //   title: const Text(' Chat Support '),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
          //       MaterialPageRoute(builder: (context) => ChatScreen()),
          //     );
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.settings,
          //     color: backgroundblack,
          //   ),
          //   title: const Text('Add Request'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
          //       MaterialPageRoute(builder: (context) => RequestService()),
          //     );
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.request_page,
          //     color: backgroundblack,
          //   ),
          //   title: const Text('My Request'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
          //       MaterialPageRoute(builder: (context) => MyRequestPage()),
          //     );
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.favorite,
          //     color: backgroundblack,
          //   ),
          //   title: const Text('Wishlist'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
          //       MaterialPageRoute(
          //           builder: (context) => WishListScreen(
          //                 back: true,
          //               )),
          //     );
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.privacy_tip_rounded,
          //     color: backgroundblack,
          //   ),
          //   title: const Text('About'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
          //     );
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.privacy_tip_rounded,
          //     color: backgroundblack,
          //   ),
          //   title: const Text('Cart'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => GetCartScreeen()),
          //     );
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.list_alt,
          //     color: backgroundblack,
          //   ),
          //   title: const Text(' Terms & Condition '),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => TermsConditionScreen()),
          //     );
          //   },
          // ),
          /// Only for Testing
          // ListTile(
          //   leading: const Icon(Icons.list_alt, color: backgroundblack,),
          //   title: const Text(' Testing '),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => HomePage()),
          //     );
          //   },
          // ),
          ListTile(
            leading: const Icon(
              Icons.question_answer,
              color: backgroundblack,
            ),
            title: Text('${getTranslated(context, 'about')}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FaqScreen()),
              );
            },
          ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.feedback_rounded,
          //     color: backgroundblack,
          //   ),
          //   title: Text('${getTranslated(context, 'feedback')}'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) =>FeedBackScreen()),
          //     );
          //   },
          // ),
          ListTile(
            leading: const Icon(
              Icons.help_center,
              color: backgroundblack,
            ),
            title: Text('${getTranslated(context, 'help')}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Help()),
              );
            },
          ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.logout,
          //     color: backgroundblack,
          //   ),
          //   title: Text('${getTranslated(context, 'logout')}'),
          //   onTap: () {
          //     Alert(
          //       context: context,
          //       title: "${getTranslated(context, 'logout')}",
          //       desc: "${getTranslated(context, 'areYouSureWantLogout')}",
          //       style: AlertStyle(
          //           isCloseButton: false,
          //           descStyle:
          //               TextStyle(fontFamily: "MuliRegular", fontSize: 15),
          //           titleStyle: TextStyle(fontFamily: "MuliRegular")),
          //       buttons: [
          //         DialogButton(
          //           child: Text(
          //             "${getTranslated(context, 'ok')}",
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 16,
          //                 fontFamily: "MuliRegular"),
          //           ),
          //           onPressed: () async {
          //             setState(() {
          //               userID = '';
          //
          //               userEmail = '';
          //               userMobile = '';
          //               likedProduct = [];
          //               likedService = [];
          //             });
          //             // signOutGoogle();
          //             //signOutFacebook();
          //             preferences!
          //                 .remove(SharedPreferencesKey.LOGGED_IN_USERRDATA)
          //                 .then((_) {
          //               Navigator.of(context).pushAndRemoveUntil(
          //                 MaterialPageRoute(
          //                   builder: (context) => Welcome2(),
          //                 ),
          //                 (Route<dynamic> route) => false,
          //               );
          //             });
          //
          //             Navigator.of(context, rootNavigator: true).pop();
          //           },
          //           color: backgroundblack,
          //           // color: Color.fromRGBO(0, 179, 134, 1.0),
          //         ),
          //         DialogButton(
          //           child: Text(
          //             "${getTranslated(context, 'cancel')}",
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 16,
          //                 fontFamily: "MuliRegular"),
          //           ),
          //           onPressed: () {
          //             Navigator.of(context, rootNavigator: true).pop();
          //           },
          //           color: backgroundblack,
          //           // gradient: LinearGradient(colors: [
          //           //   Color.fromRGBO(116, 116, 191, 1.0),
          //           //   Color.fromRGBO(52, 138, 199, 1.0)
          //           // ]),
          //         ),
          //       ],
          //     ).show();
          //   },
          // ),
        ],
      ),
    );
  }
}
