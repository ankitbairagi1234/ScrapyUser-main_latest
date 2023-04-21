import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:ez/Helper/session.dart';
import 'package:ez/screens/view/models/DestinationModel.dart';
import 'package:ez/screens/view/models/OfferModel.dart';
import 'package:ez/screens/view/models/allKey_modal.dart';
import 'package:ez/screens/view/models/allProduct_modal.dart';
import 'package:ez/screens/view/models/bannerModal.dart';
import 'package:ez/screens/view/models/categories_model.dart';
import 'package:ez/screens/view/models/getCart_modal.dart';
import 'package:ez/screens/view/models/getServiceWishList_modal.dart';
import 'package:ez/screens/view/models/getWishList_modal.dart';
import 'package:ez/screens/view/newSubCategoryScreen.dart';
import 'package:ez/screens/view/newUI/CustomAppBar.dart';
import 'package:ez/screens/view/newUI/MyRequestPage.dart';
import 'package:ez/screens/view/newUI/RequestService.dart';
import 'package:ez/screens/view/newUI/Testing.dart';
import 'package:ez/screens/view/newUI/cart.dart';
import 'package:ez/screens/view/newUI/fb_sign_in.dart';
import 'package:ez/screens/view/newUI/google_sign_in.dart';
import 'package:ez/screens/view/newUI/notificationScreen.dart';
import 'package:ez/screens/view/newUI/offerPage.dart';
import 'package:ez/screens/view/newUI/privacy_policy.dart';
import 'package:ez/screens/view/newUI/productDetails.dart';
import 'package:ez/screens/view/newUI/searchProduct.dart';
import 'package:ez/screens/view/newUI/serviceScreenNew.dart';
import 'package:ez/screens/view/newUI/sub_category.dart';
import 'package:ez/screens/view/newUI/terms_condition.dart';
import 'package:ez/screens/view/newUI/welcome2.dart';
import 'package:ez/screens/view/newUI/wishList.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez/constant/global.dart';
import 'package:ez/constant/sizeconfig.dart';
import 'package:ez/screens/view/newUI/detail.dart';
import 'package:ez/screens/view/models/catModel.dart';
import 'package:ez/screens/view/newUI/viewCategory.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:ez/screens/view/newUI/newTabbar.dart';
import 'package:ez/screens/view/newUI/profile.dart';
import 'package:ez/share_preference/preferencesKey.dart';

import '../../chat_page.dart';
import '../models/MaterCategoryModel.dart';
import '../models/getUserModel.dart';
import 'Chat_Screen.dart';
import 'faq_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

var homelat;
var homeLong;

class _DiscoverState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  var orientation;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  CatModal? sortingModel;
  BannerModal? bannerModal;
  AllCateModel? collectionModal;
  FancyDrawerController? _controller;
  AllProductModal? allProduct;
  GetCartModal? getCartModal;
  GetWishListModal? getWishListModal;
  Position? currentLocation;
  GeeUserModel? model;
  final Geolocator geolocator = Geolocator();
  String? _currentAddress;
  Completer<GoogleMapController> _controller1 = Completer();

  // CameraPosition _currentPosition = CameraPosition(
  //   target: LatLng(homelat,homeLong),
  //   zoom: 12,
  // );

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    getUserCurrentLocation();
    _getAddressFromLatLng();
    getUserDataFromPrefs();
    getDestination();
    getMaterCategory();
    getOfferFunction();
    _controller = FancyDrawerController(
        vsync: this, duration: Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  _getLocation() async {
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

  OfferModel? offerModeldata;

  getOfferFunction()async{
    var headers = {
      'Cookie': 'ci_session=0ea9c1cfb58a9963d191b28aa70aaacd7c5f7b24'
    };
    var request = http.Request('POST', Uri.parse('${baseUrl()}/get_offer'));
    request.headers.addAll(headers);
    print('${baseUrl()}/get_offer');

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = OfferModel.fromJson(json.decode(finalResponse));
        setState(() {
          offerModeldata = jsonResponse;
        });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  List<dynamic> offerList = [
    {
      "id" :"1",
      "name":"Plastic waste",
      "normalPrice":"500",
      "discountPrice":"700",
      "discount":"5",
      "image":"assets/images/plasticWest.png"
    },
    {
      "id" :"2",
      "name":"Paper waste",
      "normalPrice":"200",
      "discountPrice":"300",
      "discount":"4",
      "image":"assets/images/paperWast.png"
    },
    {
      "id" :"3",
      "name":"Metal waste",
      "normalPrice":"300",
      "discountPrice":"400",
      "discount":"7",
      "image":"assets/images/metalWaste.jpg"
    },
    {
      "id" :"4",
           "name":"E waste",
      "normalPrice":"600",
      "discountPrice":"750",
      "discount":"9",
      "image":"assets/images/eWast.jpg"
    }
  ];

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

    print("LOCATION===" + currentLocation.toString());
    print("lat and long ${homelat} and ${homeLong}");
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

  getUserDataFromPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userDataStr =
        preferences.getString(SharedPreferencesKey.LOGGED_IN_USERRDATA);
    Map<String, dynamic> userData = json.decode(userDataStr!);
    print(userData);

    setState(() {
      userID = userData['user_id'];
    });
    _getAllKey();
    _getBanners();
    _getCollection();
    sortingApiCall();

    Future.delayed(Duration(seconds: 5), () {
      _getAllProduct();
    });

    _getCart();
    _getWishList();
    getUserDataApicall();
    _getServiceWishList();
  }

  _getAllKey() async {
    AllKeyModal allKeyModal;
    var uri = Uri.parse('${baseUrl()}/general_setting');
    var request = new http.MultipartRequest("GET", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    if (mounted) {
      setState(() {
        allKeyModal = AllKeyModal.fromJson(userData);
        if (allKeyModal != null) {
          stripSecret = allKeyModal.setting!.sSecretKey!;
          stripPublic = allKeyModal.setting!.sPublicKey!;
          rozSecret = allKeyModal.setting!.rSecretKey!;
          rozPublic = allKeyModal.setting!.rPublicKey!;
        }
      });
    }

    print(responseData);
  }

  sortingApiCall() async {
    if (mounted)
      setState(() {
        isLoading = true;
      });
    try {
      Map<String, String> headers = {
        'content-type': 'application/x-www-form-urlencoded',
      };
      final response = await client.post(
        Uri.parse("${baseUrl()}/get_all_cat_nvip_sorting"),
        headers: headers,
      );
      var dic = json.decode(response.body);
      Map<String, dynamic> userMap = jsonDecode(response.body);
      sortingModel = CatModal.fromJson(userMap);
      print("Sorting>>>>>>");
      print(dic);
      if (mounted)
        setState(() {
          isLoading = false;
        });
    } on Exception {
      if (mounted)
        setState(() {
          isLoading = false;
        });
      Fluttertoast.showToast(msg: "No Internet connection");
      // Toast.show("No Internet connection", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      throw Exception('No Internet connection');
    }
  }

  _getBanners() async {
    var uri = Uri.parse('${baseUrl()}/get_all_banners');
    var request = new http.MultipartRequest("GET", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    if (mounted) {
      setState(() {
        bannerModal = BannerModal.fromJson(userData);
      });
    }

    print(responseData);
  }

  _getCollection() async {
    var uri = Uri.parse('${baseUrl()}/get_all_cat');
    print("uri here ${uri}");
    var request = new http.MultipartRequest("GET", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    print(baseUrl.toString());
    request.headers.addAll(headers);
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    if (mounted) {
      setState(() {
        collectionModal = AllCateModel.fromJson(userData);
      });
    }
    print(responseData);
  }

  _getAllProduct() async {
    // print(
    //     "current location here ${currentLocation!.latitude} and ${currentLocation!.longitude}");
    var uri = Uri.parse('${baseUrl()}/service_providers');
    var request = new http.MultipartRequest("POST", uri);
    // request.fields.addAll({
    //   'lat': '${currentLocation!.latitude}',
    //   'long': '${currentLocation!.longitude}'
    // });

    var response = await request.send();
    print(request);
    print(request.fields);
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    if (mounted) {
      setState(() {
        allProduct = AllProductModal.fromJson(userData);
      });
    }
    print(responseData);
  }

  _getCart() async {
    setState(() {
      isLoading = true;
    });

    var uri = Uri.parse('${baseUrl()}/get_cart_items');
    var request = new http.MultipartRequest("Post", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields.addAll({'user_id': userID});
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    if (mounted) {
      setState(() {
        getCartModal = GetCartModal.fromJson(userData);
        isLoading = false;
      });
    }
  }

  List<String> selectedIdList = [];
  _getWishList() async {
    var uri = Uri.parse('${baseUrl()}/wishlist');
    var request = new http.MultipartRequest("Post", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields.addAll({'user_id': userID});
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    if (mounted) {
      setState(() {
        likedProduct.clear();
        getWishListModal = GetWishListModal.fromJson(userData);
        for (var i = 0; i < getWishListModal!.wishlist!.length; i++) {
          likedProduct.add(getWishListModal!.wishlist![i].proId.toString());
        }
      });
    }
  }

  _getServiceWishList() async {
    GetServiceWishListModal getServiceWishListModal;
    var uri = Uri.parse('${baseUrl()}/service_wishlist');
    var request = new http.MultipartRequest("Post", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields.addAll({'user_id': userID});
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    if (mounted) {
      setState(() {
        likedService.clear();
        getServiceWishListModal = GetServiceWishListModal.fromJson(userData);
        for (var i = 0; i < getServiceWishListModal.wishlist!.length; i++) {
          likedService
              .add(getServiceWishListModal.wishlist![i].resId.toString());
        }
      });
    }
  }

  String? perMobile;
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
      print("detail here ${map} and ");
      print("{$baseUrl()/user_data}");
      var dic = json.decode(response.body);
      Map<String, dynamic> userMap = jsonDecode(response.body);
      model = GeeUserModel.fromJson(userMap);
      userEmail = model!.user!.email!;
      userMobile = model!.user!.mobile!;
      perMobile = model!.user!.mobile!;
      userName = model!.user!.username!;
      userPic = model!.user!.profilePic!;
      wallet = model!.user!.wallet!;
      userCity = model!.user!.city.toString();
      // _username.text = model!.user!.username!;
      // _mobile.text = model!.user!.mobile!;
      // _address.text = model!.user!.address!;
      print("GetUserData>>>>>> ${userMobile}");
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
  DestinationModel? destinationModel;
  getDestination() async {
    var uri = Uri.parse('${baseUrl()}/destinations');
    var request = new http.MultipartRequest("Post", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields.addAll({'user_id': userID});
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    if (mounted) {
      setState(() {
        destinationList.clear();
        destinationModel = DestinationModel.fromJson(userData);
      });
    }
  }
  
  Future<Null> refreshFunction() async {
    await _getAddressFromLatLng();
    await getUserCurrentLocation();
    await getUserDataFromPrefs();
    await getDestination();
  }
  MaterCategoryModel? masterData;
  String? selectedMasterCategory;
  getMaterCategory()async{
    var headers = {
      'Cookie': 'ci_session=911aff6f1f7ad6b9772ceea1f8048b8a690650a5'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/get_master_category'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = MaterCategoryModel.fromJson(json.decode(finalResult));
      setState(() {
        masterData = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    /*return FancyDrawerWrapper(
      backgroundColor: Colors.white,
      controller: _controller,
      drawerItems: <Widget>[
        applogo(),
        Container(height: 30),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TabbarScreen()),
            );
          },
          child: Row(
            children: [
              Icon(
                Icons.home,
                color: Colors.black45,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Home",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal! * 5,
                      fontFamily: 'OpenSans',
                      fontStyle: FontStyle.italic)),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StoreScreenNew(back: true)),
            );
          },
          child: Row(
            children: [
              Icon(
                Icons.shopping_bag,
                color: Colors.black45,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Services",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal! * 5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                      fontStyle: FontStyle.italic)),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WishListScreen(back: true)),
            );
          },
          child: Row(
            children: [
              Icon(
                Icons.favorite,
                color: Colors.black45,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Wish List",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal! * 5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                      fontStyle: FontStyle.italic)),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile(back: true)),
            );
          },
          child: Row(
            children: [
              Icon(
                Icons.person,
                color: Colors.black45,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Profile",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal! * 5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                      fontStyle: FontStyle.italic)),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationList()),
            );
          },
          child: Row(
            children: [
              Icon(
                Icons.notifications,
                color: Colors.black45,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Notification",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal! * 5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                      fontStyle: FontStyle.italic)),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Alert(
              context: context,
              title: "Log out",
              desc: "Are you sure you want to log out?",
              style: AlertStyle(
                  isCloseButton: false,
                  descStyle: TextStyle(fontFamily: "MuliRegular", fontSize: 15),
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
                  color: Color.fromRGBO(0, 179, 134, 1.0),
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
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(116, 116, 191, 1.0),
                    Color.fromRGBO(52, 138, 199, 1.0)
                  ]),
                ),
              ],
            ).show();
          },
          child: Row(
            children: [
              Icon(
                Icons.settings_power,
                color: Colors.red,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Logout",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal! * 5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                      fontStyle: FontStyle.italic)),
            ],
          ),
        ),
        Container(height: 100),
      ],
      child: */
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColorWhite,
     // appBar: CustomAppBar(),
      // AppBar(
      //   backgroundColor: backgroundblack,
      //   shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.only(
      //           bottomLeft: Radius.circular(20),
      //           bottomRight: Radius.circular(20))),
      //   elevation: 0,
      //   leading: InkWell(
      //     onTap: (){
      //       _scaffoldKey.currentState!.openDrawer();          },
      //     child: Container(
      //       padding: EdgeInsets.all(10),
      //       child: CircleAvatar(
      //         backgroundColor: Colors.white,
      //         minRadius: 20,
      //         maxRadius: 20,
      //         child: Icon(Icons.person, color: backgroundblack,),
      //       ),
      //     ),
      //   ),
      //   title:    InkWell(
      //     onTap: () {
      //       _getLocation();
      //       // getUserCurrentLocation();
      //       print("tapped");
      //     },
      //     child: Container(
      //       padding: EdgeInsets.only(left: 0),
      //       // decoration: BoxDecoration(
      //       //   color: appColorWhite,
      //       // ),
      //       child:   Padding(
      //         padding: const EdgeInsets.all(0.0),
      //         child: Text(
      //           _currentAddress != null
      //               ? _currentAddress!
      //               : "please wait..",
      //           style: TextStyle(
      //               fontWeight: FontWeight.bold,
      //               color: Colors.white,
      //               fontSize: 14),
      //         ),
      //       ),
      //     ),
      //   ),
      //   centerTitle: false,
      //   actions: [
      //     CircleAvatar(
      //       radius: 18,
      //       backgroundColor: Colors.grey[100],
      //       child: IconButton(
      //         icon: Icon(
      //           Icons.search,
      //           color: backgroundblack,
      //           size: 20,
      //         ),
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => SearchProduct()),
      //           );
      //         },
      //       ),
      //     ),
      //     Container(width: 10),
      //     // Stack(
      //     //   alignment: AlignmentDirectional.centerEnd,
      //     //   fit: StackFit.loose,
      //     //   children: [
      //     //     CircleAvatar(
      //     //       radius: 22,
      //     //       backgroundColor: Colors.grey[100],
      //     //       child: Padding(
      //     //         padding: const EdgeInsets.all(8.0),
      //     //         child: InkWell(
      //     //           onTap: () {
      //     //             Navigator.push(
      //     //               context,
      //     //               MaterialPageRoute(
      //     //                 builder: (context) => GetCartScreeen(),
      //     //               ),
      //     //             );
      //     //           },
      //     //           child: Stack(
      //     //             alignment: AlignmentDirectional.centerEnd,
      //     //             fit: StackFit.loose,
      //     //             children: <Widget>[
      //     //               Icon(
      //     //                 Icons.shopping_cart_outlined,
      //     //                 color: appColorBlack,
      //     //                 size: 25,
      //     //               ),
      //     //             ],
      //     //           ),
      //     //         ),
      //     //       ),
      //     //     ),
      //     //     isLoading
      //     //         ? Container(
      //     //             height: 10,
      //     //             width: 10,
      //     //             child: Center(
      //     //                 child: CircularProgressIndicator(
      //     //               strokeWidth: 3,
      //     //               valueColor:
      //     //                   new AlwaysStoppedAnimation<Color>(Colors.black),
      //     //             )))
      //     //         : getCartModal != null
      //     //             ? Padding(
      //     //                 padding: EdgeInsets.only(top: 18, left: 20),
      //     //                 child: Container(
      //     //                   decoration: BoxDecoration(
      //     //                     color: Colors.black,
      //     //                     shape: BoxShape.circle,
      //     //                   ),
      //     //                   child: Center(
      //     //                     child: Padding(
      //     //                       padding: const EdgeInsets.all(3),
      //     //                       child: Text(
      //     //                         getCartModal!.totalItems == null
      //     //                             ? '0'
      //     //                             : getCartModal!.totalItems.toString(),
      //     //                         textAlign: TextAlign.center,
      //     //                         style: Theme.of(context)
      //     //                             .textTheme
      //     //                             .caption!
      //     //                             .merge(
      //     //                               TextStyle(
      //     //                                 color: Colors.white,
      //     //                                 fontSize: 10,
      //     //                               ),
      //     //                             ),
      //     //                       ),
      //     //                     ),
      //     //                   ),
      //     //                 ),
      //     //               )
      //     //             : Container()
      //     //   ],
      //     // ),
      //     CircleAvatar(
      //       radius: 18,
      //       backgroundColor: Colors.grey[100],
      //       child: IconButton(
      //         icon: Icon(
      //           Icons.notifications,
      //           color: backgroundblack,
      //           size: 20,
      //         ),
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => NotificationList()),
      //           );
      //         },
      //       ),
      //     ),
      //     Container(width: 10),
      //   ],
      // ),
      drawer: getDrawer(),
      body: RefreshIndicator(
        onRefresh: refreshFunction,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              // servicesWidget(),
              // InkWell(
              //   onTap: () {
              //     _getLocation();
              //     // getUserCurrentLocation();
              //     print("tapped");
              //   },
              //   child: Container(
              //     padding: EdgeInsets.only(left: 10),
              //     decoration: BoxDecoration(
              //       color: appColorWhite,
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.white,
              //           offset: Offset(0.0, 1.0), //(x,y)
              //           blurRadius: 1,
              //         ),
              //       ],
              //     ),
              //     child: Row(
              //       children: [
              //         Icon(
              //           Icons.location_on,
              //           color: appColorOrange,
              //           size: 20,
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(15.0),
              //           child: Text(
              //             _currentAddress != null
              //                 ? _currentAddress!
              //                 : "please wait..",
              //             style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.grey,
              //                 fontSize: 12),
              //           ),
              //         ),
              //         Container(
              //           width: 5,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Container(height: 10),
              collectionWidget(),
              Container(height: 20),
              _banner(context),
              Container(height: 20),
              // offerWidget(),
              // Container(height: 20),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 12),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Destination",
              //         style: TextStyle(
              //             color: appColorBlack,
              //             fontSize: 18,
              //             fontWeight: FontWeight.w600),
              //       ),
              //       SizedBox(
              //         height: 12,
              //       ),
              //       destinationModel == null || destinationModel!.data!.isEmpty
              //           ? Container(
              //               child: Center(
              //                 child: Text("No destination to show"),
              //               ),
              //             )
              //           : Container(
              //               height: 210,
              //               padding: EdgeInsets.symmetric(vertical: 8),
              //               color: backgroundgrey,
              //               width: MediaQuery.of(context).size.width,
              //               child: ListView.builder(
              //                   itemCount: destinationModel!.data!.length,
              //                   shrinkWrap: true,
              //                   scrollDirection: Axis.horizontal,
              //                   itemBuilder: (c, i) {
              //                     return InkWell(
              //                       onTap: () {
              //                         Navigator.push(
              //                             context,
              //                             MaterialPageRoute(
              //                                 builder: (context) =>
              //                                     ViewCategory(
              //                                       fromSeller: false,
              //                                       cid: destinationModel!
              //                                           .data![i].id,
              //                                     )));
              //                         // Navigator.push(context, MaterialPageRoute(builder: (context) =>  ViewCategory(fromSeller: false, cid: destinationModel!.data![i].id,vid: ,)));
              //                       },
              //                       child: Container(
              //                         width: 150,
              //                         margin: EdgeInsets.only(right: 10),
              //                         child: Card(
              //                           color: appColorWhite,
              //                           elevation: 1,
              //                           borderOnForeground: false,
              //                           child: Column(
              //                             crossAxisAlignment:
              //                                 CrossAxisAlignment.start,
              //                             children: [
              //                               Container(
              //                                 height: 100,
              //                                 width: 150,
              //                                 child: Image.network(
              //                                   "${destinationModel!.data![i].image}",
              //                                   fit: BoxFit.fill,
              //                                 ),
              //                               ),
              //                               Padding(
              //                                 padding: EdgeInsets.symmetric(
              //                                     horizontal: 3),
              //                                 child: Text(
              //                                   "${destinationModel!.data![i].name}",
              //                                   style: TextStyle(
              //                                       color: appColorBlack,
              //                                       fontWeight: FontWeight.bold,
              //                                       fontSize: 16),
              //                                 ),
              //                               ),
              //                               SizedBox(
              //                                 height: 4,
              //                               ),
              //                               Padding(
              //                                 padding: EdgeInsets.symmetric(
              //                                     horizontal: 3),
              //                                 child: Text(
              //                                   "${destinationModel!.data![i].description}",
              //                                   style: TextStyle(
              //                                       height: 1.1,
              //                                       color: appColorBlack
              //                                           .withOpacity(0.5),
              //                                       fontSize: 13),
              //                                   maxLines: 2,
              //                                 ),
              //                               ),
              //                               SizedBox(
              //                                 height: 3,
              //                               ),
              //                               Divider(
              //                                 height: 1,
              //                               ),
              //                               SizedBox(
              //                                 height: 2,
              //                               ),
              //                               Padding(
              //                                 padding: EdgeInsets.only(left: 3),
              //                                 child: Row(
              //                                   crossAxisAlignment:
              //                                       CrossAxisAlignment.start,
              //                                   children: [
              //                                     Text(
              //                                       "View More",
              //                                       style: TextStyle(
              //                                           color: backgroundblack,
              //                                           fontWeight:
              //                                               FontWeight.w600,
              //                                           fontSize: 13),
              //                                     ),
              //                                     SizedBox(
              //                                       width: 5,
              //                                     ),
              //                                     Icon(
              //                                       Icons.arrow_forward_rounded,
              //                                       color: backgroundblack,
              //                                       size: 20,
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                       ),
              //                     );
              //                   }),
              //             ),
              //     ],
              //   ),
              // ),
              // Container(height: 10),
              // bestSellerWidget(),
              // collectionWidget1(),
              // homelat != 0
              //     ? MapPage(
              //   false,
              //   driveList: [],
              //   live: false,
              //   SOURCE_LOCATION: LatLng(latitude, longitude),
              // )
                  //: Center(child: CircularProgressIndicator()),
            // homeLong  == null || homelat == null ? Center(child: CircularProgressIndicator(),)  : Container(
            //     height: 250,
            //     margin: EdgeInsets.symmetric(horizontal: 10),
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(12)
            //     ),
            //     child: GoogleMap(
            //       myLocationEnabled: true,
            //       myLocationButtonEnabled: true,
            //       compassEnabled: true,
            //       mapType: MapType.normal,
            //       initialCameraPosition: _currentPosition,
            //       onMapCreated: (GoogleMapController controller) {
            //         _controller1.complete();
            //       },
            //     ),
            //   ),
            //
              offerWidget(),
            ],
          ),
        ),
      ),

      bottomSheet:
      // selectedIdList.length == 0 ? SizedBox.shrink()  :  Align(
      //   alignment: Alignment.center,
      //   child: InkWell(
      //     onTap: (){
      //       Navigator.push(context, MaterialPageRoute(builder: (context) => NewSubCategoryScreen(idList: selectedIdList,)));
      //     },
      //     child:
      //     Container(
      //       height: 35,
      //       width: MediaQuery.of(context).size.width/2,
      //       alignment: Alignment.center,
      //       decoration: BoxDecoration(
      //           color: backgroundblack,
      //           borderRadius: BorderRadius.circular(6)
      //       ),
      //       child: Text("${getTranslated(context, 'sellIt')}",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500),),
      //     ),
      //   ),
      // ),
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          selectedIdList.length == 0 ? SizedBox.shrink()  : Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewSubCategoryScreen(idList: selectedIdList,)));
              },
              child:
              Container(
                height: 45,
                margin: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: backgroundblack, borderRadius: BorderRadius.circular(6)),
                child: Text(
                  "${getTranslated(context, 'sellIt')}",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),


    );
  }

  getDrawer() {
    print("checking user pic ${userPic}");
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
                userPic == null || userPic == ""
                    ? CircleAvatar(
                        backgroundColor: appColorWhite,
                        radius: 40,
                        child: Icon(
                          Icons.person,
                          color: appColorBlack,
                        ),
                      )
                    : CircleAvatar(
                        radius: 40,
                        backgroundColor: appColorWhite,
                        backgroundImage: NetworkImage(userPic),
                      ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      // Text(
                      //   "$userName",
                      //   style: TextStyle(fontSize: 18, color: appColorWhite),
                      // ),
                      // Text(
                      //   "$userEmail",
                      //   style: TextStyle(color: appColorWhite),
                      // ),
                      Text(
                        "$perMobile",
                        style: TextStyle(color: appColorWhite),
                      ),
                    ],
                  ),
                ),
                // SizedBox(width: 10,),
                // Expanded(child: Icon(Icons.edit,color: Colors.white,)),
              ],
            ),
          ), //DrawerHeader
          ListTile(
            leading: const Icon(
              Icons.home,
              color: backgroundblack,
            ),
            title: const Text(' Home '),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TabbarScreen()),
              );
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
          ListTile(
            leading: const Icon(
              Icons.privacy_tip_rounded,
              color: backgroundblack,
            ),
            title: const Text(' Privacy Policy '),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.privacy_tip_rounded,
              color: backgroundblack,
            ),
            title: const Text(' Privacy Policy '),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
              );
            },
          ),
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
          ListTile(
            leading: const Icon(
              Icons.list_alt,
              color: backgroundblack,
            ),
            title: const Text(' Terms & Condition '),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TermsConditionScreen()),
              );
            },
          ),

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
            title: const Text(' FAQ '),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FaqScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: backgroundblack,
            ),
            title: const Text('LogOut'),
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
          ),
        ],
      ),
    );
  }

  Widget applogo() {
    return Column(
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 50,
        ),
        SizedBox(
          height: 10,
        ),
        Text(appName,
            style: TextStyle(
                color: appColorBlack,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                fontStyle: FontStyle.italic)),
        SizedBox(
          height: 5,
        ),
        Text('Your Hygiene App',
            style: TextStyle(
              color: appColorBlack,
              fontSize: 12,
            )),
      ],
    );
  }

  Widget servicesWidget() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: appColorWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                color: appColorOrange,
                size: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  _currentAddress != null ? _currentAddress! : "please wait..",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 12),
                ),
              ),
              Container(
                width: 5,
              ),
            ],
          ),
        ),
        Container(
          color: backgroundgrey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10),
                Text(
                  "Services",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Making Life easy",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                Container(height: 10),
                Container(height: 280, child: serviceWidget()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget serviceWidget() {
    return sortingModel == null
        ? Center(
            child: Image.asset("assets/images/loader1.gif"),
          )
        : sortingModel!.restaurants!.length > 0
            ? ListView.builder(
                padding: EdgeInsets.only(
                  bottom: 10,
                  top: 10,
                ),
                itemCount: sortingModel!.restaurants!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (
                  context,
                  int index,
                ) {
                  return InkWell(
                    onTap: () {
                      print(
                          "first here ${sortingModel!.restaurants![index].resId}");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(
                                  resId:
                                      sortingModel!.restaurants![index].resId,
                                )),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 110,
                                  width: 200,
                                  child: Carousel(
                                    images: sortingModel!
                                        .restaurants![index].logo!
                                        .map((it) {
                                      return Container(
                                        height: 110,
                                        width: 170,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8)),
                                          child: CachedNetworkImage(
                                            imageUrl: it,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                Center(
                                              child: Container(
                                                height: 110,
                                                width: 100,
                                                // margin: EdgeInsets.all(70.0),
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2.0,
                                                  valueColor:
                                                      new AlwaysStoppedAnimation<
                                                          Color>(appColorGreen),
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    showIndicator: true,
                                    dotBgColor: Colors.transparent,
                                    borderRadius: false,
                                    autoplay: false,
                                    dotSize: 4.0,
                                    dotSpacing: 15.0,
                                  ),
                                ),
                                // Container(
                                //   height: 100,
                                //    width: 170,
                                //   decoration: BoxDecoration(
                                //     color: Colors.black45,
                                //     borderRadius: BorderRadius.circular(10),
                                //   ),
                                //   child: ClipRRect(
                                //     borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                //     child: Image.network("${sortingModel!
                                //         .restaurants![index].logo![0] }",fit: BoxFit.fill,),
                                //   ),
                                // ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, top: 5, right: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        child: Text(
                                          sortingModel!.restaurants![index]
                                                  .resName![0]
                                                  .toUpperCase() +
                                              sortingModel!
                                                  .restaurants![index].resName!
                                                  .substring(1),
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: appColorBlack,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        "${sortingModel!.restaurants![index].cityName}",
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: appColorBlack,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(height: 5),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, bottom: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Container(
                                      //   width: 130,
                                      //   child: Text(
                                      //     sortingModel!.restaurants![index].resDesc!,
                                      //     maxLines: 1,
                                      //     style: TextStyle(
                                      //         color: appColorBlack,
                                      //         fontSize: 12,
                                      //         height: 1.2,
                                      //         fontWeight: FontWeight.normal),
                                      //   ),
                                      // ),
                                      // SizedBox(height: 3,),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "₹" +
                                                sortingModel!
                                                    .restaurants![index].price!,
                                            style: TextStyle(
                                                color: appColorBlack,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          RatingBar.builder(
                                            initialRating: sortingModel!
                                                        .restaurants![index]
                                                        .resRating ==
                                                    ""
                                                ? 0.0
                                                : double.parse(sortingModel!
                                                    .restaurants![index]
                                                    .resRating
                                                    .toString()),
                                            minRating: 0,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 15,
                                            ignoreGestures: true,
                                            unratedColor: Colors.grey,
                                            itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: appColorOrange),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ],
                                      ),
                                      // InkWell(
                                      //   onTap: () {},
                                      //   child: Align(
                                      //       alignment: Alignment.center,
                                      //       child: Text(
                                      //         "Book Service",
                                      //         style: TextStyle(
                                      //             color: backgroundblack,
                                      //             fontWeight: FontWeight.w600),
                                      //         textAlign: TextAlign.center,
                                      //       )),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Stack(
                      //    alignment: Alignment.topCenter,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.only(top: 30),
                      //       child: Card(
                      //         elevation: 5,
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(20),
                      //         ),
                      //         child: Container(
                      //           width: 170,
                      //           child: Padding(
                      //             padding:  EdgeInsets.only(
                      //                 bottom: 15, left: 15, right: 15),
                      //             child: Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               mainAxisAlignment: MainAxisAlignment.end,
                      //               children: [
                      //                 Container(
                      //                   height: 100,
                      //                   width: 140,
                      //                   alignment: Alignment.topCenter,
                      //                   decoration: BoxDecoration(
                      //                     color: Colors.black45,
                      //                     borderRadius: BorderRadius.circular(10),
                      //                     image: DecorationImage(
                      //                       image: NetworkImage(sortingModel!
                      //                           .restaurants![index].allImage![0]),
                      //                       fit: BoxFit.cover,
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 Text(
                      //                   sortingModel!.restaurants![index].resName!,
                      //                   maxLines: 1,
                      //                   style: TextStyle(
                      //                       color: appColorBlack,
                      //                       fontSize: 14,
                      //                       fontWeight: FontWeight.bold),
                      //                 ),
                      //                 Container(height: 8),
                      //                 Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceBetween,
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.end,
                      //                   children: [
                      //                     Column(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       children: [
                      //                         Container(
                      //                           width: 130,
                      //                           child: Text(
                      //                             sortingModel!.restaurants![index].resDesc!,
                      //                             maxLines: 2,
                      //                             style: TextStyle(
                      //                                 color: appColorBlack,
                      //                                 fontSize: 12,
                      //                                 height: 1.2,
                      //                                 fontWeight: FontWeight.normal),
                      //                           ),
                      //                         ),
                      //                         Text(
                      //                           "₹" +
                      //                               sortingModel!
                      //                                   .restaurants![index]
                      //                                   .price!,
                      //                           style: TextStyle(
                      //                               color: appColorBlack,
                      //                               fontSize: 16,
                      //                               fontWeight:
                      //                                   FontWeight.bold),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     // Container(
                      //     //   height: 100,
                      //     //   width: 140,
                      //     //   alignment: Alignment.topCenter,
                      //     //   decoration: BoxDecoration(
                      //     //     color: Colors.black45,
                      //     //     borderRadius: BorderRadius.circular(10),
                      //     //     image: DecorationImage(
                      //     //       image: NetworkImage(sortingModel!
                      //     //           .restaurants![index].allImage![0]),
                      //     //       fit: BoxFit.cover,
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //   ],
                      // ),
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  "Don't have any services",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              );
  }

  Widget _banner(BuildContext context) {
    return bannerModal == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ImageSlideshow(
            width: MediaQuery.of(context).size.width -40,
            height: 180,
            initialPage: 0,
            indicatorColor: Colors.black,
            indicatorBackgroundColor: Colors.grey,
            children: bannerModal!.banners!
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal:5),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context) => OfferPage()));
                          },
                          child: CachedNetworkImage(
                            imageUrl: item,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: Container(
                                margin: EdgeInsets.all(70.0),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              height: 5,
                              width: 5,
                              child: Icon(
                                Icons.error,
                              ),
                            ),
                          ),
                        )
                    ),
                  ),
                )
                .toList(),
            onPageChanged: (value) {
              print('Page changed: $value');
            },
          );
  }

  Widget collectionWidget() {
    return Column(
      children: [
        Container(
          color: backgroundgrey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10),
                Text(
                  "${getTranslated(context, 'categories')}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // Text(
                //   "Hygiene & Safety Store",
                //   style: TextStyle(
                //       fontSize: 14,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.grey),
                // ),
                Container(height: 10),
                Container(
                    height: collectionModal == null ? 150 : 100,
                    child: collectionData()),
                Container(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget collectionData() {
    return masterData == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : masterData!.data!.length > 0
            ? ListView.builder(
                padding: EdgeInsets.only(
                  bottom: 10,
                  top: 0,
                ),
                itemCount: masterData!.data!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (
                  context,
                  int index,
                ) {
                  return  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubCategoryScreen(
                              id: masterData!.data![index].id!,
                              name: masterData!.data![index].categories,
                              image: masterData!.data![index].image,
                              description: "",
                              selectedValue1: masterData!.data![index].id,
                              selectedValueName1: masterData!.data![index].categories,
                            )
                          // ViewCategory(id: categories.id!, name: categories.cName!)
                        ),
                      );
                    },
                    child: Container(
                      height: 100,
                      margin: EdgeInsets.only(right: 10, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration:
                            BoxDecoration(
                              // border: Border.all(
                              //   color: backgroundblack,
                              //   width: 5
                              // ),
                                borderRadius: BorderRadius.circular(100)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  "${masterData!.data![index].image}",
                                  fit: BoxFit.fill,
                                )),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${masterData!.data![index].categories}",
                            style: TextStyle(
                                color: appColorBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  );
                    // sortingCard(
                    //   context,masterData!.data![index]);
                },
              )
            : Center(
                child: Text(
                  "No data found",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              );
  }

  Widget collectionData1() {
    return collectionModal == null
        ? Center(
      child: CircularProgressIndicator(),
    )
        : collectionModal!.categories!.length > 0
        ? ListView.builder(
      padding: EdgeInsets.only(
        bottom: 10,
        top: 0,
      ),
      itemCount: collectionModal!.categories!.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (
          context,
          int index,
          ) {
        return  InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SubCategoryScreen(
                    id: collectionModal!.categories![index].id!,
                    name: collectionModal!.categories![index].cName,
                    image: collectionModal!.categories![index].img,
                    description: collectionModal!.categories![index].description,
                    selectedValue1: collectionModal!.categories![index].id,
                    selectedValueName1: collectionModal!.categories![index].cName,
                  )
                // ViewCategory(id: categories.id!, name: categories.cName!)
              ),
            );
          },
          child: Container(
            height: 100,
            margin: EdgeInsets.only(right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration:
                  BoxDecoration(
                    // border: Border.all(
                    //   color: backgroundblack,
                    //   width: 5
                    // ),
                      borderRadius: BorderRadius.circular(100)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        "${collectionModal!.categories![index].img}",
                        fit: BoxFit.fill,
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${collectionModal!.categories![index].cName}",
                  style: TextStyle(
                      color: appColorBlack,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        );
        // sortingCard(
        //   context,masterData!.data![index]);
      },
    )
        : Center(
      child: Text(
        "No data found",
        style: TextStyle(
          color: Colors.white,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
  Widget collectionWidget1() {
    return Column(
      children: [
        Container(
          color: backgroundgrey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10),
                Text(
                  "",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // Text(
                //   "Hygiene & Safety Store",
                //   style: TextStyle(
                //       fontSize: 14,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.grey),
                // ),
                Container(height: 10),
                Container(
                    height: collectionModal == null ? 150 : 100,
                    child: collectionData1()),
                Container(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget sortingCard(BuildContext context, Categories categories) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SubCategoryScreen(
                    id: categories.id!,
                    name: categories.cName!,
                    image: categories.img,
                    description: categories.description,
                  )
              // ViewCategory(id: categories.id!, name: categories.cName!)
              ),
        );
      },
      child: Container(
        height: 100,
        margin: EdgeInsets.only(right: 10, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration:
                  BoxDecoration(
                    // border: Border.all(
                    //   color: backgroundblack,
                    //   width: 5
                    // ),
                      borderRadius: BorderRadius.circular(100)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    "${categories.img!}",
                    fit: BoxFit.fill,
                  )),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              categories.cName!,
              style: TextStyle(
                  color: appColorBlack,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
    //   Padding(
    //   padding: const EdgeInsets.only(right: 15),
    //   child: InkWell(
    //     onTap: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) =>
    //                 SubCategoryScreen(id: categories.id!, name: categories.cName!,image: categories.img,description: categories.description,)
    //                 // ViewCategory(id: categories.id!, name: categories.cName!)
    //         ),
    //       );
    //     },
    //     child: Card(
    //       elevation: 3,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(100),
    //       ),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Container(
    //             width: 80,
    //             height: 60,
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(5),
    //               child: Image.network(
    //                 categories.img!,
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //           ),
    //           Container(height: 10),
    //           Text(
    //             categories.cName!,
    //             style: TextStyle(
    //                 color: appColorBlack,
    //                 fontSize: 16,
    //                 fontWeight: FontWeight.bold),
    //             maxLines: 1,
    //           ),
    //
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

    Widget offerWidget() {
      return Container(
        color: backgroundgrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "${getTranslated(context, 'selectScrap')}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(height: 10),
           collectionModal == null ? Center(child: Text("${getTranslated(context, 'noDataToShow')}"),) : Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: collectionModal!.categories!.length == 0 ? Container(
                height: 120,
                child: Center(child: Text("${getTranslated(context, 'noDataToShow')}"),),) : GridView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: collectionModal!.categories!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.5,
                  mainAxisSpacing: 5.0,
                    childAspectRatio: 3/3.5,
              ), itemBuilder: (context,index){
                return  InkWell(
                  onTap: (){
                    print("selected values here ${collectionModal!.categories![index].id}");
                    if(selectedIdList.contains(collectionModal!.categories![index].id)){
                      selectedIdList.remove(collectionModal!.categories![index].id);
                      print("selected id list here ${selectedIdList}");
                      for(var i=0;i<selectedIdList.length; i++){
                        print("oo ${selectedIdList[i]}");
                      }
                    }
                    else {
                      selectedIdList.add(collectionModal!.categories![index].id.toString());
                      print("second selected selected  id list here ${selectedIdList}");
                      for(var i=0;i<selectedIdList.length; i++){
                        print("oo ${selectedIdList[i]}");
                      }
                    }
                    setState(() {

                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Stack(
                            children: [
                              Container(
                                  height:80,
                                  width: MediaQuery.of(context).size.width,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.only(topLeft:Radius.circular(6), topRight: Radius.circular(6)),
                                      child: Image.network("${collectionModal!.categories![index].img}",fit: BoxFit.fill,))),
                              selectedIdList.contains(collectionModal!.categories![index].id)  ?  Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 3,right: 3),
                                  child: Container(
                                   height: 28,
                                      width: 28,
                                    padding: EdgeInsets.all(1),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: backgroundblack
                                    ),
                                    child: Icon(Icons.check)
                                  ),
                                ),
                              ) : SizedBox.shrink(),
                            ],
                          ),
                        ),
                        Container(height: 5,),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 3),
                        //   child: Text("${collectionModal!.categories![index].cName}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                        // ),
                        Text("${collectionModal!.categories![index].cName}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),maxLines: 1,),

                      ],
                    ),
                  ),
                );
              })
            ),
            Container(height: 10),
         // selectedIdList.length == 0 ? SizedBox.shrink()  :  Align(
         //      alignment: Alignment.center,
         //      child: InkWell(
         //        onTap: (){
         //          Navigator.push(context, MaterialPageRoute(builder: (context) => NewSubCategoryScreen(idList: selectedIdList,)));
         //        },
         //        child:
         //        Container(
         //          height: 35,
         //          width: MediaQuery.of(context).size.width/2,
         //          alignment: Alignment.center,
         //          decoration: BoxDecoration(
         //            color: backgroundblack,
         //            borderRadius: BorderRadius.circular(6)
         //          ),
         //          child: Text("${getTranslated(context, 'sellIt')}",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500),),
         //        ),
         //      ),
         //    ),
          ],
        ),
      );
  }

  Widget bestSellerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Best Scrap Dealers",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "check out our best dealers",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
        Container(height: 30),
        Container(
          color: backgroundgrey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10),
                /*Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchProduct(
                                      back: true,
                                    )),
                          );
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                              color: appColorBlack,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),*/
                Container(height: 200, child: bestSellerItems()),
                Container(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget bestSellerItems() {
    return allProduct == null
        ? Center(
            child: Image.asset("assets/images/loader1.gif"),
          )
        : allProduct!.setting!.length > 0
            ? ListView.builder(
                padding: EdgeInsets.only(bottom: 10),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: allProduct!.setting!.length,
                itemBuilder: (
                  context,
                  int index,
                ) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ViewCategory(
                            vid: allProduct!.setting![index].id,
                            name: allProduct!.setting![index].uname,
                            fromSeller: true,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          width: 180,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 15, left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 140,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          allProduct!
                                              .setting![index].profileImage!,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(height: 5),
                                Text(
                                  "${allProduct!.setting![index].fname} ${allProduct!.setting![index].lname}",
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: appColorBlack,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(height: 5),
                                /*Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "₹" +
                                              allProduct!.setting![index]
                                                  .productPrice!,
                                          style: TextStyle(
                                              color: appColorBlack,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: appColorOrange,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.shopping_bag_outlined,
                                          color: appColorWhite,
                                          size: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                ),*/
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  "Don't have any near by service providers",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              );
  }
}
