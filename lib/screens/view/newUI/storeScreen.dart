import 'dart:convert';
import 'package:ez/screens/view/models/getProductFromCat_modal.dart';
import 'package:ez/screens/view/models/productCategory_modal.dart';
import 'package:ez/screens/view/newUI/productDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez/constant/global.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:toast/toast.dart';

// ignore: must_be_immutable
class StoreScreen extends StatefulWidget {
  bool? back;
  StoreScreen({this.back});
  @override
  _ServiceTabState createState() => _ServiceTabState();
}

class _ServiceTabState extends State<StoreScreen>
    with SingleTickerProviderStateMixin {
  ProductCategoryModal? productCategoryModal;
  GetProductFromCatModal? productModal;

  List<String> title = [];
  List<String> id = [];
  List<String> icon = [];
  int initPosition = 0;

  @override
  void initState() {
    super.initState();
    getProductCategory();
  }

  getProductCategory() async {
    try {
      Map<String, String> headers = {
        'content-type': 'application/x-www-form-urlencoded',
      };
      var map = new Map<String, dynamic>();
      //  map['cat_id'] = "15";

      final response = await client.post(Uri.parse(baseUrl() + "get_all_product_category"),
          headers: headers, body: map);

      var dic = json.decode(response.body);
      print(dic);
      Map<String, dynamic> userMap = jsonDecode(response.body);
      if (mounted)
        setState(() {
          productCategoryModal = ProductCategoryModal.fromJson(userMap);
          for (var i = 0; i < productCategoryModal!.category!.length; i++) {
            title.add(productCategoryModal!.category![i].cName!);
            id.add(productCategoryModal!.category![i].id!);
            icon.add(productCategoryModal!.category![i].image!);
          }
        });
      if (productCategoryModal != null) {
        getProduct(productCategoryModal!.category![0].id!);
      }
    } on Exception {
      Fluttertoast.showToast(msg: "No Internet connection");
      // Toast.show("No Internet connection", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      throw Exception('No Internet connection');
    }
  }

  getProduct(String id) async {
    try {
      Map<String, String> headers = {
        'content-type': 'application/x-www-form-urlencoded',
      };
      var map = new Map<String, dynamic>();
      map['cat_id'] = id;

      final response = await client.post(Uri.parse(baseUrl() + "get_pro_by_cat_id"),
          headers: headers, body: map);

      var dic = json.decode(response.body);
      print(dic);
      Map<String, dynamic> userMap = jsonDecode(response.body);
      if (mounted)
        setState(() {
          productModal = GetProductFromCatModal.fromJson(userMap);
        });
    } on Exception {
      Fluttertoast.showToast(msg: "No Internet connection");
      // Toast.show("No Internet connection", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      throw Exception('No Internet connection');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorWhite,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          'Store',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: widget.back == true
            ? IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            if (widget.back == true) {
              Navigator.pop(context);
            }
          },
        ):Container(),
      ),
      body: title.length > 0
          ? Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CustomTabView(
                initPosition: initPosition,
                itemCount: title.length,
                tabBuilder: (context, index) => Tab(
                  text: title[index],
                  icon: icon[index] == null || icon[index] == "" ? Icon(Icons.account_balance):
                  Image.network(
                    icon[index],
                    height: 30,
                    loadingBuilder: (BuildContext context, Widget? child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child!;
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                    },
                  ),
                ),
                pageBuilder: (context, index) =>
                    Container(color: backgroundgrey, child: serviceWidget()),
                onPositionChange: (index) {
                  setState(() {
                    productModal = null;
                  });
                  print('current position: $index');
                  initPosition = index;
                  getProduct(id[index]);
                },
                onScroll: (position) => print('$position'),
              ),
            )
          : Center(
              child: loader(),
            ),
    );
  }

  Widget serviceWidget() {
    return productModal == null
        ? Center(
            child: CupertinoActivityIndicator(),
          )
        : productModal!.products!.length > 0
            ? Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  //physics: NeverScrollableScrollPhysics(),
                  primary: false,
                  padding: EdgeInsets.all(5),
                  itemCount: productModal!.products!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 170/200,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                    productId:
                                        productModal!.products![index].productId,
                                  )),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              width: 150,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 15, left: 15, right: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 120,
                                          child:  productModal!.products![index].productImage! == null ||
                                              productModal!.products![index].productImage! == ""?
                                              Image.network(productModal!.products![index].productImage!):
                                                 Image.asset("assets/images/ez_logo.png"),
                                               // productModal!.products![index].productImage!),
                                             )
                                      ],
                                    ),
                                    Container(height: 5),
                                    Text(
                                      productModal!.products![index].productName!,
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.local_offer_outlined,
                                                    size: 20),
                                                Container(width: 5),
                                                Text(
                                                  "₹" +
                                                      productModal!
                                                          .products![index]
                                                          .productPrice!,
                                                  style: TextStyle(
                                                      color: appColorOrange,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : Center(
                child: Text(
                  "Don't have any product",
                  style: TextStyle(
                    color: appColorBlack,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              );
  }
}

class CustomTabView extends StatefulWidget {
  final int? itemCount;
  final IndexedWidgetBuilder? tabBuilder;
  final IndexedWidgetBuilder? pageBuilder;
  final Widget? stub;
  final ValueChanged<int>? onPositionChange;
  final ValueChanged<double>? onScroll;
  final int? initPosition;

  CustomTabView({
    @required this.itemCount,
    @required this.tabBuilder,
    @required this.pageBuilder,
    this.stub,
    this.onPositionChange,
    this.onScroll,
    this.initPosition,
  });

  @override
  _CustomTabsState createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabView>
    with TickerProviderStateMixin {
  TabController? controller;
  int? _currentCount;
  int? _currentPosition;

  @override
  void initState() {
    _currentPosition = widget.initPosition ?? 0;
    controller = TabController(
      length: widget.itemCount!,
      vsync: this,
      initialIndex: _currentPosition!,
    );
    controller!.addListener(onPositionChange);
    controller!.animation!.addListener(onScroll);
    _currentCount = widget.itemCount;
    super.initState();
  }

  @override
  void didUpdateWidget(CustomTabView oldWidget) {
    if (_currentCount != widget.itemCount) {
      controller!.animation!.removeListener(onScroll);
      controller!.removeListener(onPositionChange);
      controller!.dispose();

      if (widget.initPosition != null) {
        _currentPosition = widget.initPosition;
      }

      if (_currentPosition! > widget.itemCount! - 1) {
        _currentPosition = widget.itemCount! - 1;
        _currentPosition = _currentPosition !< 0 ? 0 : _currentPosition;
        if (widget.onPositionChange is ValueChanged<int>) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              widget.onPositionChange!(_currentPosition!);
            }
          });
        }
      }

      _currentCount = widget.itemCount;
      setState(() {
        controller = TabController(
          length: widget.itemCount!,
          vsync: this,
          initialIndex: _currentPosition!,
        );
        controller!.addListener(onPositionChange);
        controller!.animation!.addListener(onScroll);
      });
    } else if (widget.initPosition != null) {
      controller!.animateTo(widget.initPosition!);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller!.animation!.removeListener(onScroll);
    controller!.removeListener(onPositionChange);
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount! < 1) return widget.stub ?? Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: TabBar(
            isScrollable: true,
            controller: controller,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Theme.of(context).hintColor,
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
            ),
            tabs: List.generate(
              widget.itemCount!,
              (index) => widget.tabBuilder!(context, index),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: List.generate(
              widget.itemCount!,
              (index) => widget.pageBuilder!(context, index),
            ),
          ),
        ),
      ],
    );
  }

  onPositionChange() {
    if (!controller!.indexIsChanging) {
      _currentPosition = controller!.index;
      if (widget.onPositionChange is ValueChanged<int>) {
        widget.onPositionChange!(_currentPosition!);
      }
    }
  }

  onScroll() {
    if (widget.onScroll is ValueChanged<double>) {
      widget.onScroll!(controller!.animation!.value);
    }
  }
}
