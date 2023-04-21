import 'package:ez/constant/global.dart';
import 'package:ez/screens/view/models/notification_modal.dart';
import 'package:ez/screens/view/newUI/productDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewNotification extends StatefulWidget {
  List<Products>? products;
  ViewNotification({this.products});
  @override
  _GetCartState createState() => new _GetCartState();
}

class _GetCartState extends State<ViewNotification> {
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
          backgroundColor: appColorWhite,
          elevation: 2,
          title: Text(
            "Order Details",
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
            widget.products == null
                ? Center(
                    child: loader(),
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: widget.products!.length,
                    itemBuilder: (context, index) {
                      return _itmeList(widget.products![index], index);
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _itmeList(Products products, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetails(
                    productId: products.productId,
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Container(
              height: 130,
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
                        products.productImage!,
                        height: 90,
                        width: 90,
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
                          products.productName!,
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
                          "₹${products.productPrice}",
                          style: TextStyle(
                              color: appColorBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Container(height: 5),
                        Text(
                          "Qty : ${products.quantity}",
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
