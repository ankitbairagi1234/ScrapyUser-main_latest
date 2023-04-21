import 'dart:convert';
import 'package:ez/screens/view/models/catModel.dart';
import 'package:ez/screens/view/models/categories_model.dart';
import 'package:ez/screens/view/newUI/filterPage.dart';
import 'package:ez/screens/view/newUI/subCategoryScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez/constant/global.dart';
import 'package:ez/screens/view/newUI/detail.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;

// ignore: must_be_immutable
class ViewCategory extends StatefulWidget {
  String? id;
  String? vid;
  String? name;
  String? catId;
  String? cid;
  String? selectedValue1,selectedValueName1,selectedValue2,selectedValueName2;
  bool fromSeller;

  ViewCategory(
      {this.id,
      this.cid,
        this.selectedValue2,
        this.selectedValueName2,
        this.selectedValue1,
        this.selectedValueName1,
      this.name,
      this.catId,
      required this.fromSeller,
      this.vid});
  @override
  _ServiceTabState createState() => _ServiceTabState();
}

class _ServiceTabState extends State<ViewCategory> {
  bool isLoading = false;
  CatModal catModal = CatModal();
  String? selectedValue;
  List itemsList = [
    {"id": "1", "name": "Price low to high"},
    {"id": "2", "name": "Price high to low"},
    {"id": "3", "name": "Newest"}
  ];
  @override
  void initState() {
    super.initState();
    getResidential();
    _getCollection();
  }

  Future<Null> refreshFunction() async {
    await getResidential();
  }

  bool isTapped = false;
  int counter =1;
  RangeValues _currentRangeValues = const RangeValues(40, 80);
  getResidential() async {
    print("from seller ${widget.fromSeller}");
    // try {
    Map<String, String> headers = {
      'content-type': 'application/x-www-form-urlencoded',
    };
    var map = new Map<String, dynamic>();
    if (widget.fromSeller) {
      map['vid'] = widget.vid;
      map['cat_id'] = widget.catId ?? "0";
      map['s_cat_id'] = widget.id ?? "0";
      map['sort_by'] = selectedValue.toString() ?? "0";
      map['min_price'] = _startValue.toString() ?? "0";
      map['max_price'] = _endValue.toString() ?? "0";
    } else {
      map['cid'] = widget.cid == null ? "" : widget.cid;
      map['cat_id'] = widget.catId ?? "";
      map['s_cat_id'] = widget.id ?? "";
      map['sort_by'] = selectedValue.toString() ?? "0";
      map['min_price'] = _startValue.toString() ?? "0";
      map['max_price'] = _endValue.toString() ?? "0";
    }
    final response = await client.post(Uri.parse("${baseUrl()}/get_cat_res"),
        headers: headers, body: map);
    var dic = json.decode(response.body);
    print("${baseUrl()}/get_cat_res");
    Map<String, dynamic> userMap = jsonDecode(response.body);
    setState(() {
      catModal = CatModal.fromJson(userMap);
    });
    print(">>>>>>");
    print(map);
    // } on Exception {
    //   Fluttertoast.showToast(msg: "No Internet connection");
    //   throw Exception('No Internet connection');
    // }
  }

  double _startValue = 100.0;
  double _endValue = 10000.0;

  AllCateModel? collectionModal;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundblack,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        // bottom:
        title: widget.name == null
            ? SizedBox.shrink()
            : Text(
                "${widget.name!.toUpperCase()}",
                style: TextStyle(color: appColorWhite),
              ),
        centerTitle: true,
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
      ),
      body: RefreshIndicator(
          onRefresh: refreshFunction,
          child: collectionModal == null
              ? Center(
                  child: Text(
                    "No services to show",
                    style: TextStyle(
                        fontSize: 16,
                        color: appColorBlack,
                        fontWeight: FontWeight.w500),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ListView(
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     InkWell(
                      //       onTap: () {
                      //         showModalBottomSheet(
                      //             context: context,
                      //             builder: (context) {
                      //               return StatefulBuilder(builder:
                      //                   (BuildContext context,
                      //                       StateSetter setState) {
                      //                 return Container(
                      //                   decoration: BoxDecoration(
                      //                     borderRadius: BorderRadius.only(
                      //                         topLeft: Radius.circular(10),
                      //                         topRight: Radius.circular(10)),
                      //                   ),
                      //                   padding: EdgeInsets.symmetric(
                      //                       horizontal: 12, vertical: 15),
                      //                   child: Column(
                      //                     mainAxisSize: MainAxisSize.min,
                      //                     children: [
                      //                       Text(
                      //                         "Filter by price",
                      //                         style: TextStyle(
                      //                             color: appColorBlack,
                      //                             fontSize: 16,
                      //                             fontWeight: FontWeight.w500),
                      //                       ),
                      //                       SizedBox(
                      //                         height: 10,
                      //                       ),
                      //                       RangeSlider(
                      //                         divisions: 20,
                      //                         activeColor: backgroundblack,
                      //                         labels: RangeLabels(
                      //                           _startValue.round().toString(),
                      //                           _endValue.round().toString(),
                      //                         ),
                      //                         min: 100,
                      //                         max: 10000,
                      //                         values: RangeValues(
                      //                             _startValue, _endValue),
                      //                         onChanged: (values) {
                      //                           setState(() {
                      //                             _startValue = values.start;
                      //                             _endValue = values.end;
                      //                           });
                      //                         },
                      //                       ),
                      //                       // Container(
                      //                       //   decoration: BoxDecoration(
                      //                       //       borderRadius:
                      //                       //       BorderRadius.circular(10),
                      //                       //       border: Border.all(
                      //                       //           color: appColorBlack
                      //                       //               .withOpacity(0.5))),
                      //                       //   child: DropdownButton(
                      //                       //     value: selectedValue,
                      //                       //     underline: Container(),
                      //                       //     icon: Container(
                      //                       //         alignment: Alignment.centerRight,
                      //                       //         width: MediaQuery.of(context)
                      //                       //             .size
                      //                       //             .width /
                      //                       //             1.8,
                      //                       //         child: Padding(
                      //                       //           padding:
                      //                       //           EdgeInsets.only(right: 10),
                      //                       //           child: Icon(
                      //                       //               Icons.keyboard_arrow_down),
                      //                       //         )),
                      //                       //     hint: Padding(
                      //                       //       padding: EdgeInsets.only(left: 5),
                      //                       //       child: Text("Sort by"),
                      //                       //     ),
                      //                       //     items: itemsList.map((items) {
                      //                       //       return DropdownMenuItem(
                      //                       //         value: items['id'],
                      //                       //         child: Padding(
                      //                       //           padding:
                      //                       //           EdgeInsets.only(left: 5),
                      //                       //           child: Text(
                      //                       //               items['name'].toString()),
                      //                       //         ),
                      //                       //       );
                      //                       //     }).toList(),
                      //                       //     onChanged: ( newValue) {
                      //                       //       setState(() {
                      //                       //         selectedValue = newValue.toString();
                      //                       //         print(
                      //                       //             "selected value is ${selectedValue}");
                      //                       //       });
                      //                       //     },
                      //                       //   ),
                      //                       // ),
                      //                       //   SizedBox(height: 20,),
                      //                       // Text("Price Range",style: TextStyle(color: appColorBlack,fontSize: 15,fontWeight: FontWeight.w500),),
                      //                       // Slider(
                      //                       //   label: "price",
                      //                       //   min: 00.0,
                      //                       //   max: 100.0,
                      //                       //   value: _value.toDouble(),
                      //                       //   onChanged: (value) {
                      //                       //     setState(() {
                      //                       //       _value = value.toInt();
                      //                       //     });
                      //                       //   },
                      //                       // ),
                      //                       SizedBox(
                      //                         height: 50,
                      //                       ),
                      //                       Row(
                      //                         mainAxisAlignment:
                      //                             MainAxisAlignment.center,
                      //                         children: [
                      //                           InkWell(
                      //                             onTap: () {
                      //                               setState(() {
                      //                                 getResidential();
                      //                               });
                      //                               Navigator.of(context).pop();
                      //                             },
                      //                             child: Container(
                      //                               width: 100,
                      //                               height: 40,
                      //                               alignment: Alignment.center,
                      //                               decoration: BoxDecoration(
                      //                                 color: backgroundblack,
                      //                                 borderRadius:
                      //                                     BorderRadius.circular(
                      //                                         10),
                      //                               ),
                      //                               child: Text(
                      //                                 "Apply",
                      //                                 style: TextStyle(
                      //                                     color: appColorWhite,
                      //                                     fontSize: 16,
                      //                                     fontWeight:
                      //                                         FontWeight.w600),
                      //                               ),
                      //                             ),
                      //                           ),
                      //                         ],
                      //                       ),
                      //                       // Expanded(child: Slider(value: _value.toDouble(),onChanged: (double newValue){
                      //                       //   setState(() {
                      //                       //     _value = newValue.toInt();
                      //                       //   });
                      //                       // }))
                      //                     ],
                      //                   ),
                      //                 );
                      //               });
                      //             });
                      //       },
                      //       child: Container(
                      //         width: 100,
                      //         padding: EdgeInsets.symmetric(vertical: 6),
                      //         decoration: BoxDecoration(
                      //             color: backgroundblack,
                      //             borderRadius: BorderRadius.circular(8)),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Icon(
                      //               Icons.filter_list,
                      //               color: appColorWhite,
                      //             ),
                      //             Text(
                      //               "Filter",
                      //               style: TextStyle(color: appColorWhite),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     InkWell(
                      //       onTap: () {
                      //         showModalBottomSheet(
                      //             context: context,
                      //             builder: (context) {
                      //               return StatefulBuilder(builder:
                      //                   (BuildContext context,
                      //                       StateSetter setState) {
                      //                 return Container(
                      //                   decoration: BoxDecoration(
                      //                     borderRadius: BorderRadius.only(
                      //                         topLeft: Radius.circular(10),
                      //                         topRight: Radius.circular(10)),
                      //                   ),
                      //                   padding: EdgeInsets.symmetric(
                      //                       horizontal: 12, vertical: 15),
                      //                   child: Column(
                      //                     mainAxisSize: MainAxisSize.min,
                      //                     children: [
                      //                       Text(
                      //                         "Sort By",
                      //                         style: TextStyle(
                      //                             color: appColorBlack,
                      //                             fontSize: 16,
                      //                             fontWeight: FontWeight.w500),
                      //                       ),
                      //                       SizedBox(
                      //                         height: 10,
                      //                       ),
                      //                       Container(
                      //                         decoration: BoxDecoration(
                      //                             borderRadius:
                      //                                 BorderRadius.circular(10),
                      //                             border: Border.all(
                      //                                 color: appColorBlack
                      //                                     .withOpacity(0.5))),
                      //                         child: DropdownButton(
                      //                           value: selectedValue,
                      //                           underline: Container(),
                      //                           icon: Container(
                      //                               alignment:
                      //                                   Alignment.centerRight,
                      //                               width:
                      //                                   MediaQuery.of(context)
                      //                                           .size
                      //                                           .width /
                      //                                       1.8,
                      //                               child: Padding(
                      //                                 padding: EdgeInsets.only(
                      //                                     right: 10),
                      //                                 child: Icon(Icons
                      //                                     .keyboard_arrow_down),
                      //                               )),
                      //                           hint: Padding(
                      //                             padding:
                      //                                 EdgeInsets.only(left: 5),
                      //                             child: Text("Sort by"),
                      //                           ),
                      //                           items: itemsList.map((items) {
                      //                             return DropdownMenuItem(
                      //                               value: items['id'],
                      //                               child: Padding(
                      //                                 padding: EdgeInsets.only(
                      //                                     left: 5),
                      //                                 child: Text(items['name']
                      //                                     .toString()),
                      //                               ),
                      //                             );
                      //                           }).toList(),
                      //                           onChanged: (newValue) {
                      //                             setState(() {
                      //                               selectedValue =
                      //                                   newValue.toString();
                      //                               print(
                      //                                   "selected value is ${selectedValue}");
                      //                             });
                      //                           },
                      //                         ),
                      //                       ),
                      //                       //   SizedBox(height: 20,),
                      //                       // Text("Price Range",style: TextStyle(color: appColorBlack,fontSize: 15,fontWeight: FontWeight.w500),),
                      //                       // Slider(
                      //                       //   label: "price",
                      //                       //   min: 00.0,
                      //                       //   max: 100.0,
                      //                       //   value: _value.toDouble(),
                      //                       //   onChanged: (value) {
                      //                       //     setState(() {
                      //                       //       _value = value.toInt();
                      //                       //     });
                      //                       //   },
                      //                       // ),
                      //                       SizedBox(
                      //                         height: 50,
                      //                       ),
                      //                       Row(
                      //                         mainAxisAlignment:
                      //                             MainAxisAlignment.center,
                      //                         children: [
                      //                           InkWell(
                      //                             onTap: () {
                      //                               setState(() {
                      //                                 getResidential();
                      //                               });
                      //                               Navigator.of(context).pop();
                      //                             },
                      //                             child: Container(
                      //                               width: 100,
                      //                               height: 40,
                      //                               alignment: Alignment.center,
                      //                               decoration: BoxDecoration(
                      //                                 color: backgroundblack,
                      //                                 borderRadius:
                      //                                     BorderRadius.circular(
                      //                                         10),
                      //                               ),
                      //                               child: Text(
                      //                                 "Apply",
                      //                                 style: TextStyle(
                      //                                     color: appColorWhite,
                      //                                     fontSize: 16,
                      //                                     fontWeight:
                      //                                         FontWeight.w600),
                      //                               ),
                      //                             ),
                      //                           ),
                      //                         ],
                      //                       ),
                      //                       // Expanded(child: Slider(value: _value.toDouble(),onChanged: (double newValue){
                      //                       //   setState(() {
                      //                       //     _value = newValue.toInt();
                      //                       //   });
                      //                       // }))
                      //                     ],
                      //                   ),
                      //                 );
                      //               });
                      //             });
                      //         //Navigator.push(context, MaterialPageRoute(builder: (context) => FilterPage()));
                      //       },
                      //       child: Container(
                      //         width: 100,
                      //         padding: EdgeInsets.symmetric(vertical: 6),
                      //         decoration: BoxDecoration(
                      //             color: backgroundblack,
                      //             borderRadius: BorderRadius.circular(8)),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Icon(
                      //               Icons.sort,
                      //               color: appColorWhite,
                      //             ),
                      //             Text(
                      //               "Sort by",
                      //               style: TextStyle(color: appColorWhite),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      bestSellerItems(context),
                    ],
                  ),
                )),
    );
  }

  Widget bestSellerItems(BuildContext context) {
    return collectionModal!.categories!.length != 0
        ? GridView.builder(
            shrinkWrap: true,
            //physics: NeverScrollableScrollPhysics(),
            primary: false,
            padding: EdgeInsets.all(10),
            itemCount: collectionModal!.categories!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 120 / 125,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 10.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => DetailScreen(
                    //             resId: collectionModal!.categories![index].id,
                    //           )),
                    // );
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SubCategoryScreen1(id: collectionModal!.categories![index].id.toString(),
                      name: collectionModal!.categories![index].cName.toString(),
                      selectedValue1: widget.selectedValue1,
                      selectedValueName1: widget.selectedValueName1,
                      selectedValue2: widget.selectedValue2,
                      selectedValueName2: widget.selectedValueName2,
                      selectedValue3: collectionModal!.categories![index].id,
                      selectedValueName3: collectionModal!.categories![index].cName,
                    )));
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: 210,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10)),
                              image: DecorationImage(
                                image: NetworkImage(collectionModal!.categories![index].img.toString()),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12,left: 8,right: 8,bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 85,
                                      child: Text(
                                        collectionModal!.categories![index].cName![0].toUpperCase() +
                                            collectionModal!.categories![index].cName!
                                                .substring(1),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            height: 1.2,
                                            color: appColorBlack,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    // Text(
                                    //     "${catModal.restaurants![index].cityName}"),
                                  ],
                                ),
                                Container(height: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Container(
                                    //   width: 110,
                                    //   child: Text(
                                    //     catModal!
                                    //         .restaurants![index].resDesc!,
                                    //     maxLines: 1,
                                    //     overflow: TextOverflow.ellipsis,
                                    //     style: TextStyle(
                                    //         color: appColorBlack,
                                    //         fontSize: 12,
                                    //         fontWeight: FontWeight.normal),
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Text(
                                        //   "₹" +
                                        //   collectionModal!.categories![index].,
                                        //   style: TextStyle(
                                        //       color: appColorBlack,
                                        //       fontSize: 16,
                                        //       fontWeight: FontWeight.bold),
                                        // ),
                                        // Container(
                                        //   width: 90,
                                        //   decoration: BoxDecoration(
                                        //
                                        //     borderRadius: BorderRadius.circular(8)
                                        //   ),
                                        //   child: Card(
                                        //     elevation: 1,
                                        //     child: Row(
                                        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        //       children: [
                                        //         InkWell(
                                        //             onTap: (){
                                        //               setState(() {
                                        //                 counter--;
                                        //               });
                                        //             },
                                        //             child: Icon(Icons.remove,color: Colors.black,)),
                                        //         Text("0"),
                                        //         InkWell(
                                        //             onTap: (){
                                        //               setState(() {
                                        //                 counter++;
                                        //               });
                                        //               print("");
                                        //             },
                                        //             child: Icon(Icons.add,color: Colors.black,)),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                        // InkWell(
                                        //     onTap: (){
                                        //       setState(() {
                                        //         isTapped = true;
                                        //       });
                                        //     },
                                        //     child: Icon(Icons.shopping_cart_sharp,color: backgroundblack,)),
                                        // RatingBar.builder(
                                        //   initialRating: catModal
                                        //               .restaurants![index]
                                        //               .resRating ==
                                        //           ""
                                        //       ? 0.0
                                        //       : double.parse(catModal
                                        //           .restaurants![index].resRating
                                        //           .toString()),
                                        //   minRating: 0,
                                        //   direction: Axis.horizontal,
                                        //   allowHalfRating: true,
                                        //   itemCount: 5,
                                        //   itemSize: 15,
                                        //   ignoreGestures: true,
                                        //   unratedColor: Colors.grey,
                                        //   itemBuilder: (context, _) => Icon(
                                        //       Icons.star,
                                        //       color: appColorOrange),
                                        //   onRatingUpdate: (rating) {
                                        //     print(rating);
                                        //   },
                                        // ),
                                      ],
                                    ),
                                    //   Text("Book Service",style: TextStyle(color: backgroundblack,fontWeight: FontWeight.w600,),)

                                    // Container(
                                    //   child: Padding(
                                    //       padding: EdgeInsets.all(0),
                                    //       child: Text(
                                    //         "BOOK NOW",
                                    //         style: TextStyle(
                                    //             color: Colors.blue,
                                    //             fontSize: 12),
                                    //       )),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : Container(
            height: 100,
            child: Center(
              child: Text(
                "No Services Available",
                style: TextStyle(
                  color: appColorBlack,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          );
  }
}
