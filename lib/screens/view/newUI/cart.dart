import 'dart:convert';
import 'package:ez/constant/global.dart';
import 'package:ez/screens/view/models/getCart_modal.dart';
import 'package:ez/screens/view/models/removeCart_modal.dart';
import 'package:ez/screens/view/newUI/checkoutProduct.dart';
import 'package:ez/screens/view/newUI/productDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


// ignore: must_be_immutable
class GetCartScreeen extends StatefulWidget {
  @override
  _GetCartState createState() => new _GetCartState();
}

class _GetCartState extends State<GetCartScreeen> {
  GetCartModal? cartModel;
  bool? isLoading = false;
  bool? isPayment = false;
  RemoveCartModal? removeCartModal;

  @override
  void initState() {
    _getCart();

    super.initState();
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
    cartModel = GetCartModal.fromJson(userData);

    print(responseData);
    if (mounted)
      setState(() {
        isLoading = false;
      });
  }

  removeCart(String id) async {
    setState(() {
      isLoading = true;
    });

    var uri = Uri.parse('${baseUrl()}/remove_cart_items');
    var request = new http.MultipartRequest("Post", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields.addAll({'cart_id': id});
    // request.fields['user_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    removeCartModal = RemoveCartModal.fromJson(userData);

    if (removeCartModal!.responseCode == "1") {
      setState(() {
        cartModel = null;
      });
      _getCart();
    }

    print(responseData);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: appColorWhite,
        appBar: AppBar(
          backgroundColor: backgroundblack,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)
              )
          ),
          elevation: 2,
          title: Text(
            "Cart",
            style: TextStyle(
              fontSize: 20,
              color: appColorWhite,
            ),
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
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      cartModel == null
                          ? Center(
                              child: CupertinoActivityIndicator(),
                            )
                          : cartModel!.responseCode != "0"
                              ? ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: cartModel!.cart!.length,
                                  itemBuilder: (context, index) {
                                    return _itmeList(
                                        cartModel!.cart![index], index);
                                  },
                                )
                              : Center(
                                  child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: Image.asset(
                                        "assets/images/emptyCart.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      "Cart is Empty",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                      isLoading == null
                          ? Center(
                              child: CupertinoActivityIndicator(),
                            )
                          : Container()
                    ],
                  ),
                ),
                Container(height: 15),
                cartModel == null
                    ? Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : cartModel!.responseCode == '0'
                        ? Container()
                        : Card(
                            margin: EdgeInsets.all(0),
                            elevation: 10,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, right: 30, bottom: 20, top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Cart Total: ₹${cartModel!.cartTotal.toString()}",
                                          style: TextStyle(
                                              color: appColorBlack,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Container(height: 10),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CheckoutProduct(
                                                          cartModel:
                                                              cartModel!)),
                                            );
                                          },
                                          child: SizedBox(
                                              height: 60,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    gradient:
                                                        new LinearGradient(
                                                            colors: [
                                                              backgroundblack,
                                                              appColorGreen,
                                                            ],
                                                            begin:
                                                                const FractionalOffset(
                                                                    0.0, 0.0),
                                                            end:
                                                                const FractionalOffset(
                                                                    1.0, 0.0),
                                                            stops: [0.0, 1.0],
                                                            tileMode:
                                                                TileMode.clamp),
                                                    // border: Border.all(color: Colors.grey[400],),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
                                                height: 50.0,
                                                // ignore: deprecated_member_use
                                                child: Center(
                                                  child: Stack(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          "CHECKOUT",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  appColorWhite,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                ],
                              ),
                            ),
                          ),
              ],
            ),
            isPayment == true
                ? Center(
                    child: CupertinoActivityIndicator(),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget _itmeList(Cart cart, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetails(
                    productId: cart.productId!,
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
                        cart.productImage!,
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cart.productName!,
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
                            "₹${cart.price}",
                            style: TextStyle(
                                color: appColorBlack,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Container(height: 5),
                          Text(
                            "Qty : ${cart.quantity}",
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        color: appColorBlack,
                        size: 20,
                      ),
                      onPressed: () {
                        removeCart(cart.cartId!);
                      },
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
