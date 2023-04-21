import 'package:ez/constant/global.dart';
import 'package:ez/screens/view/models/bookingNotification_modal.dart';
import 'package:ez/screens/view/newUI/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewBookingNotification extends StatefulWidget {
  List<Booking> booking;
  ViewBookingNotification({required this.booking});
  @override
  _GetCartState createState() => new _GetCartState();
}

class _GetCartState extends State<ViewBookingNotification> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: appColorWhite,
        appBar: AppBar(
          backgroundColor: backgroundblack,
          elevation: 2,
          title: Text(
            "Booking Details",
            style: TextStyle(
                fontSize: 20,
                color: appColorBlack,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: appColorBlack,
              )),
          actions: [],
        ),
        body: Stack(
          children: [
            widget.booking == null
                ? Center(
                    child: loader(),
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: widget.booking.length,
                    itemBuilder: (context, index) {
                      return _itmeList(widget.booking[index], index);
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _itmeList(Booking booking, int index) {
    return InkWell(
      onTap: () {
        /*Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailScreen(
                    resId: booking.serviceId,
                  )),
        );*/
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Container(
              height: 160,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        0.0,
                      ),
                      child: Image.network(
                        booking.resImage!,
                        height: 120,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.serviceName!,
                          style: TextStyle(
                              fontSize: 16,
                              color: appColorBlack,
                              fontWeight: FontWeight.bold),
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(height: 5),
                        Text(
                          "₹${booking.amount}",
                          style: TextStyle(
                              color: appColorBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Container(height: 5),
                        // Text(
                        //   "Area : ${booking.size}",
                        //   style: TextStyle(
                        //       color: Colors.black45,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        // Container(height: 5),
                        Text(
                          "Date : ${booking.date}",
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(height: 5),
                        Text(
                          "Slot : ${booking.slot}",
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey[300],
            )
          ],
        ),
      ),
    );
  }
}
