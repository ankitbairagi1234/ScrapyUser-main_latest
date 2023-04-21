import 'dart:convert';

import 'package:ez/screens/view/models/catModel.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constant/global.dart';
import 'Package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  String? id;
  String? vid;
  String? name;
  String? catId;
  bool? fromSeller;

  FilterPage({this.name,this.id,this.catId,this.fromSeller,this.vid});
  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  bool isLoading = false;
  CatModal? catModal;
  String? selectedValue;
  var items = [
    'Price low to high',
    'Price high to low',
    'Newest',
  ];
  int _value = 50;

  getResidential() async {
    try {
      Map<String, String> headers = {
        'content-type': 'application/x-www-form-urlencoded',
      };
      var map = new Map<String, dynamic>();
      if(widget.fromSeller!){
        map['vid'] = widget.vid;
      } else {
        map['cat_id'] = widget.catId;
        map['s_cat_id'] = widget.id;
        map['sort_by'] =  selectedValue.toString();
      }

      final response = await client.post(Uri.parse("${baseUrl()}/get_cat_res"),
          headers: headers, body: map);

      var dic = json.decode(response.body);
      print("${baseUrl()}/get_cat_res");
      print("ooo ${map.toString()}");
      Map<String, dynamic> userMap = jsonDecode(response.body);
      setState(() {
        catModal = CatModal.fromJson(userMap);
      });
      print(">>>>>>");
      print(dic);
    } on Exception {
      Fluttertoast.showToast(msg: "No Internet connection");
      throw Exception('No Internet connection');
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
          "Filter",
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
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back,
        //     color: Colors.black,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
        child: ListView(children: [
          Text("Sort By",style: TextStyle(color: appColorBlack,fontSize: 15,fontWeight: FontWeight.w500),),
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: appColorBlack.withOpacity(0.5))
            ),
            child: DropdownButton(
              value: selectedValue,
              underline: Container(),
              icon:  Container(
                alignment: Alignment.centerRight,
                  width: MediaQuery.of(context).size.width/1.8,
                  child: Icon(Icons.keyboard_arrow_down)),
              hint: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text("Sort by"),
              ),
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(items),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
            ),
          ),
          //   SizedBox(height: 20,),
          // Text("Price Range",style: TextStyle(color: appColorBlack,fontSize: 15,fontWeight: FontWeight.w500),),
          // Slider(
          //   label: "price",
          //   min: 00.0,
          //   max: 100.0,
          //   value: _value.toDouble(),
          //   onChanged: (value) {
          //     setState(() {
          //       _value = value.toInt();
          //     });
          //   },
          // ),
        SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  getResidential();
                },
                child: Container(
                  width: 100,
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: backgroundblack,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("Apply",style: TextStyle(color: appColorWhite,fontSize: 16,fontWeight: FontWeight.w600),),
                ),
              ),
            ],
          ),
          // Expanded(child: Slider(value: _value.toDouble(),onChanged: (double newValue){
          //   setState(() {
          //     _value = newValue.toInt();
          //   });
          // }))
        ],),
      ),
    );
  }
}
