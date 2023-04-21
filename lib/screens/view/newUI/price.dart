import 'dart:convert';

import 'package:ez/Helper/session.dart';
import 'package:ez/constant/global.dart';
import 'package:ez/screens/view/models/CityChargeModel.dart';
import 'package:ez/screens/view/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../models/NewCityModel.dart';

class Price extends StatefulWidget {
  const Price({Key? key}) : super(key: key);

  @override
  State<Price> createState() => _PriceState();
}

class _PriceState extends State<Price> {

  String? selectedCity;
  NewCityModel? cityModel;

  getCities()async{
    var headers = {
      'Cookie': 'ci_session=764831f866d7e814d7816088fd082fc369cffd1d'
    };
    var request = http.Request('POST', Uri.parse('https://developmentalphawizz.com/Kabadi/api/get_citiess'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse  = await response.stream.bytesToString();
      final jsonResponse = NewCityModel.fromJson(json.decode(finalResponse));
      print("finala response here ${jsonResponse.msg}");
      setState(() {
        cityModel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  AllCateModel? collectionModal;

  _getCollection() async {
    var uri = Uri.parse('${baseUrl()}/get_all_cat');
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
        collectionModal = AllCateModel.fromJson(userData);
      });
    }
    print(responseData);
  }

  CityChargeModel? cityCharge;

  getPriceData()async{
    var headers = {
      'Cookie': 'ci_session=94a91673ae9cd407c78149e33e69b5af6b0bce20'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/get_city_wise_charge'));
    request.fields.addAll({
      'cat_id':  catValue == null ? "0" :'${catValue.toString()}',
      //'city_id': '${selectedCity.toString()}'
      'city_id': userCity.toString(),
    });
    print('ooo ${request.fields.toString()}');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = CityChargeModel.fromJson(json.decode(finalResult));
      print("sds ${jsonResponse}");
      setState(() {
        cityCharge = jsonResponse;
      });
      print("checking api data here ${cityCharge!.msg} and ${cityCharge!.data.toString()}");
    }
    else {
      print(response.reasonPhrase);
    }

  }

  @override
  void initState() {
    super.initState();
    getCities();
    _getCollection();
  }


  List<Map<String, dynamic>> paper = [
    {"image": "assets/images/plasticWest.png", "name": "Paper", "price": "12/kg", "discountPrice" : "450"},
    {"image": "assets/images/paperWast.png", "name": "Carton" , "price": "10/kg", "discountPrice": "230"},
    {"image": "assets/images/metalWaste.jpg", "name": "Books", "price": "8/kg", "discountPrice" : "299"},
    {"image": "assets/images/eWast.jpg", "name": "Magazines" , "price": "6/kg", "discountPrice": "199"},
  ];
  List<Map<String, dynamic>> plastic = [
    {"image": "assets/images/plasticWest.png", "name": "Polyethylene Terephthalate", "price": "15/kg", "discountPrice" : "450"},
    {"image": "assets/images/paperWast.png", "name": "High-Density Polyethylene" , "price": "10/kg", "discountPrice": "230"},
    {"image": "assets/images/metalWaste.jpg", "name": "Polyvinyl Chloride", "price": "12/kg", "discountPrice" : "299"},
    {"image": "assets/images/eWast.jpg", "name": "Low-Density Polyethylene " , "price": "22/kg", "discountPrice": "199"},
  ];
  List<Map<String, dynamic>> metal = [
    {"image": "assets/images/plasticWest.png", "name": "Iron", "price": "11/kg", "discountPrice" : "450"},
    {"image": "assets/images/paperWast.png", "name": "Tin" , "price": "13/kg", "discountPrice": "230"},
    {"image": "assets/images/metalWaste.jpg", "name": "Lead", "price": "8/kg", "discountPrice" : "299"},
    {"image": "assets/images/eWast.jpg", "name": "Aluminium" , "price": "20/kg", "discountPrice": "199"},
  ];
  List<Map<String, dynamic>> ewaste = [
    {"image": "assets/images/plasticWest.png", "name": "Paper", "price": "5/kg", "discountPrice" : "450"},
    {"image": "assets/images/paperWast.png", "name": "Carton" , "price": "3/kg", "discountPrice": "230"},
    {"image": "assets/images/metalWaste.jpg", "name": "Books", "price": "15/kg", "discountPrice" : "299"},
    {"image": "assets/images/eWast.jpg", "name": "Magazines" , "price": "17/kg", "discountPrice": "199"},
  ];
  List<Map<String, dynamic>> other = [
    {"image": "assets/images/plasticWest.png", "name": "TV's, Monitor", "price": "20/kg", "discountPrice" : "450"},
    {"image": "assets/images/paperWast.png", "name": "LED bulbs." , "price": "12/kg", "discountPrice": "230"},
    {"image": "assets/images/metalWaste.jpg", "name": "Vending Machines", "price": "6/kg", "discountPrice" : "299"},
    {"image": "assets/images/eWast.jpg", "name": "Mobile Phones" , "price": "11/kg", "discountPrice": "199"},
  ];

  List<String> DummyList =[
    "paper",
    "plastic",
    "metal",
    "ewaste",
    "other"
  ];


  int? _currentIndex;
  String? catValue;
  _selectScrapType() {
    return
      Container(
        height: 500,
        width: 50,
        margin: EdgeInsets.only(top: 10,bottom: 10),
        child: collectionModal == null ? CircularProgressIndicator() : ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          itemCount: collectionModal!.categories!.length,
          itemBuilder: (context, index) {
            return   InkWell(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                  catValue = collectionModal!.categories![index].id.toString();
                });
                getPriceData();
                print("current index check here ${catValue}");
              },
              child: Container(
                height: 40,
                // width: 30,
                margin: EdgeInsets.only(right: 0,top: 10),
                decoration: BoxDecoration(
                    color: _currentIndex == index ? backgroundblack : appColorWhite,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "${collectionModal!.categories![index].cName}",
                    style: TextStyle(
                        color: _currentIndex == index
                            ? appColorWhite
                            : appColorGreen,
                        fontSize: 14),
                  ),
                ),
              ),
            );
            //   Wrap(
            //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     InkWell(
            //       onTap: () {
            //         setState(() {
            //           _currentIndex = 0;
            //         });
            //       },
            //       child: Container(
            //         height: 40,
            //         width: 60,
            //         decoration: BoxDecoration(
            //             color: _currentIndex == 0 ? backgroundblack : appColorWhite,
            //             borderRadius: BorderRadius.circular(10)),
            //         child: Center(
            //           child: Text(
            //             "Paper",
            //             style: TextStyle(
            //                 color: _currentIndex == 0
            //                     ? appColorWhite
            //                     : appColorGreen,
            //                 fontSize: 14),
            //           ),
            //         ),
            //       ),
            //     ),
            //     InkWell(
            //       onTap: () {
            //         setState(() {
            //           _currentIndex = 1;
            //         });
            //       },
            //       child: Container(
            //         height: 40,
            //         width: 60,
            //         decoration: BoxDecoration(
            //             color: _currentIndex == 1 ? backgroundblack : appColorWhite,
            //             borderRadius: BorderRadius.circular(10)),
            //         child: Center(
            //           child: Text(
            //             "Plastic",
            //             style: TextStyle(
            //                 color: _currentIndex == 1
            //                     ? appColorWhite
            //                     : appColorGreen,
            //                 fontSize: 14),
            //           ),
            //         ),
            //       ),
            //     ),
            //     InkWell(
            //       onTap: () {
            //         setState(() {
            //           _currentIndex = 2;
            //         });
            //       },
            //       child: Container(
            //         height: 40,
            //         width: 60,
            //         decoration: BoxDecoration(
            //             color: _currentIndex == 2 ? backgroundblack : appColorWhite,
            //             borderRadius: BorderRadius.circular(10)),
            //         child: Center(
            //           child: Text(
            //             "Metal",
            //             style: TextStyle(
            //                 color: _currentIndex == 2
            //                     ? appColorWhite
            //                     : appColorGreen,
            //                 fontSize: 14),
            //           ),
            //         ),
            //       ),
            //     ),
            //
            //     InkWell(
            //       onTap: () {
            //         setState(() {
            //           _currentIndex = 3;
            //         });
            //       },
            //       child: Container(
            //         height: 40,
            //         width: 60,
            //         decoration: BoxDecoration(
            //             color: _currentIndex == 3 ? backgroundblack : appColorWhite,
            //             borderRadius: BorderRadius.circular(10)),
            //         child: Center(
            //           child: Text(
            //             "E-waste",
            //             style: TextStyle(
            //                 color: _currentIndex == 3
            //                     ? appColorWhite
            //                     : appColorGreen,
            //                 fontSize: 14),
            //           ),
            //         ),
            //       ),
            //     ),
            //
            //     InkWell(
            //       onTap: () {
            //         setState(() {
            //           _currentIndex = 4;
            //         });
            //       },
            //       child: Container(
            //         height: 40,
            //         width: 60,
            //         decoration: BoxDecoration(
            //             color: _currentIndex == 4 ? backgroundblack : appColorWhite,
            //             borderRadius: BorderRadius.circular(10)),
            //         child: Center(
            //           child: Text(
            //             "Other",
            //             style: TextStyle(
            //                 color: _currentIndex == 4
            //                     ? appColorWhite
            //                     : appColorGreen,
            //                 fontSize: 14),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // );
          },
        ),
      );
    //   Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
    //   child: Wrap(
    //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       InkWell(
    //         onTap: () {
    //           setState(() {
    //             _currentIndex = 0;
    //           });
    //         },
    //         child: Container(
    //           height: 40,
    //           width: 60,
    //           decoration: BoxDecoration(
    //               color: _currentIndex == 0 ? backgroundblack : appColorWhite,
    //               borderRadius: BorderRadius.circular(10)),
    //           child: Center(
    //             child: Text(
    //               "Paper",
    //               style: TextStyle(
    //                   color: _currentIndex == 0
    //                       ? appColorWhite
    //                       : appColorGreen,
    //                   fontSize: 14),
    //             ),
    //           ),
    //         ),
    //       ),
    //       InkWell(
    //         onTap: () {
    //           setState(() {
    //             _currentIndex = 1;
    //           });
    //         },
    //         child: Container(
    //           height: 40,
    //           width: 60,
    //           decoration: BoxDecoration(
    //               color: _currentIndex == 1 ? backgroundblack : appColorWhite,
    //               borderRadius: BorderRadius.circular(10)),
    //           child: Center(
    //             child: Text(
    //               "Plastic",
    //               style: TextStyle(
    //                   color: _currentIndex == 1
    //                       ? appColorWhite
    //                       : appColorGreen,
    //                   fontSize: 14),
    //             ),
    //           ),
    //         ),
    //       ),
    //       InkWell(
    //         onTap: () {
    //           setState(() {
    //             _currentIndex = 2;
    //           });
    //         },
    //         child: Container(
    //           height: 40,
    //           width: 60,
    //           decoration: BoxDecoration(
    //               color: _currentIndex == 2 ? backgroundblack : appColorWhite,
    //               borderRadius: BorderRadius.circular(10)),
    //           child: Center(
    //             child: Text(
    //               "Metal",
    //               style: TextStyle(
    //                   color: _currentIndex == 2
    //                       ? appColorWhite
    //                       : appColorGreen,
    //                   fontSize: 14),
    //             ),
    //           ),
    //         ),
    //       ),
    //
    //       InkWell(
    //         onTap: () {
    //           setState(() {
    //             _currentIndex = 3;
    //           });
    //         },
    //         child: Container(
    //           height: 40,
    //           width: 60,
    //           decoration: BoxDecoration(
    //               color: _currentIndex == 3 ? backgroundblack : appColorWhite,
    //               borderRadius: BorderRadius.circular(10)),
    //           child: Center(
    //             child: Text(
    //               "E-waste",
    //               style: TextStyle(
    //                   color: _currentIndex == 3
    //                       ? appColorWhite
    //                       : appColorGreen,
    //                   fontSize: 14),
    //             ),
    //           ),
    //         ),
    //       ),
    //
    //       InkWell(
    //         onTap: () {
    //           setState(() {
    //             _currentIndex = 4;
    //           });
    //         },
    //         child: Container(
    //           height: 40,
    //           width: 60,
    //           decoration: BoxDecoration(
    //               color: _currentIndex == 4 ? backgroundblack : appColorWhite,
    //               borderRadius: BorderRadius.circular(10)),
    //           child: Center(
    //             child: Text(
    //               "Other",
    //               style: TextStyle(
    //                   color: _currentIndex == 4
    //                       ? appColorWhite
    //                       : appColorGreen,
    //                   fontSize: 14),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget paperWidget() {
    return Expanded(
      child: Container(
        color: backgroundgrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 10),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 3.1,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5

                    ),
                    itemCount: paper.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        elevation: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: 110,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6)),
                                    child: Image.asset(
                                      "${paper[index]['image']}",
                                      fit: BoxFit.fill,))),
                            Container(height: 5,),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: Text("${paper[index]["name"]}", style: TextStyle(

                                  fontSize: 14, fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: Row(
                                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  // SizedBox(width: 10,),
                                  Text("\u{20B9} ${paper[index]["price"]}",style: TextStyle(fontWeight: FontWeight.bold,)
                                    ,),
                                ],
                              ),
                            ),


                          ],
                        ),
                      );

                    }),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 10),
            //   child: GridView.builder(
            //     // crossAxisCount: 2,
            //     // crossAxisSpacing: 5,
            //     physics: ScrollPhysics(),
            //     // childAspectRatio: 3 / 3.5,
            //     // mainAxisSpacing: 8.0,
            //     shrinkWrap: true,
            //       , gridDelegate: null,@override
            //       Widget build(BuildContext context) {
            // return ;
            // }
            //
            // ),

            Container(height: 10),
          ],
        ),
      ),
    );
  }

  Widget plasticWidget() {
    return Expanded(
      child: Container(
        color: backgroundgrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 10),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3/3.1,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5
                    ),
                    itemCount: plastic.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        elevation: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height:110,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6)),
                                    child: Image.asset(
                                      "${plastic[index]['image']}",
                                      fit: BoxFit.fill,))),
                            Container(height: 2,),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: Text("${plastic[index]["name"]}", style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),maxLines: 1,),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: Row(
                                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("\u{20B9} ${plastic[index]["price"]}",style: TextStyle(fontWeight: FontWeight.bold,)
                                    ,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 10),
            //   child: GridView.builder(
            //     // crossAxisCount: 2,
            //     // crossAxisSpacing: 5,
            //     physics: ScrollPhysics(),
            //     // childAspectRatio: 3 / 3.5,
            //     // mainAxisSpacing: 8.0,
            //     shrinkWrap: true,
            //       , gridDelegate: null,@override
            //       Widget build(BuildContext context) {
            // return ;
            // }
            //
            // ),
            Container(height: 10),
          ],
        ),
      ),
    );
  }

  Widget metalWidget() {
    return Expanded(
      child: Container(
        color: backgroundgrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3/3.1,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5
                    ),
                    itemCount: metal.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        elevation: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: 110,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6)),
                                    child: Image.asset(
                                      "${metal[index]['image']}",
                                      fit: BoxFit.fill,))),
                            Container(height: 2,),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: Text("${metal[index]["name"]}", style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),maxLines: 1,),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: Row(
                                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("\u{20B9} ${metal[index]["price"]}",style: TextStyle(fontWeight: FontWeight.bold,)
                                    ,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );

                    }),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 10),
            //   child: GridView.builder(
            //     // crossAxisCount: 2,
            //     // crossAxisSpacing: 5,
            //     physics: ScrollPhysics(),
            //     // childAspectRatio: 3 / 3.5,
            //     // mainAxisSpacing: 8.0,
            //     shrinkWrap: true,
            //       , gridDelegate: null,@override
            //       Widget build(BuildContext context) {
            // return ;
            // }
            //
            // ),

            Container(height: 10),
          ],
        ),
      ),
    );
  }

  Widget ewasteWidget() {
    return Expanded(
      child: Container(
        color: backgroundgrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 10),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3/3.1,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5

                    ),
                    itemCount: ewaste.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        elevation: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height:110,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6)),
                                    child: Image.asset(
                                      "${ewaste[index]['image']}",
                                      fit: BoxFit.fill,))),
                            Container(height: 2,),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: Text("${ewaste[index]["name"]}", style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),maxLines: 1,),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: Row(
                                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Text("\u{20B9} ${ewaste[index]["price"]}",style: TextStyle(fontWeight: FontWeight.bold,)
                                    ,),
                                ],
                              ),
                            ),


                          ],
                        ),
                      );

                    }),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 10),
            //   child: GridView.builder(
            //     // crossAxisCount: 2,
            //     // crossAxisSpacing: 5,
            //     physics: ScrollPhysics(),
            //     // childAspectRatio: 3 / 3.5,
            //     // mainAxisSpacing: 8.0,
            //     shrinkWrap: true,
            //       , gridDelegate: null,@override
            //       Widget build(BuildContext context) {
            // return ;
            // }
            //
            // ),

            Container(height: 10),
          ],
        ),
      ),
    );
  }
  Widget otherWidget() {
    return Expanded(
      child: Container(
        color: backgroundgrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 10),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3/3.1,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5

                    ),
                    itemCount: other.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        elevation: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height:110,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6)),
                                    child: Image.asset(
                                      "${other[index]['image']}",
                                      fit: BoxFit.fill,))),
                            Container(height: 2,),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: Text("${other[index]["name"]}", style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),maxLines: 1,),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: Row(
                                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("\u{20B9} ${other[index]["price"]}",style: TextStyle(fontWeight: FontWeight.bold,)
                                    ,),
                                ],
                              ),
                            ),


                          ],
                        ),
                      );

                    }),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 10),
            //   child: GridView.builder(
            //     // crossAxisCount: 2,
            //     // crossAxisSpacing: 5,
            //     physics: ScrollPhysics(),
            //     // childAspectRatio: 3 / 3.5,
            //     // mainAxisSpacing: 8.0,
            //     shrinkWrap: true,
            //       , gridDelegate: null,@override
            //       Widget build(BuildContext context) {
            // return ;
            // }
            //
            // ),

            Container(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundgrey,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   // leading:  Padding(
      //   //   padding: const EdgeInsets.all(12),
      //   //   child: RawMaterialButton(
      //   //     shape: CircleBorder(),
      //   //     padding: const EdgeInsets.all(0),
      //   //     fillColor: appColorWhitee,
      //   //     splashColor: Colors.grey[400],
      //   //     child: Icon(
      //   //       Icons.arrow_back,
      //   //       size: 20,
      //   //       color: appColorBlack,
      //   //     ),
      //   //     onPressed: () {
      //   //       Navigator.pop(context);
      //   //     },
      //   //   ),
      //   // ),
      //   backgroundColor: backgroundblack,
      //   elevation: 2,
      //   shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.only(
      //           bottomLeft: Radius.circular(20),
      //           bottomRight: Radius.circular(20)
      //       )
      //   ),
      //   title: Text(
      //     'Price',
      //     style: TextStyle(color: appColorWhite, fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      // ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          // cityModel == null ? Container(child: CircularProgressIndicator(),) :
          // Container(
          //      height: 65,
          //      alignment: Alignment.centerLeft,
          //      padding: EdgeInsets.only(left: 10),
          //      margin: EdgeInsets.symmetric(horizontal: 27),
          //      decoration: BoxDecoration(
          //          borderRadius: BorderRadius.circular(15),
          //          border: Border.all(color: appColorBlack.withOpacity(0.3))
          //      ),
          //      child: DropdownButton(
          //        // Initial Value
          //        value: selectedCity,
          //        underline: Container(),
          //        // Down Arrow Icon
          //        icon: Icon(Icons.keyboard_arrow_down),
          //        hint: Container(
          //            width: MediaQuery.of(context).size.width/1.4,
          //            child: Text("Select city")),
          //        // Array list of items
          //        items: cityModel!.data!.map((items) {
          //          return DropdownMenuItem(
          //            value: items.id,
          //            child: Container(
          //                child: Text(items.name.toString())),
          //          );
          //        }).toList(),
          //        // After selecting the desired option,it will
          //        // change button value to selected value
          //        onChanged: (String? newValue) {
          //          setState(() {
          //
          //            selectedCity = newValue!;
          //            // getSubCategory();
          //            print("selected city ${selectedCity}");
          //            getPriceData();
          //          });
          //        },
          //      ),
          //    ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                height: 500,
                width: 80,
                margin: EdgeInsets.only(top: 10,bottom: 10,left: 10),
                child: collectionModal == null ? Container(child: Center(child: CircularProgressIndicator(),),) : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  itemCount: collectionModal!.categories!.length,
                  itemBuilder: (context, index) {
                    return   InkWell(
                      onTap: () {
                        setState(() {
                          _currentIndex = index;
                          catValue = collectionModal!.categories![index].id.toString();
                        });
                        getPriceData();
                        print("current index check here ${catValue}");
                      },
                      child: Container(
                        height: 100,
                        // width: 30,
                        margin: EdgeInsets.only(right: 0,top: 10),
                        decoration: BoxDecoration(
                            color: _currentIndex == index ? backgroundblack : appColorWhite,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Container(
                              height:70,
                              width: 80,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network("${collectionModal!.categories![index].img}",fit: BoxFit.fill,)),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "${collectionModal!.categories![index].cName}",
                              style: TextStyle(
                                  color: _currentIndex == index
                                      ? appColorWhite
                                      : appColorGreen,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    );
                    //   Wrap(
                    //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     InkWell(
                    //       onTap: () {
                    //         setState(() {
                    //           _currentIndex = 0;
                    //         });
                    //       },
                    //       child: Container(
                    //         height: 40,
                    //         width: 60,
                    //         decoration: BoxDecoration(
                    //             color: _currentIndex == 0 ? backgroundblack : appColorWhite,
                    //             borderRadius: BorderRadius.circular(10)),
                    //         child: Center(
                    //           child: Text(
                    //             "Paper",
                    //             style: TextStyle(
                    //                 color: _currentIndex == 0
                    //                     ? appColorWhite
                    //                     : appColorGreen,
                    //                 fontSize: 14),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     InkWell(
                    //       onTap: () {
                    //         setState(() {
                    //           _currentIndex = 1;
                    //         });
                    //       },
                    //       child: Container(
                    //         height: 40,
                    //         width: 60,
                    //         decoration: BoxDecoration(
                    //             color: _currentIndex == 1 ? backgroundblack : appColorWhite,
                    //             borderRadius: BorderRadius.circular(10)),
                    //         child: Center(
                    //           child: Text(
                    //             "Plastic",
                    //             style: TextStyle(
                    //                 color: _currentIndex == 1
                    //                     ? appColorWhite
                    //                     : appColorGreen,
                    //                 fontSize: 14),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     InkWell(
                    //       onTap: () {
                    //         setState(() {
                    //           _currentIndex = 2;
                    //         });
                    //       },
                    //       child: Container(
                    //         height: 40,
                    //         width: 60,
                    //         decoration: BoxDecoration(
                    //             color: _currentIndex == 2 ? backgroundblack : appColorWhite,
                    //             borderRadius: BorderRadius.circular(10)),
                    //         child: Center(
                    //           child: Text(
                    //             "Metal",
                    //             style: TextStyle(
                    //                 color: _currentIndex == 2
                    //                     ? appColorWhite
                    //                     : appColorGreen,
                    //                 fontSize: 14),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //
                    //     InkWell(
                    //       onTap: () {
                    //         setState(() {
                    //           _currentIndex = 3;
                    //         });
                    //       },
                    //       child: Container(
                    //         height: 40,
                    //         width: 60,
                    //         decoration: BoxDecoration(
                    //             color: _currentIndex == 3 ? backgroundblack : appColorWhite,
                    //             borderRadius: BorderRadius.circular(10)),
                    //         child: Center(
                    //           child: Text(
                    //             "E-waste",
                    //             style: TextStyle(
                    //                 color: _currentIndex == 3
                    //                     ? appColorWhite
                    //                     : appColorGreen,
                    //                 fontSize: 14),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //
                    //     InkWell(
                    //       onTap: () {
                    //         setState(() {
                    //           _currentIndex = 4;
                    //         });
                    //       },
                    //       child: Container(
                    //         height: 40,
                    //         width: 60,
                    //         decoration: BoxDecoration(
                    //             color: _currentIndex == 4 ? backgroundblack : appColorWhite,
                    //             borderRadius: BorderRadius.circular(10)),
                    //         child: Center(
                    //           child: Text(
                    //             "Other",
                    //             style: TextStyle(
                    //                 color: _currentIndex == 4
                    //                     ? appColorWhite
                    //                     : appColorGreen,
                    //                 fontSize: 14),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // );
                  },
                ),
              ),
              Expanded(
                child: cityCharge == null ? Center(child: Text("${getTranslated(context, 'noDataToShow')}"),) :
                Container(
                  color: backgroundgrey,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      child: cityCharge!.data!.isEmpty ? Container(
                          height: 250,

                          child: Center(child: Text("${getTranslated(context, 'noDataToShow')}"),)): GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: ScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 4 / 5.8,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5
                          ),
                          itemCount: cityCharge!.data!.length,
                          itemBuilder: (BuildContext ctx, index) {

                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)
                              ),
                              elevation: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      height: 100,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(6),
                                              topRight: Radius.circular(6)),
                                          child: Image.network(
                                            "${imageUrl()}${cityCharge!.data![index].img}",
                                            fit: BoxFit.fill,))),
                                  Container(height: 5,),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 3),
                                    child: Text("${cityCharge!.data![index].subTitle}", style: TextStyle(

                                        fontSize: 14, fontWeight: FontWeight.bold),),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 3),
                                    child: Row(
                                      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        // SizedBox(width: 10,),
                                        Text("\u{20B9} ${cityCharge!.data![index].charge}",style: TextStyle(fontWeight: FontWeight.bold,)
                                          ,),
                                      ],
                                    ),
                                  ),


                                ],
                              ),
                            );

                          }),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
