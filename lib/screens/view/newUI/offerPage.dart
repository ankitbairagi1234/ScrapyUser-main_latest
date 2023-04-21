import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ez/Helper/session.dart';
import 'package:ez/constant/sizeconfig.dart';
import 'package:ez/screens/view/models/OfferModel.dart';
import 'package:ez/screens/view/models/bannerModal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:http/http.dart' as http;
import '../../../constant/global.dart';

class OfferPage extends StatefulWidget {
  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {

  void initState(){
    super.initState();
   // _getBanners();
    getOfferFunction();
  }

  BannerModal? bannerModal;

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

  OfferModel? offerModeldata;

  getOfferFunction()async{
    var headers = {
      'Cookie': 'ci_session=0ea9c1cfb58a9963d191b28aa70aaacd7c5f7b24'
    };
    var request = http.Request('POST', Uri.parse('${baseUrl()}/get_offer'));
    request.headers.addAll(headers);
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

  @override
  Widget build(BuildContext context) {
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
        elevation: 2,
        title: Text(
          '${getTranslated(context, 'offer')}',
          style: TextStyle(color: appColorWhite, fontWeight: FontWeight.bold),
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
      body: Column(
        children: [
          Container(height: 15),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: DefaultTabController(
                length: 1,
                initialIndex: 0,
                child: Column(
                  children: <Widget>[
                    /*Container(
                        width: 250,
                        height: 40,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[300]),
                        child: Center(
                          child: TabBar(
                            labelColor: appColorWhite,
                            unselectedLabelColor: appColorBlack,
                            labelStyle: TextStyle(
                                fontSize: 13.0,
                                color: appColorWhite,
                                fontWeight: FontWeight.bold),
                            unselectedLabelStyle: TextStyle(
                                fontSize: 13.0,
                                color: appColorBlack,
                                fontWeight: FontWeight.bold),
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xFF619aa5)),
                            tabs: <Widget>[
                              Tab(
                                text: 'Orders',
                              ),
                              Tab(
                                text: 'Booking',
                              ),
                            ],
                          ),
                        ),
                      ),*/
                    Expanded(
                      child: TabBarView(
                        children: <Widget>[
                          // orderWidget(),
                          bookingWidget()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
  Widget bookingWidget() {
    return offerModeldata == null
        ? Align(
      alignment: Alignment.center,
      child: Container(
          height: 20,
          width: 20,
          child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
              ))),
    )
        : offerModeldata!.responseCode == "1"
        ? Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: ListView.builder(
          shrinkWrap: true,
          //physics: NeverScrollableScrollPhysics(),
          itemCount: offerModeldata!.data!.length,
          itemBuilder: (context, index) => bookingItemWidget(index)),
    )
        : Container(
      height: SizeConfig.screenHeight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/emptyNotification.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  '${getTranslated(context, 'offerlistisEmpty')}',
                  style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            )),
      ),
    );
  }
  Widget bookingItemWidget(int index) {
    // var dateFormate = DateFormat("dd/MM/yyyy").format(DateTime.parse(bookingNotificationModal!
    //     .notifications![index].date! ?? ""));
    return Column(
      children: [
        Container(
          child: Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(5.0),
            child: InkWell(
              splashColor: Colors.grey[200],
              focusColor: Colors.grey[200],
              highlightColor: Colors.grey[200],
              onTap: () {

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => ViewBookingNotification(
                //           booking: bookingNotificationModal!.notifications![index].booking!)),
                // );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child:Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color:backgroundblack.withOpacity(0.2),
                      ),
                      child: Text("${offerModeldata!.data![index].id}",style: TextStyle(color: Colors.white),),
                    ),
                   SizedBox(width: 30,),
                   Expanded(child:  Container(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("${offerModeldata!.data![index].name![0].toUpperCase() + offerModeldata!.data![index].name!.substring(1)}",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
                         Text("${offerModeldata!.data![index].cName![0].toUpperCase() + offerModeldata!.data![index].cName!.substring(1)}",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
                         Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text("Add on",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600),),
                             SizedBox(width: 10,),
                             Text("\u{20B9} ${offerModeldata!.data![index].discount}",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600),),
                           ],
                         )
                       ],
                     ),
                   ),),
                  ],
                )
              ),
            ),
          ),
        ),
        Divider(color: Colors.black45, thickness: 0.3)
      ],
    );
  }
}
