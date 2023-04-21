import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:ez/models/unlike_modal.dart';
import 'package:ez/screens/view/models/addtocart_modal.dart';
import 'package:ez/screens/view/models/like_modal.dart';
import 'package:ez/screens/view/models/productDetailsModal.dart';
import 'package:ez/screens/view/newUI/cart.dart';
import 'package:ez/screens/view/newUI/reviewProduct.dart';
import 'package:ez/screens/view/newUI/viewImages.dart';
import 'package:ez/screens/view/newUI/wishList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ez/constant/global.dart';
import 'package:ez/constant/sizeconfig.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ProductDetails extends StatefulWidget {
  String? productId;

  ProductDetails({
    this.productId,
  });
  @override
  _OrderSuccessWidgetState createState() => _OrderSuccessWidgetState();
}

class _OrderSuccessWidgetState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
  ScrollController? _scrollController;
  ProductDetailsModal? productDetailsModal;
  AddtoCartModal? addtoCartModal;

  String totalPrice = '';
  bool tab1 = true;
  bool tab2 = false;
  bool tab3 = false;
  bool isLoading = false;

  int _n = 1;
  void minus() {
    setState(() {
      if (_n != 1) {
        _n--;
        int price = _n * int.parse(productDetailsModal!.product!.productPrice!);
        totalPrice = price.toString();
      }
    });
  }

  void add() {
    setState(() {
      _n++;
      int price = _n * int.parse(productDetailsModal!.product!.productPrice!);
      totalPrice = price.toString();
    });
  }

  @override
  void initState() {
    _getProductDetails();
    _scrollController = ScrollController();

    super.initState();
  }

  refresh() {
    _getProductDetails();
  }

  _getProductDetails() async {
    var uri = Uri.parse('${baseUrl()}/get_product_details');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields['product_id'] = widget.productId!;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if (mounted) {
      setState(() {
        productDetailsModal = ProductDetailsModal.fromJson(userData);
        totalPrice = productDetailsModal!.product!.productPrice!;
      });
    }

    print(responseData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          productDetailsModal == null
              ? Center(child: CupertinoActivityIndicator())
              : _projectInfo(),
        ],
      ),
    );
  }

  Widget _projectInfo() {
    return NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              // shape: ContinuousRectangleBorder(
              //     borderRadius: BorderRadius.only(
              //         bottomLeft: Radius.circular(70),
              //         bottomRight: Radius.circular(70))),
              backgroundColor: const Color(0xFF619aa5),
              expandedHeight: 300,
              elevation: 0,
              floating: true,
              pinned: true,
              automaticallyImplyLeading: false,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: _poster2(context),
              ),
              leading: Padding(
                padding: const EdgeInsets.all(12),
                child: RawMaterialButton(
                  shape: CircleBorder(),
                  padding: const EdgeInsets.all(0),
                  fillColor: Colors.white54,
                  splashColor: Colors.grey[400],
                  child: Icon(
                    Icons.arrow_back,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              actions: [
                Container(
                  width: 40,
                  child: likedProduct
                          .contains(productDetailsModal!.product!.productId)
                      ? Padding(
                          padding: const EdgeInsets.all(4),
                          child: RawMaterialButton(
                            shape: CircleBorder(),
                            padding: const EdgeInsets.all(0),
                            fillColor: Colors.white54,
                            splashColor: Colors.grey[400],
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 20,
                            ),
                            onPressed: () {
                              unLikeProduct(
                                  productDetailsModal!.product!.productId!,
                                  userID);
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(4),
                          child: RawMaterialButton(
                            shape: CircleBorder(),
                            padding: const EdgeInsets.all(0),
                            fillColor: Colors.white54,
                            splashColor: Colors.grey[400],
                            child: Icon(
                              Icons.favorite_border,
                              size: 20,
                            ),
                            onPressed: () {
                              likeProduct(productDetailsModal!.product!.productId!,
                                  userID);
                            },
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: RawMaterialButton(
                    shape: CircleBorder(),
                    padding: const EdgeInsets.all(0),
                    fillColor: Colors.white54,
                    splashColor: Colors.grey[400],
                    child: Icon(
                      Icons.fullscreen,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewImages(
                                  images:
                                      productDetailsModal!.product!.productImage!,
                                  number: 0,
                                )),
                      );
                    },
                  ),
                ),
              ],
            ),
            SliverAppBar(
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                      bottomRight: Radius.circular(70))),
              backgroundColor: const Color(0xFF619aa5),
              expandedHeight: 250,
              elevation: 0,
              floating: true,
              pinned: true,
              automaticallyImplyLeading: false,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  height: 270,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: backgroundblack,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 5),
                      Container(
                        height: 120,
                        alignment: Alignment.center,
                        child: ListView.builder(
                            padding: EdgeInsets.only(bottom: 10),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                productDetailsModal!.product!.productImage!.length,
                            reverse: true,
                            itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: 95,
                                    decoration: BoxDecoration(
                                      color: appColorWhite,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        productDetailsModal!
                                            .product!.productImage![index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          productDetailsModal!.product!.productName!,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 22,
                              color: appColorWhite,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          height: 4,
                          width: 100,
                          decoration: BoxDecoration(
                              color: appColorWhite,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                        ),
                      ),
                      Container(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          productDetailsModal!.product!.categories!,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 16,
                              color: appColorWhite,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ReviewProduct(
                                  review: productDetailsModal!.review!,
                                  product: productDetailsModal!.product!,
                                  refresh: refresh),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Text(
                                "Ratings",
                                style: TextStyle(
                                  color: appColorWhite,
                                  fontSize: 17,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Container(width: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: RatingBar.builder(
                                  initialRating:
                                      productDetailsModal!.product!.proRatings !=
                                              null
                                          ? double.parse(productDetailsModal!
                                              .product!.proRatings!)
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
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Text(
                              "Price:",
                              style: TextStyle(
                                color: appColorWhite,
                                fontSize: 17,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(width: 10),
                            Text(
                              "₹" + productDetailsModal!.product!.productPrice!,
                              style: TextStyle(
                                color: appColorWhite,
                                fontSize: 17,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 10),
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
                        children: [
                          Container(width: 40),
                          Column(
                            children: [
                              Text(
                                'One Fair Price :',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                'Inclusive of all taxes \n and a good discount',
                                style:
                                    TextStyle(fontSize: 11, color: Colors.grey),
                              )
                            ],
                          ),
                          Container(width: 15),
                          Text(
                            "₹ " + totalPrice,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                fontFamily: 'OpenSansBold'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 15),
                    child: Text(
                      "Qty",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(width: 20),
                  InkWell(
                    onTap: () {
                      minus();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 8, bottom: 8),
                        child: Center(
                            child: Icon(
                          Icons.remove,
                          color: appColorBlack,
                          size: 25,
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                      _n.toString(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      add();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 8, bottom: 8),
                        child: Center(
                            child: Icon(
                          Icons.add,
                          color: appColorBlack,
                          size: 25,
                        )),
                      ),
                    ),
                  )
                ],
              ),
              Container(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: InkWell(
                  onTap: () {
                    addToCart(_n.toString(), userID,
                        productDetailsModal!.product!.productId!);
                  },
                  child: SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: new LinearGradient(
                                colors: [
                                  const Color(0xFF4b6b92),
                                  const Color(0xFF619aa5),
                                ],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
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
                                  "ADD TO CART",
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
              Container(height: 40),
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
                            tab3 = false;
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
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            tab1 = false;
                            tab2 = true;
                            tab3 = false;
                          });
                        },
                        child: Text(
                          "Review",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: tab2 == true ? appColorBlack : Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            tab1 = false;
                            tab2 = false;
                            tab3 = true;
                          });
                        },
                        child: Text(
                          "Instruction",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: tab3 == true ? appColorBlack : Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
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
                          productDetailsModal!.product!.productDescription!,
                          style: TextStyle(
                            color: appColorBlack,
                          ),
                        )
                      : tab2 == true
                          ? reviewWidget(productDetailsModal!.review!)
                          : Text("No instruction found."),
                ),
              ),
              Container(height: 15),
              Container(
                width: SizeConfig.screenWidth,
                child: Image.asset(
                  "assets/images/img3.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ));
  }

  Widget _poster2(BuildContext context) {
    Widget carousel = productDetailsModal!.product!.productImage == null
        ? Center(
            child: SpinKitCubeGrid(
              color: Colors.white,
            ),
          )
        : Stack(
            children: <Widget>[
              Carousel(
                images: productDetailsModal!.product!.productImage!.map((it) {
                  return Container(
                    color: backgroundblack,
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
            ],
          );

    return Column(
      children: [
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.black45,
                  // borderRadius: BorderRadius.only(
                  //     bottomLeft: Radius.circular(50),
                  //     bottomRight: Radius.circular(50))
                ),
                width: SizeConfig.screenWidth,
                child: carousel)),
      ],
    );
  }

  Widget reviewWidget(List<Review> model) {
    return model.length > 0
        ? ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            itemCount: model.length,
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
                                                  .profilePic!,
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
                                              model[index].revUserData!.username!,
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

  addToCart(String quantity, String userID, String productId) async {
    setState(() {
      isLoading = true;
    });
    var uri = Uri.parse('${baseUrl()}/add_to_cart');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields.addAll({
      'quantity': _n.toString(),
      'user_id': userID,
      'product_id': productId,
    });

    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    addtoCartModal = AddtoCartModal.fromJson(userData);

    if (addtoCartModal!.responseCode == "1") {
      setState(() {
        isLoading = false;
      });
      Flushbar(
        backgroundColor: appColorWhite,
        messageText: Text(
          "Item added",
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
                builder: (context) => GetCartScreeen(),
              ),
            );
          },
          child: Text(
            "Go to cart",
            style: TextStyle(color: appColorBlack),
          ),
        ),
        icon: Icon(
          Icons.shopping_cart,
          color: appColorBlack,
          size: 30,
        ),
      )..show(context);
    } else {
      setState(() {
        isLoading = false;
      });
      Flushbar(
        title: "Fail",
        message: addtoCartModal!.message,
        duration: Duration(seconds: 3),
        icon: Icon(
          Icons.error,
          color: Colors.red,
        ),
      )..show(context);
    }

    setState(() {
      isLoading = false;
    });
  }

  likeProduct(String productId, String userID) async {
    LikeModal likeModal;

    var uri = Uri.parse('${baseUrl()}/likePro');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields.addAll({
      'pro_id': productId,
      'user_id': userID,
    });

    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    likeModal = LikeModal.fromJson(userData);

    if (likeModal.responseCode == "1") {
      setState(() {
        likedProduct.add(productDetailsModal!.product!.productId);
      });
      Flushbar(
        backgroundColor: appColorWhite,
        messageText: Text(
          likeModal.message!,
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
        message: likeModal.message,
        duration: Duration(seconds: 3),
        icon: Icon(
          Icons.error,
          color: Colors.red,
        ),
      )..show(context);
    }
  }

  unLikeProduct(String productId, String userID) async {
    UnlikeModel unlikeModel;

    var uri = Uri.parse('${baseUrl()}/unlike_product');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields.addAll({
      'pro_id': productId,
      'user_id': userID,
    });

    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    unlikeModel = UnlikeModel.fromJson(userData);

    if (unlikeModel.status == 1) {
      setState(() {
        likedProduct.remove(productDetailsModal!.product!.productId!);
      });
      Flushbar(
        backgroundColor: appColorWhite,
        messageText: Text(
          unlikeModel.msg!,
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
        message: unlikeModel.msg,
        duration: Duration(seconds: 3),
        icon: Icon(
          Icons.error,
          color: Colors.red,
        ),
      )..show(context);
    }
  }
}
