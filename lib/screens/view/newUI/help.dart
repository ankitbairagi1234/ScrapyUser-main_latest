import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../Helper/session.dart';
import '../../../constant/global.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {

  var helpData;

  getHelpData()async{
    var headers = {
      'Cookie': 'ci_session=4112a32c161376116d82e4a625c52461ad3ab3b3'
    };
    var request = http.MultipartRequest('GET', Uri.parse('${baseUrl()}/get_help'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalData = await response.stream.bytesToString();
      final jsonResult = json.decode(finalData);
      setState(() {
        helpData = jsonResult;
      });
      print("print help data here ${helpData} and ${helpData['data'][0]['email']}");
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 500),(){
      return getHelpData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "${getTranslated(context, 'help')}",
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
      body: helpData == null || helpData == "" ? Center(child: CircularProgressIndicator(),) : Container(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.email_outlined,color: backgroundblack,),
                    SizedBox(width: 10,),
                    Text("${helpData['data'][0]['email']}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.phone,color:backgroundblack,),
                    SizedBox(width: 10,),
                    Text("${helpData['data'][0]['mobile']}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding:  EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on_outlined,color: backgroundblack,),
                    SizedBox(width: 10,),
                    Text("${helpData['data'][0]['office_add']}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
