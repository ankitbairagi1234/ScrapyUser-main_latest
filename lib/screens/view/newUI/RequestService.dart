import 'dart:convert';

import 'package:ez/screens/view/models/ServiceRequestModel.dart';
import 'package:ez/screens/view/models/address_model.dart';
import 'package:ez/screens/view/newUI/manage_address.dart';
import 'package:ez/screens/view/newUI/newTabbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../constant/global.dart';
import '../models/categories_model.dart';

class RequestService extends StatefulWidget {
  const RequestService({Key? key}) : super(key: key);

  @override
  State<RequestService> createState() => _RequestServiceState();
}

class _RequestServiceState extends State<RequestService> {

  TextEditingController serviceNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController timeController =  TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  String? selectedCategory;
  String? selectedSubcategory;

  AllCateModel? collectionModal;

  List<Categories> catlist = [];
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCollection();
  }
  String _dateValue = '';
  String addId = '';
  var dateFormate;
  String _pickedLocation = '';
  Future getAddress(id) async {
    var request =
    http.MultipartRequest('POST', Uri.parse('${baseUrl()}/get_address'));
    request.fields.addAll({'id': '$id', 'user_id': '$userID'});

    print(request);
    print(request.fields);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      final jsonResponse = AddressModel.fromJson(json.decode(str));
      if (jsonResponse.responseCode == "1") {
        setState(() {
          _pickedLocation =
          "${jsonResponse.data![0].address!}, ${jsonResponse.data![0].building}";
        });
      }
      print(_pickedLocation);
      return AddressModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }
  final _formKey = GlobalKey<FormState>();
  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        //firstDate: DateTime.now().subtract(Duration(days: 1)),
        // lastDate: new DateTime(2022),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: Colors.black, //Head background
                accentColor: Colors.black,
                colorScheme:
                ColorScheme.light(primary: const Color(0xFFEB6C67)),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null)
      setState(() {
        String yourDate = picked.toString();
        _dateValue = convertDateTimeDisplay(yourDate);
        print(_dateValue);
        dateFormate =
            DateFormat("dd/MM/yyyy").format(DateTime.parse(_dateValue ?? ""));
            sDate = DateFormat("dd-MM-yyyy").format(DateTime.parse(_dateValue ?? ""));
        dateController.text = dateFormate;
      });
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

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
  submitRequest()async{

    print("checking date ${sDate}");
    var headers = {
      'Cookie': 'ci_session=cf2fmpq7vue0kthvj5s046uv4m2j5r11'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/service_request'));
    request.fields.addAll({
      'user_id': '${userID}',
      'cat_id': '${selectedCategory.toString()}',
      'sub_cat_id': '${selectedSubcategory.toString()}',
      'looking_for': '${serviceNameController.text}',
      'location': '${_pickedLocation.toString()}',
      'date': '${sDate.toString()}',
      'budget': '${priceController.text}'
    });

    print(
      "ok ${request.fields}"
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = ServiceRequestModel.fromJson(json.decode(finalResult));
      print("checking json response ${jsonResponse.msg} and ${jsonResponse.responseCode}");
      if(jsonResponse.responseCode == "0"){
        Fluttertoast.showToast(msg: "${jsonResponse.msg}");
      }
      else{
        Fluttertoast.showToast(msg: "${jsonResponse.msg}");
        Navigator.push(context, MaterialPageRoute(builder: (context) => TabbarScreen()));
      }

    }
    else {
      print(response.reasonPhrase);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)
            )
        ),
        backgroundColor: backgroundblack,
        elevation: 2,
        title: Text(
          'Request Service',
          style: TextStyle(color: appColorWhite, fontWeight: FontWeight.bold),
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
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
            children: [
              TextFormField( controller: serviceNameController,
                validator: (v){
                if(v!.isEmpty){
                  return "Enter service name";
                }
                },
                decoration: InputDecoration(
                hintText: "What are you looking for?",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: appColorBlack.withOpacity(0.5))
                )
              ),),
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
                  icon: Container(
                    // width: MediaQuery.of(context).size.width/1.5,
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.keyboard_arrow_down)),
                    hint: Text("Select category"),
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
                  hint: Container(width: MediaQuery.of(context).size.width/1.25, child: Text("Select sub category")),
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
                    });
                  },
                ),
              ),
              SizedBox(height: 10,),
              InkWell(
                  onTap: () async {
                    // _getLocation();
                    var result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManageAddress(
                              // resid: widget.resId,
                              aId: addId,
                            )));
                    print("address id ${result}");
                    if (result != '') {
                      setState(() {
                        addId = result;
                        getAddress(result);
                      });
                    }
                  },
                child:  Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: appColorBlack.withOpacity(0.5))
                  ),
                  child: _pickedLocation.length > 0 ? Text("${_pickedLocation}",style: TextStyle(height: 1.2),) : Text("Select address",style: TextStyle(color: appColorBlack.withOpacity(0.5)),)
                )
                // TextFormField( controller: locationController,
                //   validator: (v){
                //     if(v!.isEmpty){
                //       return "Enter location";
                //     }
                //   },
                //   decoration: InputDecoration(
                //       hintText: "Enter location",
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(7),
                //           borderSide: BorderSide(color: appColorBlack.withOpacity(0.5))
                //       )
                //   ),),
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: (){
                  _selectDate();
                },
                child: Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: appColorBlack.withOpacity(0.5))
                  ),
                  child: _dateValue.length > 0 ? Text("${dateFormate}",style: TextStyle(color:appColorBlack,fontSize: 15),) : Text("Select Date",style: TextStyle(color:appColorBlack.withOpacity(0.5),fontSize: 15),),
                )
                // TextFormField( controller: dateController,
                //   validator: (v){
                //     if(v!.isEmpty){
                //       return "Enter date";
                //     }
                //   },
                //   readOnly: true,
                //   decoration: InputDecoration(
                //       hintText: "Select Date",
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(7),
                //           borderSide: BorderSide(color: appColorBlack.withOpacity(0.5))
                //       )
                //   ),),
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: (){
                  _selectTime(context);
                },
                child: Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: appColorBlack.withOpacity(0.5))
                  ),
                  child: selectedTime != null  ? Text("${selectedTime!.format(context)}")  :  Text("Select time",style: TextStyle(color:appColorBlack.withOpacity(0.5),fontSize: 15),)
                )
                // TextFormField( controller: locationController,
                //   validator: (v){
                //     if(v!.isEmpty){
                //       return "Enter time";
                //     }
                //   },
                //   readOnly: true,
                //   decoration: InputDecoration(
                //       hintText: "Select time",
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(7),
                //           borderSide: BorderSide(color: appColorBlack.withOpacity(0.5))
                //       )
                //   ),),
              ),
              SizedBox(height: 10,),
              TextFormField( controller: priceController,
                keyboardType: TextInputType.number,
                validator: (v){
                  if(v!.isEmpty){
                    return "Enter price";
                  }
                },
                decoration: InputDecoration(
                    hintText: "Enter price",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(color: appColorBlack.withOpacity(0.5))
                    )
                ),),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  if(_formKey.currentState!.validate()){
                    submitRequest();
                  }
                  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TabbarScreen()));
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: backgroundblack,
                    borderRadius: BorderRadius.circular(7)
                  ),
                  child: Text("Submit",style: TextStyle(color: appColorWhite,fontSize: 16,fontWeight: FontWeight.w600),),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
