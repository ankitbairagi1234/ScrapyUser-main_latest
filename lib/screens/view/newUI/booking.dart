import 'dart:convert';
import 'package:dotted_line/dotted_line.dart';
import 'package:ez/screens/view/models/getOrder_modal.dart';
import 'package:ez/screens/view/newUI/booking_details.dart';
import 'package:ez/screens/view/newUI/viewBookingNotification.dart';
import 'package:ez/screens/view/newUI/viewOrders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez/constant/global.dart';
import 'package:ez/constant/sizeconfig.dart';
import 'package:ez/screens/view/models/getBookingModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
// import 'package:toast/toast.dart';

// ignore: must_be_immutable
class BookingScreen extends StatefulWidget {
  bool? back;
  BookingScreen({this.back});
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<BookingScreen> {
  bool explorScreen = false;
  bool mapScreen = true;
  GetBookingModel? model;
  GetOrdersModal? getOrdersModal;

  @override
  void initState() {
    // getOrderApi();
    super.initState();
    getBookingAPICall();
  }

  getOrderApi() async {
    print("user id ${userID}");
    try {
      Map<String, String> headers = {
        'content-type': 'application/x-www-form-urlencoded',
      };
      var map = new Map<String, dynamic>();
      map['user_id'] = userID;

      final response = await client.post(Uri.parse("${baseUrl()}/get_user_orders"),
          headers: headers, body: map);
        print("${baseUrl()}/get_user_orders");
        print(" order para here ${map.toString()}");
      Map<String, dynamic> userMap = jsonDecode(response.body);
      setState(() {
        getOrdersModal = GetOrdersModal.fromJson(userMap);
      });
    } on Exception {
      Fluttertoast.showToast(msg: "No Internet connection");
      throw Exception('No Internet connection');
    }
  }

  getBookingAPICall() async {
      Map<String, String> headers = {
        'content-type': 'application/x-www-form-urlencoded',
      };
      var map = new Map<String, dynamic>();
      map['user_id'] = userID;
      final response = await client.post(Uri.parse("${baseUrl()}/get_booking_by_user"),
          headers: headers, body: map);
      print("${baseUrl()}/get_booking_by_user");
      print(map.toString());
      var dic = json.decode(response.body);
      Map<String, dynamic> userMap = jsonDecode(response.body);
      setState(() {
        model = GetBookingModel.fromJson(userMap);
      });
      print("GetBooking>>>>>>  ${model} and ${model!.msg} and ${model!.booking!.length}");
      print(dic);
    // } on Exception {
    //   Fluttertoast.showToast(msg: "No Internet connection");
    //   throw Exception('No Internet connection');
    // }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Container(
        child: Scaffold(
          backgroundColor: appColorWhite,
          // appBar: AppBar(
          //   shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.only(
          //           bottomLeft: Radius.circular(20),
          //           bottomRight: Radius.circular(20)
          //       )
          //   ),
          //   backgroundColor: backgroundblack,
          //   elevation: 0,
          //   title: Text(
          //     'My Orders',
          //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          //   ),
          //   centerTitle: true,
          //   leading: widget.back == true
          //       ?   Padding(
          //     padding: const EdgeInsets.all(12),
          //     child: RawMaterialButton(
          //       shape: CircleBorder(),
          //       padding: const EdgeInsets.all(0),
          //       fillColor: Colors.white,
          //       splashColor: Colors.grey[400],
          //       child: Icon(
          //         Icons.arrow_back,
          //         size: 20,
          //         color: appColorBlack,
          //       ),
          //       onPressed: () {
          //         Navigator.pop(context);
          //       },
          //     ),
          //   )
          //       : Container(),
          // ),
          body: Column(
            children: [
              Expanded(
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
                              // Tab(
                              //   text: 'Orders',
                              // ),
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
            ],
          ),
        ),
      ),
    );
  }

  // _refresh(){
  //   getBookingAPICall();
  // }

  Widget orderWidget() {
    return getOrdersModal == null
        ? Center(
            child: Image.asset("assets/images/loader1.gif"),
          )
        : getOrdersModal!.responseCode != "0"
            ? ListView.builder(
                padding: EdgeInsets.only(bottom: 10, top: 10),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                //physics: const NeverScrollableScrollPhysics(),
                itemCount: getOrdersModal!.orders!.length,
                //scrollDirection: Axis.horizontal,
                itemBuilder: (
                  context,
                  int index,
                ) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewOrders(
                                  orders: getOrdersModal!.orders![index])),
                        );
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 25, top: 20),
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              DateFormat('dd').format(
                                                  DateTime.parse(getOrdersModal!
                                                      .orders![index].date.toString())),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 22),
                                            ),
                                            Text(
                                              DateFormat('MMM').format(
                                                  DateTime.parse(getOrdersModal!
                                                      .orders![index].date.toString())),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17),
                                            ),
                                          ],
                                        ),
                                        Container(width: 10),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20,
                                              bottom: 20,
                                              left: 10,
                                              right: 10),
                                          child: DottedLine(
                                            direction: Axis.vertical,
                                            lineLength: double.infinity,
                                            lineThickness: 1.0,
                                            dashLength: 4.0,
                                            dashColor: Colors.grey[600],
                                            dashRadius: 0.0,
                                            dashGapLength: 4.0,
                                            dashGapColor: Colors.transparent,
                                            dashGapRadius: 0.0,
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "OrderId: " +
                                                    getOrdersModal!
                                                        .orders![index].orderId.toString(),
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(height: 4),
                                              Text(
                                                "TxnId: " +
                                                    getOrdersModal!
                                                        .orders![index].txnId.toString(),
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ));
                },
              )
            : Center(
                child: Text(
                  "Don't have any Orders",
                  style: TextStyle(
                    color: appColorBlack,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              );
  }

  Widget bookingWidget() {

    return  model == null ? Center(child: CircularProgressIndicator(),) : model!.booking!.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.only(bottom: 10, top: 10),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                //physics: const NeverScrollableScrollPhysics(),
                itemCount: model!.booking!.length,
                //scrollDirection: Axis.horizontal,
                itemBuilder: (context, int index,) {
                 // var dateFormate = model!.booking![index].pDate;
                  //var dateFormate =   DateFormat("dd/MM/yyyy").format(DateTime.parse(model!.booking![index].pDate ?? ""));
                  return InkWell(
                      onTap: () async {
                        bool result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookingDetailScreen(model!.booking![index]),
                        ));
                        if(result == true){
                          setState(() {
                            getBookingAPICall();
                          });
                        }
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 25, right: 25, top: 15),
                              child: Container(
                                height: 130,
                                width: double.infinity,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              DateFormat('dd').format(
                                                  DateTime.parse(model!
                                                      .booking![index].pDate.toString())),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 22),
                                            ),
                                            Text(
                                              DateFormat('MMM').format(
                                                  DateTime.parse(model!
                                                      .booking![index].pDate.toString())),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17),
                                            ),
                                          ],
                                        ),
                                        Container(width: 10),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 20,
                                              bottom: 20,
                                              left: 10,
                                              right: 10),
                                          child: DottedLine(
                                            direction: Axis.vertical,
                                            lineLength: double.infinity,
                                            lineThickness: 1.0,
                                            dashLength: 4.0,
                                            dashColor: Colors.grey[600],
                                            dashRadius: 0.0,
                                            dashGapLength: 4.0,
                                            dashGapColor: Colors.transparent,
                                            dashGapRadius: 0.0,
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                               "Booking Id - ${ model!.booking![index].id.toString()}",
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              Container(height: 2),
                                              Text(
                                                model!.booking![index].scrapName.toString(),
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(height: 2),
                                              Text(
                                                //"${dateFormate}",
                                                 model!.booking![index].pDate!.toString(),
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              ),
                                              Container(height: 2),
                                              Text(
                                                model!.booking![index].slot!,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              )
                                              // model!.booking![index].status == "Completed"
                                              //     ? Container(
                                              //  // width: 80,
                                              //   height: 30,
                                              //   alignment: Alignment.center,
                                              //   decoration: BoxDecoration(
                                              //     borderRadius: BorderRadius.circular(10.0),
                                              //     color: Colors.green
                                              //   ),
                                              //   child: Text(
                                              //     model!.booking![index].status!,
                                              //     maxLines: 1,
                                              //     textAlign: TextAlign.center,
                                              //     style: TextStyle(
                                              //         color: Colors.white,
                                              //         fontSize: 12),
                                              //   ),
                                              // )
                                              //     : model!.booking![index].status == "Cancelled by user" ? Container(
                                              //   //width: 80,
                                              //   height: 30,
                                              //   alignment: Alignment.center,
                                              //   decoration: BoxDecoration(
                                              //       borderRadius: BorderRadius.circular(10.0),
                                              //       color: Colors.red
                                              //   ),
                                              //   child: Text(
                                              //     model!.booking![index].status!,
                                              //     maxLines: 1,
                                              //     textAlign: TextAlign.center,
                                              //     style: TextStyle(
                                              //         color: Colors.white,
                                              //         fontSize: 12),
                                              //   ),
                                              // ) : model!.booking![index].status == "Cancelled by vendor" ?
                                              // Container(
                                              //   //width: 80,
                                              //   height: 30,
                                              //   alignment: Alignment.center,
                                              //   decoration: BoxDecoration(
                                              //       borderRadius: BorderRadius.circular(10.0),
                                              //       color: Colors.red
                                              //   ),
                                              //   child: Text(
                                              //     model!.booking![index].status!,
                                              //     maxLines: 1,
                                              //     textAlign: TextAlign.center,
                                              //     style: TextStyle(
                                              //         color: appColorWhite,
                                              //         fontSize: 12),
                                              //   ),
                                              // ) :
                                              // Container(
                                              // //  width: 80,
                                              //   height: 30,
                                              //   alignment: Alignment.center,
                                              //   decoration: BoxDecoration(
                                              //       borderRadius: BorderRadius.circular(10.0),
                                              //       color: backgroundblack
                                              //   ),
                                              //   child: Text(
                                              //     model!.booking![index].status!,
                                              //     maxLines: 1,
                                              //     textAlign: TextAlign.center,
                                              //     style: TextStyle(
                                              //         color: appColorWhite,
                                              //         fontSize: 12),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: backgroundblack,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Icon(Icons.arrow_forward,color: appColorWhite,),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ));
                },
              )
            : Center(
                child: Text(
                  "Don't have any Order",
                  style: TextStyle(
                    color: appColorBlack,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              );
  }
}
