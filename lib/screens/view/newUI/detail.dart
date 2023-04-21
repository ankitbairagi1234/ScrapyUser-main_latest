import 'dart:convert';
import 'dart:math';
import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:dio/dio.dart';
import 'package:ez/screens/view/models/CoupanModel.dart';
import 'package:ez/screens/view/models/getServiceDetails_modal.dart';
import 'package:ez/screens/view/models/likeService_modal.dart';
import 'package:ez/screens/view/models/unLikeService_modal.dart';
import 'package:ez/screens/view/newUI/bookingSuccess.dart';
import 'package:ez/screens/view/newUI/checkoutService.dart';
import 'package:ez/screens/view/newUI/manage_address.dart';
import 'package:ez/screens/view/newUI/viewImages.dart';
import 'package:ez/screens/view/newUI/wishList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ez/constant/global.dart';
import 'package:ez/constant/sizeconfig.dart';
import 'package:ez/screens/view/newUI/ratingService.dart';
import 'package:intl/intl.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
// import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:time_picker_widget/time_picker_widget.dart';

import '../models/address_model.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  String? resId;

  DetailScreen({
    this.resId,
  });
  @override
  _OrderSuccessWidgetState createState() => _OrderSuccessWidgetState();
}

class _OrderSuccessWidgetState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  Position? currentLocation;
  ScrollController? _scrollController;
  bool? fixedScroll;
  String selectedType = '';
  String selectedTypePrice = '';
  String selectedTypeSize = '';
  String addId = '';
  TextEditingController addressController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController coupanCodeController = TextEditingController();

  bool tab1 = true;
  bool tab2 = false;
  bool tab3 = false;

  String _dateValue = '';
  String _timeValue = '';
  String _pickedLocation = '';
  bool one = false;
  bool two = false;
  bool three = false;
  bool four = false;
  bool isLoading = false;
  final dio = new Dio();
  var dateFormate;

  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        //firstDate: DateTime.now().subtract(Duration(days: 1)),
        // lastDate: new DateTime(2022),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: Colors.black, //Head background
                accentColor: Colors.black,
                colorScheme:
                    ColorScheme.light(primary: const Color(0xFFEB6C67)),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null)
      setState(() {
        String yourDate = picked.toString();
        _dateValue = convertDateTimeDisplay(yourDate);
        print(_dateValue);
        dateFormate =
            DateFormat("dd/MM/yyyy").format(DateTime.parse(_dateValue ?? ""));
      });
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  //Razorpay//>>>>>>>>>>>>>>>>

  String orderid = '';

  bookApiCall(String txnId, String paymentType) async {
    var uri = Uri.parse("${baseUrl()}/booking");

    var request = new http.MultipartRequest("POST", uri);

    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);

    request.fields['res_id'] = restaurants!.restaurant!.resId!;
    request.fields['user_id'] = userID;
    request.fields['date'] = _dateValue ?? "";
    request.fields['slot'] = selectedTime!.format(context).toString() ?? "";
    request.fields['size'] = selectedTypeSize ?? "";
    request.fields['address'] = _pickedLocation.toString();
    request.fields['payment_method'] = "";
    request.fields['address_id'] = addId ?? "";
    request.fields['note'] = noteController.text ?? "";
    request.fields['sub_total'] = intialPrice ?? "";
    request.fields['discount'] = priceOffValue.toString();
    request.fields['addons'] = addonPriceValue.toString();
    request.fields['total'] = totalPrice.toString();
    request.fields['addon_services'] = addonServiceValue.toString();

// send
    var response = await request.send();

    print(response.statusCode);
    print(request);
    print("fileds are ${request.fields}");
    if (response.statusCode == 200) {
      // Navigator.of(context).pop();
      String responseData = await response.stream
          .transform(utf8.decoder)
          .join(); // decodes on response data using UTF8.decoder
      Map data = json.decode(responseData);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (Context) => BookingSccess(
                    name: restaurants!.restaurant!.resName,
                    image: restaurants!.restaurant!.logo![0],
                    location: _pickedLocation,
                    date: _dateValue,
                    time: selectedTime!.format(context).toString(),
                  )));
      setState(() {
        // if (data["response_code"] == "1") {
        //   successPaymentApiCall(txnId, data["booking"]["booking_id"].toString());
        // } else {
        //   bookDialog(
        //     context,
        //     "something went wrong. Try again",
        //     button: true,
        //   );
        // }
      });
    }
  }

  @override
  void initState() {
    _getProductDetails();
    _scrollController = ScrollController();
    idList.clear();
    super.initState();
  }

  TimeOfDay? selectedTime;
  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        useRootNavigator: true,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(primary: backgroundblack),
                buttonTheme: ButtonThemeData(
                    colorScheme: ColorScheme.light(primary: backgroundblack))),
            child: MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: false),
                child: child!),
          );
        });
    // showCustomTimePicker(
    //     context: context,
    //     // It is a must if you provide selectableTimePredicate
    //     onFailValidation: (context) => print('Unavailable selection'),
    //     initialTime: TimeOfDay(hour: 12, minute: 0),
    //     selectableTimePredicate: (time) =>
    //     time!.hour > 1 &&
    //         time.hour < 14 &&
    //         time.minute % 10 == 0).then((time) =>
    //     setState(() => selectedTime = time?.format(context)));
    // if(timeOfDay != null){
    //   selectedTime  = timeOfDay.format(context);
    // }
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay.replacing(hour: timeOfDay.hourOfPeriod);
      });
    }
    var per = selectedTime!.period.toString().split(".");
    print(
        "selected time here ${selectedTime!.format(context).toString()} and ${per[1]}");
  }

  GetServiceDetailsModal? restaurants;
  var addOns = [];
  var addOnService = [];

  refresh() {
    _getProductDetails();
  }

  String? intialPrice;
  List<int> idList = [];
  _getProductDetails() async {
    print("it is working here");
    var uri = Uri.parse('${baseUrl()}/get_res_details');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields['res_id'] = widget.resId!;
    print(request);
    print(request.fields);
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    if (mounted) {
      setState(() {
        restaurants = GetServiceDetailsModal.fromJson(userData);
        intialPrice = restaurants!.restaurant!.price;
      });

      // addOns.add(restaurants!.restaurant!.type);
    }

    print(responseData);
  }

  int? finalPrice;
  int? totalPrice;
  String? resPrice;
  addPriceAdded(int tPrice) {
    resPrice = restaurants!.restaurant!.price;
    if (tPrice == null || tPrice == "") {
      totalPrice = int.parse(restaurants!.restaurant!.price.toString()) + 0;
      finalPrice = int.parse(restaurants!.restaurant!.price.toString()) + 0;
    } else {
      totalPrice =
          int.parse(restaurants!.restaurant!.price.toString()) + tPrice;
      finalPrice =
          int.parse(restaurants!.restaurant!.price.toString()) + tPrice;
    }
    restaurants!.restaurant!.price = totalPrice.toString();
    setState(() {});
  }

  String? addonPriceValue;
  String? addonServiceValue;
  removePriceAdded(int tPrice) {
    resPrice = restaurants!.restaurant!.price;
    if (tPrice == null || tPrice == "") {
      totalPrice = int.parse(restaurants!.restaurant!.price.toString()) - 0;
    } else {
      totalPrice =
          int.parse(restaurants!.restaurant!.price.toString()) - tPrice;
    }
    restaurants!.restaurant!.price = totalPrice.toString();
    setState(() {});
  }

  var result;
  String? priceOffValue;
  Future getUserCurrentLocation() async {
    await Geolocator.getCurrentPosition().then((position) {
      if (mounted)
        setState(() {
          currentLocation = position;
        });
    });
  }

  String? discountPrice;
  bool? isSelected;
  int? currentIndex;

  applyCode() async {
    print("oooo");
    var headers = {'Cookie': 'ci_session=59dd1a84elpmmaiabkhq5mujfuf1f0ja'};
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://developmentalphawizz.com/antsnest/api/check_promo_code'));
    request.fields.addAll({
      'code': '${coupanCodeController.text}',
      'amount': '${restaurants!.restaurant!.price}'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("lll ${response.statusCode}");
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      print("fine here ${finalResponse}");
      var jsonResponse = CoupanModel.fromJson(json.decode(finalResponse));
      print("ok now ${jsonResponse.msg} and ${jsonResponse.data}");
      setState(() {
        priceOffValue = jsonResponse.data!.discountAmount.toString();
        discountPrice = jsonResponse.data!.amountAfterDiscount.toString();
        // restaurants!.restaurant!.price = discountPrice;
        restaurants!.restaurant!.price = discountPrice;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
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
        backgroundColor: backgroundblack,
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        // title: Text(
        //   'Categories',
        //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        // ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          restaurants == null
              ? Center(child: Image.asset("assets/images/loader1.gif"))
              : restaurants == ""
                  ? Container(
                      child: Center(
                        child: Text("No service to show"),
                      ),
                    )
                  : _projectInfo(),
          // isLoading == true
          //     ? Center(child: CupertinoActivityIndicator())
          //     : Container()
        ],
      ),
    );
  }

  Widget _projectInfo() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: <Widget>[
              // ClipRRect(
              //   borderRadius: BorderRadius.only(
              //       bottomLeft: Radius.circular(30),
              //       bottomRight: Radius.circular(30)),
              //   child: CachedNetworkImage(
              //     imageUrl: restaurants!.restaurant!.logo.toString(),
              //     imageBuilder: (context, imageProvider) => Container(
              //       decoration: BoxDecoration(
              //         image: DecorationImage(
              //           image: imageProvider,
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     ),
              //     placeholder: (context, url) => Center(
              //       child: Container(
              //         height: 100,
              //         width: 100,
              //         // margin: EdgeInsets.all(70.0),
              //         child: CircularProgressIndicator(
              //           strokeWidth: 2.0,
              //           valueColor: new AlwaysStoppedAnimation<Color>(
              //               appColorGreen),
              //         ),
              //       ),
              //     ),
              //     errorWidget: (context, url, error) => Icon(Icons.error),
              //     fit: BoxFit.cover,
              //   ),
              // ),

              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: Carousel(
                  images: restaurants!.restaurant!.logo!.map((it) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        child: CachedNetworkImage(
                          imageUrl: it,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Center(
                            child: Container(
                              height: 100,
                              width: 100,
                              // margin: EdgeInsets.all(70.0),
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    appColorGreen),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
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
                  dotSize: 5.0,
                  dotSpacing: 15.0,
                ),
              ),
              // Container(
              //   width: double.infinity,
              //   height: double.infinity,
              //   decoration: BoxDecoration(),
              //   child: Card(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.only(
              //           bottomLeft: Radius.circular(30),
              //           bottomRight: Radius.circular(30)),
              //     ),
              //     margin: EdgeInsets.zero,
              //     color: Colors.black45.withOpacity(0.1),
              //   ),
              // ),
              //
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       restaurants!.restaurant!.resName!,
              //       style: TextStyle(
              //           fontSize: 25,
              //           color: appColorWhite,
              //           fontWeight: FontWeight.bold),
              //     ),
              //     Container(
              //       height: 10,
              //     ),
              //     Container(
              //       height: 4,
              //       width: 100,
              //       decoration: BoxDecoration(
              //           color: appColorWhite,
              //           borderRadius:
              //               BorderRadius.all(Radius.circular(30))),
              //     ),
              //   ],
              // ),
              Positioned(
                bottom: 1,
                child: Padding(
                  padding: EdgeInsets.only(left: 15, bottom: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurants!.restaurant!.resName!,
                        style: TextStyle(
                            fontSize: 25,
                            color: appColorWhite,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 10,
                      ),
                      Container(
                        height: 4,
                        width: 100,
                        decoration: BoxDecoration(
                            color: appColorWhite,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                      ),
                    ],
                  ),
                ),
              ),
              // Positioned(
              //   bottom: 15,
              //   right: 10,
              //   child: Container(
              //     width: 40,
              //     child: likedService.contains(restaurants!.restaurant!.resId)
              //         ? Padding(
              //             padding: const EdgeInsets.all(4),
              //             child: RawMaterialButton(
              //               shape: CircleBorder(),
              //               padding: const EdgeInsets.all(0),
              //               fillColor: Colors.white54,
              //               splashColor: Colors.grey[400],
              //               child: Icon(
              //                 Icons.favorite,
              //                 color: Colors.red,
              //                 size: 20,
              //               ),
              //               onPressed: () {
              //                 unLikeServiceFunction(
              //                     restaurants!.restaurant!.resId!, userID);
              //               },
              //             ),
              //           )
              //         : Padding(
              //             padding: const EdgeInsets.all(4),
              //             child: RawMaterialButton(
              //               shape: CircleBorder(),
              //               padding: const EdgeInsets.all(0),
              //               fillColor: Colors.white54,
              //               splashColor: Colors.grey[400],
              //               child: Icon(
              //                 Icons.favorite_border,
              //                 size: 20,
              //               ),
              //               onPressed: () {
              //                 likeServiceFunction(
              //                     restaurants!.restaurant!.resId!, userID);
              //               },
              //             ),
              //           ),
              //   ),
              // ),
            ],
          ),
          Container(height: 10),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ReviewService(
                      resReview: restaurants!.review!,
                      restID: restaurants!.restaurant!.resId!,
                      restName: restaurants!.restaurant!.resName!,
                      restDesc: restaurants!.restaurant!.resDesc!,
                      resNameU: restaurants!.restaurant!.resNameU!,
                      resWebsite: restaurants!.restaurant!.resWebsite!,
                      resPhone: restaurants!.restaurant!.resPhone!,
                      resAddress: restaurants!.restaurant!.resAddress!,
                      restRatings: restaurants!.restaurant!.resRatings!,
                      images: restaurants!.restaurant!.logo!,
                      refresh: refresh),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Ratings",
                        style: TextStyle(
                          color: appColorBlack,
                          fontSize: 17,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Text(
                        "${restaurants!.restaurant!.cityName.toString()}",
                        style: TextStyle(
                          color: appColorBlack,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: RatingBar.builder(
                    initialRating:
                        restaurants!.restaurant!.resRatings != null &&
                                restaurants!.restaurant!.resRatings!.length > 0
                            ? double.parse(restaurants!.restaurant!.resRatings!)
                            : 0.0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20,
                    ignoreGestures: true,
                    unratedColor: Colors.grey,
                    itemBuilder: (context, _) =>
                        Icon(Icons.star, color: appColorOrange),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
                Container(height: 5),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ReviewService(
                            resReview: restaurants!.review!,
                            restID: restaurants!.restaurant!.resId!,
                            restName: restaurants!.restaurant!.resName!,
                            restDesc: restaurants!.restaurant!.resDesc!,
                            resNameU: restaurants!.restaurant!.resNameU!,
                            resWebsite: restaurants!.restaurant!.resWebsite!,
                            resPhone: restaurants!.restaurant!.resPhone!,
                            resAddress: restaurants!.restaurant!.resAddress!,
                            restRatings: restaurants!.restaurant!.resRatings!,
                            images: restaurants!.restaurant!.logo!,
                            refresh: refresh),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20, top: 8),
                    height: 40,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: backgroundblack,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "Add Review",
                      style: TextStyle(
                          color: appColorWhite,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 0, right: 0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        tab1 = true;
                        tab2 = false;
                        // tab3 = false;
                      });
                    },
                    child: Text(
                      "Description",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: tab1 == true ? appColorBlack : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                // Expanded(
                //   child: InkWell(
                //     onTap: () {
                //       setState(() {
                //         tab1 = false;
                //         tab2 = true;
                //         // tab3 = false;
                //       });
                //     },
                //     child: Text(
                //       "Review",
                //       textAlign: TextAlign.center,
                //       style: TextStyle(
                //         color: tab2 == true ? appColorBlack : Colors.grey,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 17,
                //       ),
                //       overflow: TextOverflow.ellipsis,
                //     ),
                //   ),
                // ),
                // Expanded(
                //   child: InkWell(
                //     onTap: () {
                //       setState(() {
                //         tab1 = false;
                //         tab2 = false;
                //         // tab3 = true;
                //       });
                //     },
                //     child: Text(
                //       "Instruction",
                //       textAlign: TextAlign.center,
                //       style: TextStyle(
                //         color: tab3 == true ? appColorBlack : Colors.grey,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 17,
                //       ),
                //       overflow: TextOverflow.ellipsis,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Container(height: 10),
          Container(
            color: backgroundgrey,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 30, left: 30, right: 30),
              child: tab1 == true
                  ? Text(
                      restaurants!.restaurant!.resDesc!,
                      style: TextStyle(
                        color: appColorBlack,
                      ),
                    )
                  : tab2 == true
                      ? reviewWidget(restaurants!.review!)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: Text(
                                restaurants!.restaurant!.hours!,
                                style: TextStyle(
                                    color: appColorBlack,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: Text(
                                restaurants!.restaurant!.experts!,
                                style: TextStyle(
                                    color: appColorBlack,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
            ),
          ),
          Container(height: 10),
          /*Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Area",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: appColorBlack,
                    fontWeight: FontWeight.normal,
                    fontSize: 17,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: GridView.builder(
                  shrinkWrap: true,
                  //physics: NeverScrollableScrollPhysics(),
                  primary: false,
                  padding: EdgeInsets.all(5),
                  itemCount: restaurants!.restaurant!.type!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 160 / 140,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedType =
                                restaurants!.restaurant!.type![index].type!;
                            selectedTypePrice =
                                restaurants!.restaurant!.type![index].price!;
                            selectedTypeSize =
                                restaurants!.restaurant!.type![index].typeName!;
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: selectedType ==
                                        restaurants!.restaurant!.type![index].type
                                    ? Colors.grey[400]
                                    : appColorWhite,
                                border: Border.all(width: 0.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Center(
                                child: Text(
                              restaurants!.restaurant!.type![index].typeName!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ))),
                      ),
                    );
                  },
                ),
              ),*/
          // Container(height: 10),

          restaurants!.restaurant!.type!.isEmpty
              ? SizedBox.shrink()
              : Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurants!.restaurant!.type!.length,
                      itemBuilder: (c, i) {
                        return InkWell(
                          onTap: () {
                            if (addOns.contains(restaurants!
                                .restaurant!.type![i].type
                                .toString())) {
                              addOns.remove(restaurants!
                                  .restaurant!.type![i].type
                                  .toString());
                              addOnService.remove(restaurants!
                                  .restaurant!.type![i].price
                                  .toString());
                              print("ss ${addOns}");
                              // for(var i=0;i<addOns.length;i++){
                              //   print("eee ${addOns[i].type}");
                              // }

                              int sprice = int.parse(restaurants!
                                  .restaurant!.type![i].price
                                  .toString());
                              removePriceAdded(sprice);

                              setState(() {
                                addonPriceValue = addOnService.join(",");
                                addonServiceValue = addOns.join(",");
                              });
                            } else {
                              addOns.add(restaurants!.restaurant!.type![i].type
                                  .toString());
                              addOnService.add(restaurants!
                                  .restaurant!.type![i].price
                                  .toString());
                              print("ssdss ${addOns}");

                              int sprice = int.parse(restaurants!
                                  .restaurant!.type![i].price
                                  .toString());
                              addPriceAdded(sprice);

                              setState(() {
                                addonPriceValue = addOnService.join(",");
                                addonServiceValue = addOns.join(",");
                              });
                              print("cooma seprare ${addonServiceValue}");
                            }

                            // result = idList.where((element){
                            //   print("ss ${element} and ${i}");
                            //   return element == i;
                            // });
                            // print("result here ${result}");
                            // if(idList.contains(i)){
                            //   print('dd');
                            //  setState(() {
                            //    idList.removeAt(i);
                            //  });
                            // }
                            // else if(!idList.contains(i)){
                            //   print('dss');
                            //   setState(() {
                            //     idList.add(i);
                            //   });
                            //   print('ssdsss ${idList.length}');
                            // }
                            //  for(var i=0;i< idList.length;i++){
                            //    print("mmm ${idList[i]}");
                            //  }
                            // if(result.isEmpty){
                            //   setState(() {
                            //     idList.removeAt(i);
                            //     print("removing");
                            //   });
                            // }
                            // else{
                            //   idList.add(currentIndex.toString());
                            // }
                            // if(idList.where((element) => element == i)){
                            //
                            // }
                            // else{
                            //  setState(() {
                            //    idList.add(currentIndex.toString());
                            //    print("adding");
                            //  });
                            // }
                            print("current index here $currentIndex");
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: 100,
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${restaurants!.restaurant!.type![i].type}"),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            " \u{20B9} ${restaurants!.restaurant!.type![i].price}"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              addOns.contains(restaurants!
                                      .restaurant!.type![i].type
                                      .toString())
                                  ? Positioned(
                                      left: 1,
                                      right: 1,
                                      top: 1,
                                      bottom: 1,
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ))
                                  : SizedBox.shrink(),
                            ],
                          ),
                        );
                      }),
                ),
          Container(
            color: backgroundgrey,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                color: appColorWhite,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(width: 40),
                      Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Column(
                          children: [
                            Text(
                              'One Fair Price :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Container(width: 15),
                      Text(
                        "₹ " + restaurants!.restaurant!.price!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            fontFamily: 'OpenSansBold'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Book your Service',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
            child: InkWell(
              onTap: () {
                _selectDate();
              },
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(Icons.date_range),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: new Text(
                        _dateValue.length > 0 ? dateFormate : "Pick a date",
                        textAlign: TextAlign.start,
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
            child: InkWell(
              onTap: () {
                // openBottmSheet(context);
                _selectTime(context);
              },
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(Icons.timer_sharp),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: new Text(
                        selectedTime == null
                            ? "Choose a time"
                            : "${selectedTime!.format(context)}",
                        textAlign: TextAlign.start,
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
          // Container(height: 20),
          //location
          _pickedLocation != ''
              ? Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: InkWell(
                    onTap: () async {
                      // _getLocation();
                      var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ManageAddress(
                                    resid: widget.resId,
                                    aId: addId,
                                  )));
                      print("address id ${result}");
                      if (result != '') {
                        setState(() {
                          addId = result;
                          getAddress(result);
                        });
                      }
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(Icons.location_on_outlined),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: new Text(
                              _pickedLocation.length > 0
                                  ? _pickedLocation
                                  : "find your location",
                              maxLines: 2,
                              textAlign: TextAlign.start,
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                )
              : InkWell(
                  onTap: () async {
                    var result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManageAddress(
                                  resid: widget.resId,
                                  aId: addId,
                                )));
                    print("gibvkjbdgv === $result");
                    if (result != '') {
                      setState(() {
                        addId = result;
                        getAddress(result);
                      });
                    }
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5, color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Icon(Icons.location_on_outlined),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: new Text(
                                  _pickedLocation.length > 0
                                      ? _pickedLocation
                                      : "find your location",
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                ),
                              )),
                            ],
                          ),
                        )
                        // Container(
                        //   decoration: BoxDecoration(
                        //       color: backgroundblack,
                        //       border: Border.all(color: Colors.grey),
                        //       borderRadius:
                        //           BorderRadius.all(Radius.circular(15))),
                        //   height: 50.0,
                        //   // ignore: deprecated_member_use
                        //   child: Center(
                        //     child: Stack(
                        //       children: [
                        //         Align(
                        //           alignment: Alignment.center,
                        //           child: Text(
                        //             "SELECT ADDRESS",
                        //             textAlign: TextAlign.center,
                        //             style: TextStyle(
                        //                 color: appColorWhite,
                        //                 fontWeight: FontWeight.bold,
                        //                 fontSize: 15),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // )

                        ),
                  ),
                ),

          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(Icons.note_alt),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextField(
                      controller: noteController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Enter note"),
                    ),
                  )),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
          //   child: Container(
          //     height: 60,
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //       border: Border.all(width: 0.5, color: Colors.grey),
          //       borderRadius: BorderRadius.all(Radius.circular(10)),
          //       color: Colors.white,
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: <Widget>[
          //         Padding(
          //           padding: const EdgeInsets.only(left: 10),
          //           child: Icon(Icons.local_offer),
          //         ),
          //         Expanded(
          //             child: Padding(
          //           padding: const EdgeInsets.only(left: 20),
          //           child: TextField(
          //             controller: coupanCodeController,
          //             decoration: InputDecoration(
          //                 border: InputBorder.none,
          //                 hintText: "Enter Coupan code"),
          //           ),
          //         )),
          //       ],
          //     ),
          //   ),
          // ),
          Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 30, top: 8),
                child: InkWell(
                    onTap: () {
                      applyCode();
                      print("working");
                    },
                    child: Text(
                      "Apply Code",
                    )),
              )),
          /*Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                child: TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                      hintText: "Enter Address",
                      hintStyle:
                          TextStyle(color: Colors.grey[500], fontSize: 13),
                      alignLabelWithHint: true,
                      fillColor: appColorWhite,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(
                        Icons.location_on_outlined,
                        color: appColorBlack,
                      )),
                  // scrollPadding: EdgeInsets.all(20.0),
                  // keyboardType: TextInputType.multiline,
                  // maxLines: 99999,
                  style: TextStyle(color: appColorBlack, fontSize: 15),
                  autofocus: false,
                ),
              ),*/
          Container(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: InkWell(
              onTap: () {
                closeKeyboard();
                if (_dateValue.isNotEmpty &&
                    selectedTime != null &&
                    _pickedLocation.isNotEmpty) {
                  bookApiCall("", "");
                  // checkOut();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => CheckOutService(
                  //           restaurants: restaurants,
                  //           selectedTypePrice: restaurants!.restaurant!.price!,
                  //           selectedTypeSize: selectedTypeSize,
                  //           pickedLocation: _pickedLocation,
                  //           dateValue: _dateValue,
                  //           timeValue: selectedTime,
                  //         addressId: addId,
                  //       )
                  //   ),
                  // );
                } else {
                  if (_dateValue.isEmpty) {
                    Fluttertoast.showToast(msg: "Select Date");
                  } else if (selectedTime == null || selectedTime == "") {
                    Fluttertoast.showToast(msg: "Select Time");
                  } else if (_pickedLocation.isEmpty) {
                    Fluttertoast.showToast(msg: "Select Location");
                  }
                }
              },
              child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                        color: backgroundblack,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    height: 50.0,
                    // ignore: deprecated_member_use
                    child: Center(
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "BOOK SERVICE",
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
          Container(height: 15),
          // Container(
          //   width: SizeConfig.screenWidth,
          //   child: Image.asset(
          //     "assets/images/img2.jpg",
          //     fit: BoxFit.cover,
          //   ),
          // ),
        ],
      ),
    );
    // NestedScrollView(
    //   // controller: _scrollController,
    //   headerSliverBuilder: (context, value) {
    //     return [
    //       // SliverAppBar(
    //       //   shape: ContinuousRectangleBorder(
    //       //       borderRadius: BorderRadius.only(
    //       //           bottomLeft: Radius.circular(70),
    //       //           bottomRight: Radius.circular(70))),
    //       //   backgroundColor: backgroundblack,
    //       //   expandedHeight: 400,
    //       //   elevation: 0,
    //       //   floating: true,
    //       //   pinned: true,
    //       //   snap: true,
    //       //   automaticallyImplyLeading: false,
    //       //   iconTheme: IconThemeData(
    //       //     color: Colors.black, //change your color here
    //       //   ),
    //       //   flexibleSpace: FlexibleSpaceBar(
    //       //     background: _poster2(context),
    //       //   ),
    //       //   // leading: Padding(
    //       //   //   padding: const EdgeInsets.all(12),
    //       //   //   child: RawMaterialButton(
    //       //   //     shape: CircleBorder(),
    //       //   //     padding: const EdgeInsets.all(0),
    //       //   //     fillColor: Colors.white,
    //       //   //     splashColor: Colors.grey[400],
    //       //   //     child: Icon(
    //       //   //       Icons.arrow_back,
    //       //   //       size: 20,
    //       //   //     ),
    //       //   //     onPressed: () {
    //       //   //       Navigator.pop(context);
    //       //   //     },
    //       //   //   ),
    //       //   // ),
    //       //  /* actions: [
    //       //     Container(
    //       //       width: 40,
    //       //       child: likedService.contains(restaurants!.restaurant!.resId)
    //       //           ? Padding(
    //       //               padding: const EdgeInsets.all(4),
    //       //               child: RawMaterialButton(
    //       //                 shape: CircleBorder(),
    //       //                 padding: const EdgeInsets.all(0),
    //       //                 fillColor: Colors.white54,
    //       //                 splashColor: Colors.grey[400],
    //       //                 child: Icon(
    //       //                   Icons.favorite,
    //       //                   color: Colors.red,
    //       //                   size: 20,
    //       //                 ),
    //       //                 onPressed: () {
    //       //                   unLikeServiceFunction(
    //       //                       restaurants!.restaurant!.resId!, userID);
    //       //                 },
    //       //               ),
    //       //             )
    //       //           : Padding(
    //       //               padding: const EdgeInsets.all(4),
    //       //               child: RawMaterialButton(
    //       //                 shape: CircleBorder(),
    //       //                 padding: const EdgeInsets.all(0),
    //       //                 fillColor: Colors.white54,
    //       //                 splashColor: Colors.grey[400],
    //       //                 child: Icon(
    //       //                   Icons.favorite_border,
    //       //                   size: 20,
    //       //                 ),
    //       //                 onPressed: () {
    //       //                   likeServiceFunction(
    //       //                       restaurants!.restaurant!.resId!, userID);
    //       //                 },
    //       //               ),
    //       //             ),
    //       //     ),
    //       //     Padding(
    //       //       padding: const EdgeInsets.all(12),
    //       //       child: RawMaterialButton(
    //       //         shape: CircleBorder(),
    //       //         padding: const EdgeInsets.all(0),
    //       //         fillColor: Colors.white54,
    //       //         splashColor: Colors.grey[400],
    //       //         child: Icon(
    //       //           Icons.fullscreen,
    //       //           size: 20,
    //       //         ),
    //       //         onPressed: () {
    //       //           Navigator.push(
    //       //             context,
    //       //             MaterialPageRoute(
    //       //                 builder: (context) => ViewImages(
    //       //                       images: restaurants!.restaurant!.allImage!,
    //       //                       number: 0,
    //       //                     )),
    //       //           );
    //       //         },
    //       //       ),
    //       //     ),
    //       //   ],*/
    //       // ),
    //       // flexibleSpace: _poster2(context)),
    //       _poster2(context),
    //     ];
    //   },
    //   body: );
  }

  Widget _poster2(BuildContext context) {
    Widget carousel = restaurants!.restaurant!.allImage == null
        ? Center(
            child: SpinKitCubeGrid(
              color: Colors.white,
            ),
          )
        : Stack(
            children: <Widget>[
              // ClipRRect(
              //   borderRadius: BorderRadius.only(
              //       bottomLeft: Radius.circular(30),
              //       bottomRight: Radius.circular(30)),
              //   child: CachedNetworkImage(
              //     imageUrl: restaurants!.restaurant!.logo.toString(),
              //     imageBuilder: (context, imageProvider) => Container(
              //       decoration: BoxDecoration(
              //         image: DecorationImage(
              //           image: imageProvider,
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     ),
              //     placeholder: (context, url) => Center(
              //       child: Container(
              //         height: 100,
              //         width: 100,
              //         // margin: EdgeInsets.all(70.0),
              //         child: CircularProgressIndicator(
              //           strokeWidth: 2.0,
              //           valueColor: new AlwaysStoppedAnimation<Color>(
              //               appColorGreen),
              //         ),
              //       ),
              //     ),
              //     errorWidget: (context, url, error) => Icon(Icons.error),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              Carousel(
                images: restaurants!.restaurant!.logo!.map((it) {
                  return ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    child: CachedNetworkImage(
                      imageUrl: it,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          // margin: EdgeInsets.all(70.0),
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                appColorGreen),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
                showIndicator: true,
                dotBgColor: Colors.transparent,
                borderRadius: false,
                autoplay: false,
                dotSize: 5.0,
                dotSpacing: 15.0,
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                  ),
                  margin: EdgeInsets.zero,
                  color: Colors.black45.withOpacity(0.1),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50, left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurants!.restaurant!.resName!,
                        style: TextStyle(
                            fontSize: 25,
                            color: appColorWhite,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 10,
                      ),
                      Container(
                        height: 4,
                        width: 100,
                        decoration: BoxDecoration(
                            color: appColorWhite,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );

    return SizedBox(width: SizeConfig.screenWidth, child: carousel);
  }

  Widget reviewWidget(List<Review> model) {
    return model.length > 0
        ? ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            itemCount: model.length > 1 ? 1 : model.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return model[index].revUserData == null
                  ? Container()
                  : InkWell(
                      onTap: () {},
                      child: Center(
                        child: Container(
                          child: SizedBox(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Card(
                                        elevation: 4.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0)),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(50.0)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            child: CachedNetworkImage(
                                              imageUrl: model[index]
                                                  .revUserData!
                                                  .profilePic
                                                  .toString(),
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  Center(
                                                child: Container(
                                                  height: 20,
                                                  width: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2.0,
                                                    valueColor:
                                                        new AlwaysStoppedAnimation<
                                                                Color>(
                                                            appColorGreen),
                                                  ),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(width: 10.0),
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(height: 10.0),
                                            Text(
                                              model[index]
                                                  .revUserData!
                                                  .username!,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Container(height: 5),
                                            RatingBar.builder(
                                              initialRating: double.parse(
                                                  model[index].revStars!),
                                              minRating: 0,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 15,
                                              ignoreGestures: true,
                                              unratedColor: Colors.grey,
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.orange,
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),
                                            Container(height: 5),
                                            Text(
                                              model[index].revText!,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              maxLines: 3,
                                              overflow: TextOverflow.clip,
                                            ),
                                            // Text(
                                            //   dateformate,
                                            //   style: TextStyle(fontSize: 12),
                                            // ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      height: 0.8,
                                      color: Colors.grey[600],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ));
            })
        : Text("No reviews found.");
  }

  openBottmSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState1) {
            return DraggableScrollableSheet(
              initialChildSize: 0.6,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  height: SizeConfig.screenHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    color: appColorWhite,
                  ),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      )),
                      margin: EdgeInsets.zero,
                      //color: Colors.black45.withOpacity(0.6),
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 15, bottom: 10),
                                  child: Text(
                                    "Time Slot:",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      //color: Colors.purple
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.close)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                          Container(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _timeValue = "8AM - 12PM";
                                      one = true;
                                      two = false;
                                      three = false;
                                      four = false;
                                    });
                                    setState1(() {});
                                  },
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: one
                                            ? appColorBlack
                                            : Colors.grey[300],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, right: 25),
                                      child: Center(
                                        child: Text(
                                          "8AM - 12PM",
                                          style: TextStyle(
                                              color: one
                                                  ? appColorWhite
                                                  : Colors.grey[800],
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 15,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _timeValue = "12PM - 3PM";
                                      one = false;
                                      two = true;
                                      three = false;
                                      four = false;
                                    });
                                    setState1(() {});
                                  },
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: two
                                            ? appColorBlack
                                            : Colors.grey[300],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, right: 25),
                                      child: Center(
                                        child: Text(
                                          "12PM - 3PM",
                                          style: TextStyle(
                                              color: two
                                                  ? appColorWhite
                                                  : Colors.grey[800],
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 20,
                              ),
                            ],
                          ),
                          Container(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _timeValue = "3PM - 6PM";
                                      one = false;
                                      two = false;
                                      three = true;
                                      four = false;
                                    });
                                    setState1(() {});
                                  },
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: three
                                            ? appColorBlack
                                            : Colors.grey[300],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, right: 25),
                                      child: Center(
                                        child: Text(
                                          "3PM - 6PM",
                                          style: TextStyle(
                                              color: three
                                                  ? appColorWhite
                                                  : Colors.grey[800],
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 15,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _timeValue = "6PM - 9PM";
                                      one = false;
                                      two = false;
                                      three = false;
                                      four = true;
                                    });
                                    setState1(() {});
                                  },
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: four
                                            ? appColorBlack
                                            : Colors.grey[300],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, right: 25),
                                      child: Center(
                                        child: Text(
                                          "6PM - 9PM",
                                          style: TextStyle(
                                              color: four
                                                  ? appColorWhite
                                                  : Colors.grey[800],
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 20,
                              ),
                            ],
                          ),
                        ],
                      )),
                );
              },
            );
          });
        });
  }

  _getLocation() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
              "AIzaSyCqQW9tN814NYD_MdsLIb35HRY65hHomco",
            )));
    setState(() {
      _pickedLocation = result.formattedAddress.toString();
    });
  }

  Future getAddress(id) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl()}/get_address'));
    request.fields.addAll({'id': '$id', 'user_id': '$userID'});

    print(request);
    print(request.fields);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      final jsonResponse = AddressModel.fromJson(json.decode(str));
      if (jsonResponse.responseCode == "1") {
        setState(() {
          _pickedLocation =
              "${jsonResponse.data![0].address!}, ${jsonResponse.data![0].building}";
        });
      }
      print(_pickedLocation);
      return AddressModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

//   checkOut() {
//     generateOrderId("rzp_test_xM5O48R6soyM4v", "rXG0rFMU4Q4uGSLB9Oh8biMp",
//         int.parse(selectedTypePrice) * 100);

//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     if (_razorpay != null) _razorpay.clear();
//   }

//   Future<String> generateOrderId(String key, String secret, int amount) async {
//     setState(() {
//       isLoading = true;
//     });
//     var authn = 'Basic ' + base64Encode(utf8.encode('$key:$secret'));

//     var headers = {
//       'content-type': 'application/json',
//       'Authorization': authn,
//     };

//     var data =
//         '{ "amount": $amount, "currency": "INR", "receipt": "receipt#R1", "payment_capture": 1 }'; // as per my experience the receipt doesn't play any role in helping you generate a certain pattern in your Order ID!!

//     var res = await http.post('https://api.razorpay.com/v1/orders',
//         headers: headers, body: data);
//     //if (res.statusCode != 200) throw Exception('http.post error: statusCode= ${res.statusCode}');
//     print('ORDER ID response => ${res.body}');
//     orderid = json.decode(res.body)['id'].toString();
//     print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + orderid);
//     if (orderid.length > 0) {
//       openCheckout();
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//     }

//     return json.decode(res.body)['id'].toString();
//   }

//   //rzp_live_UMrVDdnJjTUhcc
// //rzp_test_rcbv2RXtgmOyTf
//   void openCheckout() async {
//     var options = {
//       'key': 'rzp_test_rcbv2RXtgmOyTf',
//       'amount': int.parse(selectedTypePrice) * 100,
//       'currency': 'INR',
//       'name': 'Ezshield',
//       'description': '',
//       // 'order_id': orderid,
//       'prefill': {'contact': userMobile, 'email': userEmail},
//       // 'external': {
//       //   'wallets': ['paytm']
//       // }
//     };

//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint(e);
//     }
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     Toast.show("SUCCESS Order: " + response.paymentId, context,
//         duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

//     bookApiCall(response.paymentId);

//     print(response.paymentId);
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     Toast.show("ERROR: " + response.code.toString() + " - " + response.message,
//         context,
//         duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

//     print(response.code.toString() + " - " + response.message);
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     Toast.show("EXTERNAL_WALLET: " + response.walletName, context,
//         duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

//     print(response.walletName);
//   }

//   bookApiCall(String txnId) async {
//     setState(() {
//       isLoading = true;
//     });
//     var uri = Uri.parse(baseUrl() + "booking");

//     var request = new http.MultipartRequest("POST", uri);

//     Map<String, String> headers = {
//       "Accept": "application/json",
//     };
//     request.headers.addAll(headers);

//     request.fields['res_id'] = restaurants.restaurant.resId;
//     request.fields['user_id'] = userID;
//     request.fields['date'] = _dateValue;
//     request.fields['slot'] = _timeValue;
//     request.fields['size'] = selectedTypeSize;
//     request.fields['address'] =
//         addressController.text.toString() + "," + _pickedLocation;

// // send
//     var response = await request.send();

//     print(response.statusCode);

//     String responseData = await response.stream
//         .transform(utf8.decoder)
//         .join(); // decodes on response data using UTF8.decoder
//     Map data = json.decode(responseData);
//     print(data);
//     print(data["booking"]["booking_id"]);

//     setState(() {
//       isLoading = false;

//       if (data["response_code"] == "1") {
//         successPaymentApiCall(txnId, data["booking"]["booking_id"].toString());
//       } else {
//         isLoading = false;
//         bookDialog(
//           context,
//           "something went wrong. Try again",
//           button: true,
//         );
//       }
//     });
//   }

//   successPaymentApiCall(txnId, String bookingId) async {
//     setState(() {
//       isLoading = true;
//     });

//     var uri = Uri.parse(baseUrl() + "payment_success");

//     var request = new http.MultipartRequest("POST", uri);

//     Map<String, String> headers = {
//       "Accept": "application/json",
//     };
//     request.headers.addAll(headers);

//     request.fields['txn_id'] = txnId;
//     request.fields['amount'] = selectedTypePrice;
//     request.fields['booking_id'] = bookingId;

// // send
//     var response = await request.send();

//     print(response.statusCode);

//     String responseData = await response.stream
//         .transform(utf8.decoder)
//         .join(); // decodes on response data using UTF8.decoder
//     Map data = json.decode(responseData);
//     print(data);

//     setState(() {
//       isLoading = false;

//       if (data["response_code"] == "1") {
//         Toast.show("Payment Success", context,
//             duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => BookingSccess(
//                   image: restaurants.restaurant.allImage[0],
//                   name: restaurants.restaurant.resName,
//                   location: _pickedLocation,
//                   date: _dateValue,
//                   time: _timeValue)),
//         );
//       } else {
//         setState(() {
//           isLoading = false;
//           Toast.show("something went wrong. Try again", context,
//               duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//         });
//       }
//     });
//   }

  likeServiceFunction(String resId, String userID) async {
    LikeServiceModal likeServiceModal;

    var uri = Uri.parse('${baseUrl()}/likeRes');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields.addAll({
      'res_id': resId,
      'user_id': userID,
    });

    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    likeServiceModal = LikeServiceModal.fromJson(userData);

    if (likeServiceModal.responseCode == "1") {
      setState(() {
        likedService.add(restaurants!.restaurant!.resId);
      });
      Flushbar(
        backgroundColor: appColorWhite,
        messageText: Text(
          likeServiceModal.message!,
          style: TextStyle(
            fontSize: SizeConfig.blockSizeHorizontal! * 4,
            color: appColorBlack,
          ),
        ),

        duration: Duration(seconds: 3),
        // ignore: deprecated_member_use
        mainButton: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WishListScreen(
                  back: true,
                ),
              ),
            );
          },
          child: Text(
            "Go to wish list",
            style: TextStyle(color: appColorBlack),
          ),
        ),
        icon: Icon(
          Icons.favorite,
          color: appColorBlack,
          size: 25,
        ),
      )..show(context);
    } else {
      Flushbar(
        title: "Fail",
        message: likeServiceModal.message,
        duration: Duration(seconds: 3),
        icon: Icon(
          Icons.error,
          color: Colors.red,
        ),
      )..show(context);
    }
  }

  unLikeServiceFunction(String resId, String userID) async {
    UnlikeServiceModal unlikeServiceModal;

    var uri = Uri.parse('${baseUrl()}/unlike');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields.addAll({
      'res_id': resId,
      'user_id': userID,
    });

    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    unlikeServiceModal = UnlikeServiceModal.fromJson(userData);

    if (unlikeServiceModal.status == '1') {
      setState(() {
        likedService.remove(restaurants!.restaurant!.resId);
      });
      Flushbar(
        backgroundColor: appColorWhite,
        messageText: Text(
          unlikeServiceModal.msg!,
          style: TextStyle(
            fontSize: SizeConfig.blockSizeHorizontal! * 4,
            color: appColorBlack,
          ),
        ),

        duration: Duration(seconds: 3),
        // ignore: deprecated_member_use
        mainButton: Container(),
        icon: Icon(
          Icons.favorite_border,
          color: appColorBlack,
          size: 25,
        ),
      )..show(context);
    } else {
      Flushbar(
        title: "Fail",
        message: unlikeServiceModal.msg,
        duration: Duration(seconds: 3),
        icon: Icon(
          Icons.error,
          color: Colors.red,
        ),
      )..show(context);
    }
  }
}
