import 'dart:convert';
import 'dart:io';

import 'package:ez/Helper/session.dart';
import 'package:ez/screens/view/models/getServiceChargeModel.dart';
import 'package:ez/screens/view/models/getUserModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';
import '../../../constant/global.dart';
import '../models/MaterCategoryModel.dart';
import '../models/OfferModel.dart';
import '../models/categories_model.dart';
import '../models/scrapModel.dart';

class ScrapForm extends StatefulWidget {
 String? selectedValue1,selectedValue2,selectedValue3,selectedValue4,selectedValueName1,selectedValueName2,selectedValueName3,selectedValueName4;
 ScrapForm({this.selectedValueName2,this.selectedValueName1,this.selectedValue1,this.selectedValueName3,this.selectedValue3,this.selectedValue2,this.selectedValue4,this.selectedValueName4});

  @override
  State<ScrapForm> createState() => _ScrapFormState();
}

class _ScrapFormState extends State<ScrapForm> {


  TextEditingController serviceNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController timeController =  TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  String? selectedCategory;
  String? selectedSubcategory;
  AllCateModel? collectionModal;

  List<Categories> catlist = [];
  List<MaterCategoryModel> masterCatList = [];

  bool isLoading = false;

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

  _getCollection() async {
    var uri = Uri.parse('${baseUrl()}/get_all_cat');
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
        catlist = AllCateModel.fromJson(userData).categories!;
        print("ooooo ${collectionModal!.status} and ${collectionModal!.categories!.length} and ${userID}");
      });
    }
    print(responseData);
  }

  List<Categories> subCatList = [];

  getSubCategory() async {
    var uri = Uri.parse('${baseUrl()}/get_all_cat');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    print("checking id here ${selectedCategory}");
    print(baseUrl.toString());
    request.headers.addAll(headers);
    request.fields['category_id'] = selectedCategory.toString();
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if (mounted) {
      setState(() {
        subCatList = AllCateModel.fromJson(userData).categories!;
        collectionModal = AllCateModel.fromJson(userData);
      });
    }
    print(responseData);
  }

  OfferModel? offerModeldata;

    String? finalCharge;
  getOfferFunction()async{
    var headers = {
      'Cookie': 'ci_session=88e25f8723337d9101be7590e6fdd7e2628e954b'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/get_offer_amount'));
    request.fields.addAll({
      'cat_id': '${selectedCategory.toString()}',
      'sub_cat_id': '${selectedSubcategory.toString()}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse =  await response.stream.bytesToString();
      final jsonResponse = OfferModel.fromJson(json.decode(finalResponse));
      setState(() {
        offerModeldata = jsonResponse;
        finalCharge = offerModeldata!.data![0].discount;
      });

    }
    else {
      print(response.reasonPhrase);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCollection();
    getMaterCategory();
    getUserDataApicall();
    selectedMasterCategory = widget.selectedValue1;
    selectedCategory  = widget.selectedValue3;
    selectedSubcategory = widget.selectedValue4;

  }
  String _dateValue = '';
  String addId = '';
  var dateFormate;
  String _pickedLocation = '';
  // Future getAddress(id) async {
  //   var request =
  //   http.MultipartRequest('POST', Uri.parse('${baseUrl()}/get_address'));
  //   request.fields.addAll({'id': '$id', 'user_id': '$userID'});
  //
  //   print(request);
  //   print(request.fields);
  //
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     final str = await response.stream.bytesToString();
  //     final jsonResponse = AddressModel.fromJson(json.decode(str));
  //     if (jsonResponse.responseCode == "1") {
  //       setState(() {
  //         _pickedLocation =
  //         "${jsonResponse.data![0].address!}, ${jsonResponse.data![0].building}";
  //       });
  //     }
  //     print(_pickedLocation);
  //     return AddressModel.fromJson(json.decode(str));
  //   } else {
  //     return null;
  //   }
  // }
  // final _formKey = GlobalKey<FormState>();
  // Future _selectDate() async {
  //   DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: new DateTime.now(),
  //       firstDate: DateTime.now(),
  //       lastDate: DateTime(2025),
  //       //firstDate: DateTime.now().subtract(Duration(days: 1)),
  //       // lastDate: new DateTime(2022),
  //       builder: (BuildContext context, Widget? child) {
  //         return Theme(
  //           data: ThemeData.light().copyWith(
  //               primaryColor: Colors.black, //Head background
  //               accentColor: Colors.black,
  //               colorScheme:
  //               ColorScheme.light(primary: const Color(0xFFEB6C67)),
  //               buttonTheme:
  //               ButtonThemeData(textTheme: ButtonTextTheme.accent)),
  //           child: child!,
  //         );
  //       });
  //   if (picked != null)
  //     setState(() {
  //       String yourDate = picked.toString();
  //       _dateValue = convertDateTimeDisplay(yourDate);
  //       print(_dateValue);
  //       dateFormate =
  //           DateFormat("dd/MM/yyyy").format(DateTime.parse(_dateValue ?? ""));
  //       sDate = DateFormat("dd-MM-yyyy").format(DateTime.parse(_dateValue ?? ""));
  //       dateController.text = dateFormate;
  //     });
  // }
  //
  // String convertDateTimeDisplay(String date) {
  //   final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
  //   final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
  //   final DateTime displayDate = displayFormater.parse(date);
  //   final String formatted = serverFormater.format(displayDate);
  //   return formatted;
  // }

  String ? catName;
  String? subCatName;
  TimeOfDay? selectedTime;
  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        useRootNavigator: true,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(primary: backgroundblack),
                buttonTheme: ButtonThemeData(
                    colorScheme: ColorScheme.light(primary: backgroundblack))),
            child: MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: false),
                child: child!),
          );
        });
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay.replacing(hour: timeOfDay.hourOfPeriod);
        timeController.text = selectedTime!.format(context);
      });
    }
    var per = selectedTime!.period.toString().split(".");
    print(
        "selected time here ${selectedTime!.format(context).toString()} and ${per[1]}");
  }
  String? sDate;
  File? imageFiles;
  List<ScrapModel> scrapList = [];
  TextEditingController nameController = TextEditingController();

  addDetail()async{
      // showDialog(context: context, builder: (context){
      //   return AlertDialog(
      //     content: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         Text("Adding please wait..."),
      //         SizedBox(height: 15,),
      //         CircularProgressIndicator(),
      //       ],
      //     ),
      //   );
      // });
    int totalValue = 0;

    if(serviceCharge == null || serviceCharge == "" || finalCharge ==null || finalCharge == ""){
      if(quantityController.text == ""){
        totalValue = 0;
      }
      else{
        totalValue = int.parse(quantityController.text.toString()) + int.parse(quantityController.text.toString());
      }

    }
    else if(finalCharge == null || finalCharge == "" || quantityController.text == ""){
      totalValue = 0;
    }
    else{
      totalValue = int.parse(serviceCharge.toString()) * int.parse(quantityController.text.toString()) + int.parse(finalCharge.toString());
    }
    var headers = {
      'Cookie': 'ci_session=6bb733371562cedef8b28f44ffc9ae00e52b265a'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/add_scrap'));
    request.fields.addAll({
      'user_id': "${userID}",
      'category_id': '${selectedCategory.toString()}',
      'subcategory_id': '${selectedSubcategory.toString()}',
      'qty': '${quantityController.text}' ?? "",
      'name':'${nameController.text}',
      'price': serviceCharge == "" || serviceCharge == null ? "0" : '${serviceCharge.toString()}',
        'total':'${totalValue}',
      'master_category':'${selectedMasterCategory.toString()}'
    });
    print("sdsfs ${baseUrl()}/add_scrap");
    print("params ${request.fields.toString()}");
   imageFiles == null ? null :  request.files.add(await http.MultipartFile.fromPath('image', '${imageFiles!.path.toString()}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      print("msg here ${jsonResponse['msg']} and ${jsonResponse}");
      Fluttertoast.showToast(msg: "${jsonResponse['msg']}");
      Navigator.pop(context,true);

      setState(() {
        nameController.clear();
        selectedCategory == null;
        selectedMasterCategory == null;
        selectedSubcategory == null;
        quantityController.clear();
        imageFiles == null;
      });
    }
    else {
      print(response.reasonPhrase);
      Fluttertoast.showToast(msg: "Somthing went wrong");
      setState(() {
        isLoading = false;
      });
      //Navigator.of(context).pop();
    }
  }
  GeeUserModel? model;
  String? userCity;

  getUserDataApicall() async {
    try {
      Map<String, String> headers = {
        'content-type': 'application/x-www-form-urlencoded',
      };
      var map = new Map<String, dynamic>();
      map['user_id'] = userID;

      final response = await client.post(Uri.parse("${baseUrl()}/user_data"),
          headers: headers, body: map);

      var dic = json.decode(response.body);
      Map<String, dynamic> userMap = jsonDecode(response.body);
      model = GeeUserModel.fromJson(userMap);

      userCity = model!.user!.city.toString();

      // _username.text = model!.user!.username!;
      // _mobile.text = model!.user!.mobile!;
      // _address.text = model!.user!.address!;
      print("GetUserData>>>>>>");
      print(dic);


    } on Exception {

      Fluttertoast.showToast(msg: "No Internet connection");
      throw Exception('No Internet connection');
    }
  }

  GetServiceChargeModel? serviceChargeModel;
  String serviceCharge = "0";
  getServiceCharge()async{
    var headers = {
      'Cookie': 'ci_session=153ebf28d2ee5afcf5e84db07b38e2e4bfe5bdef'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/get_service_charge'));
    request.fields.addAll({
      'cat_id': '${selectedCategory}',
      'sub_cat_id': '${selectedSubcategory.toString()}',
      'city_id': '${userCity}',
    });
    print("params here ${request.fields.toString()}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("code now ${response.statusCode}");
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      print("ddd ${finalResponse}");
      final jsonResponse = GetServiceChargeModel.fromJson(json.decode(finalResponse));
      print("response here ${jsonResponse.msg} and ${jsonResponse.data}");
      setState(() {
        serviceChargeModel = jsonResponse;
        serviceCharge = serviceChargeModel!.data![0].charge.toString();
      });
      getOfferFunction();
      print("service charge here ${serviceChargeModel!.msg} and ${serviceChargeModel!.data![0].charge} }");
    }
    else {
      print(response.reasonPhrase);
    }

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
                bottomRight: Radius.circular(20)
            )
        ),
        // bottom:
        title: Text(
          "${getTranslated(context, 'addScrap')}",
          style: TextStyle(color: appColorWhite),
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
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          children: [

            /// main form
            Form(
              //key: ,
              child: Container(
                child: Column(
                  children: [
                    Padding(

                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: TextFormField( controller: nameController,
                        keyboardType: TextInputType.text,
                        validator: (v){
                          if(v!.isEmpty){
                            return "Enter name";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "${getTranslated(context, 'enterName')}",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(color: appColorBlack.withOpacity(0.5))
                            )
                        ),),
                    ),
                    SizedBox(height: 10,),
                   masterData == null ? CircularProgressIndicator() : Container(
                      height: 60,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: appColorBlack.withOpacity(0.3))
                      ),
                      child: DropdownButton(
                        // Initial Value
                        value: selectedMasterCategory,
                        underline: Container(),
                        // Down Arrow Icon
                        icon: Icon(Icons.keyboard_arrow_down),
                        hint: Container(
                            width: MediaQuery.of(context).size.width/1.25,
                            child: Text("${getTranslated(context, 'selectCategories')}")),
                        // Array list of items
                        items: masterData!.data!.map((items) {
                          return DropdownMenuItem(
                            value: items.id,
                            child: Container(
                                child: Text(items.categories.toString())),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            print("catName here ${catName}");
                            selectedMasterCategory = newValue!;

                            print("selected category ${selectedMasterCategory}");
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 60,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: appColorBlack.withOpacity(0.3))
                      ),
                      child: DropdownButton(
                        // Initial Value
                        value: selectedCategory,
                        underline: Container(),
                        // Down Arrow Icon
                        icon: Icon(Icons.keyboard_arrow_down),
                        hint: Container(
                            width: MediaQuery.of(context).size.width/1.25,
                            child: Text("${getTranslated(context, 'selectScrapType')}")),
                        // Array list of items
                        items: catlist.map((items) {
                          return DropdownMenuItem(
                            value: items.id,
                            child: Container(
                                child: Text(items.cName.toString())),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            print("catName here ${catName}");
                            selectedCategory = newValue!;
                            getSubCategory();
                            print("selected category ${selectedCategory}");
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 60,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: appColorBlack.withOpacity(0.3))
                      ),
                      child: DropdownButton(
                        // Initial Value
                        value: selectedSubcategory,
                        underline: Container(),
                        // Down Arrow Icon
                        icon: Container(
                          // width: MediaQuery.of(context).size.width/1.5,
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.keyboard_arrow_down)),
                        hint: Container(width: MediaQuery.of(context).size.width/1.25, child: Text("${getTranslated(context, 'selectSubScrap')}")),
                        // Array list of items
                        items: subCatList.map((items) {
                          return DropdownMenuItem(
                            value: items.id,
                            child: Container(
                                child: Text(items.cName.toString())),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedSubcategory = newValue!;
                            print("selected sub category ${selectedSubcategory}");
                            getServiceCharge();
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: TextFormField( controller: quantityController,
                        keyboardType: TextInputType.number,
                        validator: (v){
                          if(v!.isEmpty){
                            return "Enter quantity";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "${getTranslated(context, 'enterQuantity')}",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(color: appColorBlack.withOpacity(0.5))
                            )
                        ),),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            showDialog(context: context, builder: (context){
                              return AlertDialog(
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap:()async{
                                        // String fileUrl = await storageReference.getDownloadURL();
                                        PickedFile? image = await ImagePicker.platform
                                            .pickImage(source: ImageSource.gallery);
                                        imageFiles = File(image!.path);
                                        setState(() {

                                        });
                                        print("image files here ${imageFiles!.path.toString()}");
                                        Navigator.of(context).pop();
                                      },
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.photo),
                                          SizedBox(width: 5,),
                                          Text("Gallery")
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    InkWell(
                                      onTap:()async{
                                        PickedFile? image = await ImagePicker.platform
                                            .pickImage(source: ImageSource.camera);
                                        imageFiles = File(image!.path);
                                        print("image files here ${imageFiles!.path.toString()}");
                                        setState(() {

                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.camera_alt),
                                          SizedBox(width: 5,),
                                          Text("Camera")
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                          },
                          child: Container(
                            height: 90,
                            width: 80,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)
                            ),
                            child:imageFiles == null ?  Icon(Icons.photo) : Image.file(imageFiles!,fit: BoxFit.fill,) ,
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 15,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          isLoading = true;
                        });
                        if(imageFiles == null){
                          Fluttertoast.showToast(msg: "Please image");
                          setState(() {
                            isLoading = false;
                          });
                        }
                        else{
                          addDetail();
                        }

                        // setState(() {
                        //   scrapList.add(
                        //     ScrapModel(
                        //       id: "1",
                        //       image: imageFiles!.path.toString(),
                        //       category: selectedCategory.toString(),
                        //       subCategory: selectedSubcategory.toString(),
                        //       qty: quantityController.text.toString(),
                        //     ),
                        //   );
                        // });
                        // Navigator.pop(context,scrapList);
                      },
                      child: Container(
                        height: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: backgroundblack,
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child:  isLoading == true ? CircularProgressIndicator(color: Colors.white,) : Text("${getTranslated(context, 'add')}",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /// show added list data
            // Container(
            //   child: ListView.builder(
            //       shrinkWrap: true,
            //       itemCount: scrapList.length,
            //       physics: ScrollPhysics(),
            //       itemBuilder: (context,index){
            //         return Card(
            //           child: Padding(
            //             padding: EdgeInsets.all(8.0),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Row(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Expanded(child: Text("Category Name : ")),
            //                     Expanded(child: Text("${scrapList[index].category}")),
            //                   ],
            //                 ),
            //                 SizedBox(height: 6,),
            //                 Row(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Expanded(child: Text("SubCategory Name : ")),
            //                     Expanded(child: Text("${scrapList[index].subCategory}")),
            //                   ],
            //                 ),
            //                 SizedBox(height: 6,),
            //                 Row(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Expanded(child: Text("Quantity : ",style: TextStyle(fontSize: 14),)),
            //                     Expanded(child: Text("${scrapList[index].qty} Kg")),
            //                   ],
            //                 ),
            //                 SizedBox(height: 6,),
            //                 //
            //                 // Text("SubCategory Name : ${scrapList[index].subCategory}"),
            //                 // Text("Quantity : ${scrapList[index].qty}"),
            //                 Container(
            //                     height:70,
            //                     width:80,
            //                     child: ClipRRect(
            //                         borderRadius:BorderRadius.circular(6),
            //                         child: Image.file( File(scrapList[index].image.toString()),fit: BoxFit.fill,)))
            //               ],
            //             ),
            //           ),
            //         );
            //       }),
            // ),
            // SizedBox(height: 10,),

            /// add more button with form functionality
            // scrapList.isEmpty ? SizedBox.shrink() :   InkWell(
            //   onTap: ()async{
            //     setState(() {
            //       selectedSubcategory =  null;
            //       selectedCategory = null;
            //       quantityController.clear();
            //       imageFiles = null;
            //     });
            //     await showDialog(context: context, builder: (context){
            //       return StatefulBuilder(
            //           builder: (BuildContext context, StateSetter setState) {
            //             return AlertDialog(
            //               content: Column(
            //                 mainAxisSize: MainAxisSize.min,
            //                 children: [
            //                   Container(
            //                     height: 60,
            //                     padding: EdgeInsets.only(left: 10),
            //                     decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(7),
            //                         border: Border.all(color: appColorBlack.withOpacity(0.3))
            //                     ),
            //                     child: DropdownButton(
            //                       // Initial Value
            //                       value: selectedCategory,
            //                       underline: Container(),
            //                       // Down Arrow Icon
            //                       icon: Icon(Icons.keyboard_arrow_down),
            //                       hint: Container(
            //                           width: MediaQuery.of(context).size.width/1.9,
            //                           child: Text("Select category")),
            //                       // Array list of items
            //                       items: catlist.map((items) {
            //                         return DropdownMenuItem(
            //                           value: items.id,
            //                           child: Container(
            //                               child: Text(items.cName.toString())),
            //                         );
            //                       }).toList(),
            //                       // After selecting the desired option,it will
            //                       // change button value to selected value
            //                       onChanged: (String? newValue){
            //                         setState(() {
            //                           selectedCategory = newValue!;
            //                           getSubCategory();
            //                           print("selected category ${selectedCategory}");
            //                         });
            //                       },
            //                     ),
            //                   ),
            //                   SizedBox(height: 10,),
            //                   Container(
            //                     height: 60,
            //                     padding: EdgeInsets.only(left: 10),
            //                     decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(7),
            //                         border: Border.all(color: appColorBlack.withOpacity(0.3))
            //                     ),
            //                     child: DropdownButton(
            //                       // Initial Value
            //                       value: selectedSubcategory,
            //                       underline: Container(),
            //                       // Down Arrow Icon
            //                       icon: Container(
            //                         // width: MediaQuery.of(context).size.width/1.5,
            //                           alignment: Alignment.centerRight,
            //                           child: Icon(Icons.keyboard_arrow_down)),
            //                       hint: Container(width: MediaQuery.of(context).size.width/1.9, child: Text("Select sub category")),
            //                       // Array list of items
            //                       items: subCatList.map((items) {
            //                         return DropdownMenuItem(
            //                           value: items.id,
            //                           child: Container(
            //                               child: Text(items.cName.toString())),
            //                         );
            //                       }).toList(),
            //                       // After selecting the desired option,it will
            //                       // change button value to selected value
            //                       onChanged: (String? newValue) {
            //                         setState(() {
            //                           selectedSubcategory = newValue!;
            //                           print("selected sub category ${selectedSubcategory}");
            //                         });
            //                       },
            //                     ),
            //                   ),
            //                   SizedBox(height: 10,),
            //                   TextFormField( controller: quantityController,
            //                     keyboardType: TextInputType.number,
            //                     validator: (v){
            //                       if(v!.isEmpty){
            //                         return "Enter quantity";
            //                       }
            //                     },
            //                     decoration: InputDecoration(
            //                         hintText: "Enter quantity in kg",
            //                         border: OutlineInputBorder(
            //                             borderRadius: BorderRadius.circular(7),
            //                             borderSide: BorderSide(color: appColorBlack.withOpacity(0.5))
            //                         )
            //                     ),),
            //                   SizedBox(height: 20,),
            //                   Row(
            //                     children: [
            //                       InkWell(
            //                         onTap: (){
            //                           showDialog(context: context, builder: (context){
            //                             return AlertDialog(
            //                               content: Column(
            //                                 crossAxisAlignment: CrossAxisAlignment.start,
            //                                 mainAxisAlignment: MainAxisAlignment.center,
            //                                 mainAxisSize: MainAxisSize.min,
            //                                 children: [
            //                                   InkWell(
            //                                     onTap:()async{
            //                                       // String fileUrl = await storageReference.getDownloadURL();
            //                                       PickedFile? image = await ImagePicker.platform
            //                                           .pickImage(source: ImageSource.gallery);
            //                                       imageFiles = File(image!.path);
            //                                       setState(() {
            //
            //                                       });
            //                                       print("image files here ${imageFiles!.path.toString()}");
            //                                       Navigator.of(context).pop();
            //                                     },
            //                                     child: Row(
            //                                       crossAxisAlignment: CrossAxisAlignment.start,
            //                                       children: [
            //                                         Icon(Icons.photo),
            //                                         SizedBox(width: 5,),
            //                                         Text("Gallery")
            //                                       ],
            //                                     ),
            //                                   ),
            //                                   SizedBox(height: 10,),
            //                                   InkWell(
            //                                     onTap:()async{
            //                                       PickedFile? image = await ImagePicker.platform
            //                                           .pickImage(source: ImageSource.camera);
            //                                       imageFiles = File(image!.path);
            //                                       print("image files here ${imageFiles!.path.toString()}");
            //                                       setState(() {
            //
            //                                       });
            //                                       Navigator.of(context).pop();
            //                                     },
            //                                     child: Row(
            //                                       crossAxisAlignment: CrossAxisAlignment.start,
            //                                       children: [
            //                                         Icon(Icons.camera_alt),
            //                                         SizedBox(width: 5,),
            //                                         Text("Camera")
            //                                       ],
            //                                     ),
            //                                   ),
            //                                 ],
            //                               ),
            //                             );
            //                           });
            //                         },
            //                         child: Container(
            //                           height: 90,
            //                           width: 80,
            //                           decoration: BoxDecoration(
            //                               border: Border.all(color: Colors.grey)
            //                           ),
            //                           child:imageFiles == null ?  Icon(Icons.photo) : Image.file(imageFiles!,fit: BoxFit.fill,) ,
            //                         ),
            //                       ),
            //
            //                     ],
            //                   ),
            //                   SizedBox(height: 15,),
            //                   InkWell(
            //                     onTap: ()async{
            //                       setState(() {
            //                         scrapList.add(
            //                           ScrapModel(
            //                             id: "1",
            //                             image: imageFiles!.path.toString(),
            //                             category: selectedCategory.toString(),
            //                             subCategory: selectedSubcategory.toString(),
            //                             qty: quantityController.text.toString(),
            //                           ),
            //                         );
            //                       });
            //                       Navigator.pop(context);
            //                     },
            //                     child: Container(
            //                       height: 45,
            //                       alignment: Alignment.center,
            //                       decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(6),
            //                           color: backgroundblack
            //                       ),
            //                       child: Text("Add",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600),),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             );
            //           }
            //       );
            //     });
            //     setState(() {
            //
            //     });
            //   },
            //   child: Container(
            //     height: 35,
            //     margin: EdgeInsets.only(left: 30,right: 30,bottom: 50),
            //     padding: EdgeInsets.symmetric(horizontal: 3),
            //     alignment: Alignment.center,
            //     decoration: BoxDecoration(
            //       color: backgroundblack,
            //       borderRadius: BorderRadius.circular(6),
            //     ),
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Icon(Icons.add,color: Colors.white,),
            //         SizedBox(width: 3,),
            //         Text("Add more",style: TextStyle(color: Colors.white),),
            //       ],
            //     ),
            //   ),
            // ),

          ],
        ),
      ),
    );
  }
}
