import 'dart:convert';
import 'package:ez/screens/view/models/privacy_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import '../../../constant/global.dart';
import '../../../constant/sizeconfig.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  String? description;
  String? title;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrivacyPolicy();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
          "About",
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
      body: SingleChildScrollView(
        child: title != null
            ? Column(
          children: [
            Container(
                margin: EdgeInsets.all(5.0),
                child: Html(data: title,
                  defaultTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                  ),
                )
            ),
            Container(
              margin: EdgeInsets.all(5.0),
                child: Html(data: description)
            )
          ],
        )
            : Container(
          width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            child: Center(child: CircularProgressIndicator(),)),
      ),
    );
  }

  Future<PrivacyModel?> getPrivacyPolicy() async {
    var request = http.Request('GET', Uri.parse('${baseUrl()}/pages/privacy_policy'));

    http.StreamedResponse response = await request.send();
    print(request);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      final jsonResponse = PrivacyModel.fromJson(json.decode(str));
      print(jsonResponse);
      if(jsonResponse.status == "1"){
        setState(() {
          title = jsonResponse.setting?.data;
          description = jsonResponse.setting?.discription;
        });
      }
      return PrivacyModel.fromJson(json.decode(str));
    }
    else {
      return null;
    }
  }
}
