import 'package:ez/Helper/session.dart';
import 'package:flutter/material.dart';

import '../../../constant/global.dart';
import '../../../main.dart';
import '../../../models/language_model.dart';

/*
Title:ChangeLanguageScreen
Purpose:ChangeLanguageScreen
Created By:Kalpesh Khandla
*/

class ChangeLanguageScreen extends StatefulWidget {
  bool? back;
  ChangeLanguageScreen({this.back});


  @override
  _ChangeLanguageScreenState createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {

  int? selectLan;

  @override
  void initState() {
    new Future.delayed(Duration.zero, () {
      languageList = [
        getTranslated(context, 'ENGLISH_LAN'),
        getTranslated(context, 'HINDI_LAN'),
      ];
    });
    super.initState();
  //  getProfile();
  }
  final GlobalKey<FormState> _changePwdKey = GlobalKey<FormState>();
  void openChangeLanguageBottomSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Form(
                  key: _changePwdKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      bottomSheetHandle(),
                      bottomsheetLabel("CHOOSE_LANGUAGE_LBL"),
                      StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter setModalState) {
                          return SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: getLngList(context, setModalState)),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
  Widget getHeading(String title) {
    print("here is title value ${title}");
    return Text(
      getTranslated(context, title).toString(),
      style: Theme.of(context).textTheme.headline6!.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.black),
    );
  }
  Widget bottomSheetHandle() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.black),
        height: 5,
        width: MediaQuery.of(context).size.width * 0.3,
      ),
    );
  }

  Widget bottomsheetLabel(String labelName) => Padding(
    padding: const EdgeInsets.only(top: 30.0, bottom: 20),
    child: getHeading(labelName),
  );
  List<String> langCode = ["en", "hi"];
  List<String?> languageList = [];
  List<Widget> getLngList(BuildContext ctx, StateSetter setModalState) {
    return languageList
        .asMap()
        .map(
          (index, element) => MapEntry(
          index,
          InkWell(
            onTap: () {
              if (mounted)
                setState(() {
                  selectLan = index;
                  _changeLan(langCode[index], ctx);
                });
              setModalState((){});
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 25.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectLan == index
                                ? Colors.grey
                                : Colors.white,
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: selectLan == index
                              ? Icon(
                            Icons.check,
                            size: 17.0,
                            color: Colors.black,
                          )
                              : Icon(
                              Icons.check_box_outline_blank,
                              size: 15.0,
                              color:Colors.white
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: 15.0,
                          ),
                          child: Text(
                            languageList[index].toString(),
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                color: Colors.black),
                          ))
                    ],
                  ),
                  // index == languageList.length - 1
                  //     ? Container(
                  //         margin: EdgeInsetsDirectional.only(
                  //           bottom: 10,
                  //         ),
                  //       )
                  //     : Divider(
                  //         color: Theme.of(context).colorScheme.lightBlack,
                  //       ),
                ],
              ),
            ),
          )),
    )
        .values
        .toList();
  }

  void _changeLan(String language, BuildContext ctx) async {
    Locale _locale = await setLocale(language);

    MyApp.setLocale(ctx, _locale);
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

      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  Future.delayed(Duration(seconds: 0),(){
                    return openChangeLanguageBottomSheet();
                  });
                },
                child: Text(
                  getTranslated(context, 'changeLanguage'),
                 // getTranslated(context, 'CHOOSE_LANGUAGE_LBL'),
                  style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              //_createLanguageDropDown()
            ],
          ),
        ),
      ),
    );
  }

  // _createLanguageDropDown() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(10),
  //       border: Border.all(color: Colors.black),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.only(left: 10, right: 10),
  //       child: DropdownButton<LanguageModel>(
  //         iconSize: 30,
  //         underline: SizedBox(),
  //         hint: Text(getTranslated(context, 'CHOOSE_LANGUAGE_LBL')),
  //         onChanged: (LanguageModel? language) {
  //           changeLanguage(context, language!.languageCode);
  //         },
  //         items: LanguageModel.languageList()
  //             .map<DropdownMenuItem<LanguageModel>>(
  //               (e) => DropdownMenuItem<LanguageModel>(
  //             value: e,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: <Widget>[
  //                 Text(
  //                   e.flag,
  //                   style: TextStyle(fontSize: 30),
  //                 ),
  //                 Text(e.name)
  //               ],
  //             ),
  //           ),
  //         )
  //             .toList(),
  //       ),
  //     ),
  //   );
  // }
}