import 'dart:convert';
import 'package:ez/screens/view/models/categories_model.dart';
import 'package:ez/screens/view/newUI/sub_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez/constant/global.dart';
import 'package:ez/constant/sizeconfig.dart';
import 'package:ez/screens/view/newUI/viewCategory.dart';
import 'package:http/http.dart' as http;

import '../models/MaterCategoryModel.dart';


class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<CategoriesScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  AllCateModel? collectionModal;

  @override
  void initState() {
  //  _getCollection();
    getMaterCategory();
    super.initState();
  }

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

  MaterCategoryModel? masterData;
  String? selectedMasterCategory;
  getMaterCategory()async{
    var headers = {
      'Cookie': 'ci_session=911aff6f1f7ad6b9772ceea1f8048b8a690650a5'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/get_master_category'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = MaterCategoryModel.fromJson(json.decode(finalResult));
      setState(() {
        masterData = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }
  Future<Null> refreshFunction()async{
    // await _getCollection();
    await getMaterCategory();

  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   // leading:  Padding(
        //   //   padding: const EdgeInsets.all(12),
        //   //   child: RawMaterialButton(
        //   //     shape: CircleBorder(),
        //   //     padding: const EdgeInsets.all(0),
        //   //     fillColor: Colors.white,
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
        //     'Categories',
        //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //   ),
        //   centerTitle: true,
        // ),
        body: RefreshIndicator(
          onRefresh: refreshFunction,
          child: masterData == null
              ? Center(
            child: CircularProgressIndicator(),
          )
              : masterData!.data!.length > 0
              ? Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              //physics: const NeverScrollableScrollPhysics(),
              itemCount: masterData!.data!.length,
              itemBuilder: (context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SubCategoryScreen(id: masterData!.data![index].id!, name: masterData!.data![index].categories!,image: masterData!.data![index].image , description: "", )
                        // ViewCategory(id: categories.id!, name: categories.cName!)
                      ),
                    );
                    // Navigator.push(
                    //   context,
                    //   CupertinoPageRoute(
                    //     builder: (context) => ViewCategory(
                    //       id: categories.id!,
                    //       name: categories.cName!,
                    //     ),
                    //   ),
                    // );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    child: new Card(
                      elevation: 1,
                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.white,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: Row(
                          children: <Widget>[
                            Container(width: 20),
                            Container(
                                height: 70,
                                width: 100 ,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    masterData!.data![index].image.toString(),
                                    fit: BoxFit.cover,
                                    // color: appColorWhite,
                                  ),
                                )),
                            Container(width: 20),
                            Container(
                              width: 160,
                              child: Text(
                                "${masterData!.data![index].categories}",
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'OpenSansBold',
                                    fontWeight: FontWeight.bold,
                                    color: appColorBlack),
                              ),
                            ),
                            Container(width: 20),
                          ],
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
              "Don't have any categories now",
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
    );
  }

  Widget widgetCatedata(Categories categories) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SubCategoryScreen(id: categories.id!, name: categories.cName!,image: categories.img,description: categories.description, )
            // ViewCategory(id: categories.id!, name: categories.cName!)
          ),
        );
        // Navigator.push(
        //   context,
        //   CupertinoPageRoute(
        //     builder: (context) => ViewCategory(
        //       id: categories.id!,
        //       name: categories.cName!,
        //     ),
        //   ),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: new Card(
          elevation: 1,
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Row(
              children: <Widget>[
                Container(width: 20),
                Container(
                    height: 70,
                    width: 100 ,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        categories.img!,
                        fit: BoxFit.cover,
                        // color: appColorWhite,
                      ),
                    )),
                Container(width: 20),
                Container(
                  width: 160,
                  child: Text(
                    categories.cName!,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'OpenSansBold',
                        fontWeight: FontWeight.bold,
                        color: appColorBlack),
                  ),
                ),
                Container(width: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
