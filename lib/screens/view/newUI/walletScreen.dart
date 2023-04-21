import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:date_picker_timeline/extra/color.dart';
import 'package:ez/Helper/session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ez/constant/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../paymentRadio.dart';

class MyWallet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateWallet();
  }
}

class StateWallet extends State<MyWallet> with TickerProviderStateMixin {
  bool _isNetworkAvail = true;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  ScrollController controller = new ScrollController();
  // List<TransactionModel> tempList = [];
  TextEditingController? amtC, msgC;
  List<String?> paymentMethodList = [];
  List<String> paymentIconList = [
    'assets/images/paypal.svg',
    'assets/images/rozerpay.svg',
    'assets/images/paystack.svg',
    'assets/images/flutterwave.svg',
    'assets/images/stripe.svg',
    'assets/images/paytm.svg',
  ];
  List<RadioModel> payModel = [];
  bool? paypal, razorpay, paumoney, paystack, flutterwave, stripe, paytm;
  String? razorpayId,
      paystackId,
      stripeId,
      stripeSecret,
      stripeMode = "test",
      stripeCurCode,
      stripePayId,
      paytmMerId,
      paytmMerKey;

  int? selectedMethod;
  String? payMethod;
  StateSetter? dialogState;
  bool _isProgress = false;
  late Razorpay _razorpay;
  //List<TransactionModel> tranList = [];
  int offset = 0;
  int total = 0;
  bool isLoadingmore = true, _isLoading = true, payTesting = true;
  //final paystackPlugin = PaystackPlugin();

  TextEditingController amountController = TextEditingController();
  bool showFields = false;

  @override
  void initState() {
    super.initState();
    selectedMethod = null;
    payMethod = null;
    new Future.delayed(Duration.zero, () {
      paymentMethodList = [
        // getTranslated(context, 'PAYPAL_LBL'),
        "RazorPay"
        // getTranslated(context, 'PAYSTACK_LBL'),
        // getTranslated(context, 'FLUTTERWAVE_LBL'),
        // getTranslated(context, 'STRIPE_LBL'),
        // getTranslated(context, 'PAYTM_LBL'),
      ];
      //_getpaymentMethod();
    });

    //controller.addListener(_scrollListener);
    buttonController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);

    // buttonSqueezeanimation = new Tween(
    //   begin: deviceWidth! * 0.7,
    //   end: 50.0,
    // ).animate(new CurvedAnimation(
    //   parent: buttonController!,
    //   curve: new Interval(
    //     0.0,
    //     0.150,
    //   ),
    // ));
    amtC = new TextEditingController();
    msgC = new TextEditingController();
    // getTransaction();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  updateWallerFunction()async{
    print("oosds");
    var headers = {
      'Cookie': 'ci_session=cab7cd084157957c27bd01bb21dc3e4ec4ace287'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/update_wallet'));
    request.fields.addAll({
      'vendor_id': '${userID}',
      'transaction_id': '',
      'amount': '${amtC!.text}'
    });
    print("paras here now oo ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("status code here ${response.statusCode}");
    if (response.statusCode == 200) {
      var fianlResponse =  await response.stream.bytesToString();
      final jsonResponse = json.decode(fianlResponse);
      print("result here  ${jsonResponse['message']} and ${jsonResponse}");
    }
    else {
      print(response.reasonPhrase);
    }

  }

  getMoney()async{

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
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
        "${getTranslated(context, 'myWallet')}",
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
        body: Stack(
          children: <Widget>[
            showContent(),
          ],
        ));
  }

  Widget paymentItem(int index) {
    if (
        index == 0 && razorpay!) {
      return InkWell(
        onTap: () {
          if (mounted)
            dialogState!(() {
              selectedMethod = index;
              payMethod = paymentMethodList[selectedMethod!];
              payModel.forEach((element) => element.isSelected = false);
              payModel[index].isSelected = true;
            });
        },
        child: new RadioItem(payModel[index]),
      );
    } else
      return Container();
  }

  // Future<Null> sendRequest(String? txnId, String payMethod) async {
  //
  //   if (_isNetworkAvail) {
  //     String orderId =
  //         "wallet-refill-user-$userID-${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(900) + 100}";
  //     try {
  //       var parameter = {
  //         'user_id': userID,
  //         'amount': amtC!.text.toString(),
  //         'transaction_type': 'wallet',
  //         'type': 'credit',
  //         'message': (msgC!.text == '' || msgC!.text.isEmpty)
  //             ? "Added through wallet"
  //             : msgC!.text,
  //         'txn_id': txnId,
  //         'order_id': orderId,
  //         'status': "Success",
  //         'payment_method': payMethod.toLowerCase()
  //       };
  //
  //       Response response =
  //       await post(addTransactionApi, body: parameter, headers: headers)
  //           .timeout(Duration(seconds: timeOut));
  //
  //       var getdata = json.decode(response.body);
  //
  //       bool error = getdata["error"];
  //       String msg = getdata["message"];
  //
  //       if (!error) {
  //         // CUR_BALANCE = double.parse(getdata["new_balance"]).toStringAsFixed(2);
  //         UserProvider userProvider =
  //         Provider.of<UserProvider>(this.context, listen: false);
  //         userProvider.setBalance(double.parse(getdata["new_balance"])
  //             .toStringAsFixed(2)
  //             .toString());
  //       }
  //       if (mounted)
  //         setState(() {
  //           _isProgress = false;
  //         });
  //       setSnackbar(msg);
  //     } on TimeoutException catch (_) {
  //       setSnackbar(getTranslated(context, 'somethingMSg')!);
  //
  //       setState(() {
  //         _isProgress = false;
  //       });
  //     }
  //   } else {
  //     if (mounted)
  //       setState(() {
  //         _isNetworkAvail = false;
  //         _isProgress = false;
  //       });
  //   }
  //
  //   return null;
  // }

  _showDialog() {
    print("yes how");
   showDialog(context: context, builder: (contex){
     return AlertDialog(
       contentPadding: const EdgeInsets.all(0.0),
       shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.all(Radius.circular(5.0))),
       content: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisSize: MainAxisSize.min,
           children: [
             Padding(
               padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
               child: Text(
                 "Add Money",
               ),
             ),
             Divider(color: Colors.black),
             Form(
               key: _formkey,
               child: Flexible(
                 child: SingleChildScrollView(
                     child: new Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisSize: MainAxisSize.min,
                         children: <Widget>[
                           Padding(
                               padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                               child: TextFormField(
                                 keyboardType: TextInputType.number,
                                 validator: (val) {
                                   if (val!.length == 0) {
                                     return "Field is required";
                                   }
                                 },
                                 autovalidateMode:
                                 AutovalidateMode.onUserInteraction,
                                 style: TextStyle(
                                   color: Colors.black,
                                 ),
                                 decoration: InputDecoration(
                                   hintText: "Amount",
                                 ),
                                 controller: amtC,
                               )),
                           Padding(
                               padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                               child: TextFormField(
                                 autovalidateMode:
                                 AutovalidateMode.onUserInteraction,
                                 decoration: new InputDecoration(
                                   hintText: "Message",
                                 ),
                                 controller: msgC,
                               )),
                           //Divider(),
                           Padding(
                             padding: EdgeInsets.fromLTRB(20.0, 10, 20.0, 5),
                             child: Text(
                               "Select Payment",
                               style: Theme.of(context).textTheme.subtitle2,
                             ),
                           ),
                           Divider(),
                          InkWell(
                            onTap: (){
                              payMethod = 'razorPay';
                            },
                            child: Row(
                              children: [
                             SizedBox(width: 10,),
                                Text("RazorPay"),
                              ],
                            ),
                          ),
                       // if (
                       // index == 0 && razorpay!) {
                       // return InkWell(
                       // onTap: () {
                       // if (mounted)
                       // dialogState!(() {
                       // selectedMethod = index;
                       // payMethod = paymentMethodList[selectedMethod!];
                       // payModel.forEach((element) => element.isSelected = false);
                       // payModel[index].isSelected = true;
                       // });
                       // },
                       // child: new RadioItem(payModel[index]),
                       // );
                       // }

                           // Column(
                           //     mainAxisAlignment: MainAxisAlignment.start,

                           //     children: getPayList()),


                         ])),
               ),
             )
           ]),
       actions: <Widget>[
         new TextButton(
             child: Text(
               "Cancel",
             ),
             onPressed: () {
               Navigator.of(context).pop();
             }),
         new TextButton(
             child: Text(
               "Send",
             ),
             onPressed: () {
               final form = _formkey.currentState!;
               if (form.validate() && amtC!.text != '0') {
                 form.save();

                 if(amtC!.text == ""){

                 }
                 else {
                   // Text("RazorPay");
                   print("payment working ${amtC!.text}");
                   razorpayPayment(double.parse(amtC!.text));
                   Navigator.pop(context);
                 }
               }
             })
       ],
     );
   });
  }

  // List<Widget> getPayList() {
  //   return paymentMethodList
  //       .asMap()
  //       .map(
  //         (index, element) => MapEntry(index, paymentItem(index)),
  //       )
  //       .values
  //       .toList();
  // }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }
    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    //placeOrder(response.paymentId);
    // sendRequest(response.paymentId, "RazorPay");
    print("good here");
    updateWallerFunction();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("bad here");
    setSnackbar(response.message!);
    if (mounted)
      setState(() {
        _isProgress = false;
      });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("EXTERNAL_WALLET: " + response.walletName!);
  }


  withdrawalRequest()async{
    var headers = {
      'Cookie': 'ci_session=a0f90f1dad3120582a7e82ff4b7cbff5c4e3ab4b'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/request_wallet'));
    request.fields.addAll({
      'user_id': '${userID}',
      'amount_requested': amountController.text
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      setState(() {
        Fluttertoast.showToast(msg: '${jsonResponse['msg']}');
      });
      Navigator.pop(context,true);
    }
    else {
      print(response.reasonPhrase);
    }

  }

  razorpayPayment(double price) async {
    String? contact = "9090909090";
    String? email = "dummy@gmail.com";

    double amt = price * 100;

    if (contact != '' && email != '') {
      if (mounted)
        setState(() {
          _isProgress = true;
        });
        var options = {
        'key': 'rzp_test_UUBtmcArqOLqIY',
        'amount': amt.toString(),
        'name': "dummy user",
        'prefill': {'contact': contact, 'email': email},
        };
        print("params here ${options}");
      try {
        print("yes");
        _razorpay.open(options);
        updateWallerFunction();
      } catch (e) {
        print("no");
        debugPrint(e.toString());
      }
    } else {
      if (email == '')
        setSnackbar("Email is required");
      else if (contact == '') setSnackbar("Contact is required");
    }
  }

  // listItem(int index) {
  //   Color back;
  //   if (tranList[index].type == "credit") {
  //     back = Colors.green;
  //   } else
  //     back = Colors.red;
  //   return Card(
  //     elevation: 0,
  //     margin: EdgeInsets.all(5.0),
  //     child: InkWell(
  //         borderRadius: BorderRadius.circular(4),
  //         child: Padding(
  //             padding: EdgeInsets.all(8.0),
  //             child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: <Widget>[
  //                       Expanded(
  //                         child: Text(
  //                           getTranslated(context, 'AMOUNT')! +
  //                               " : " +
  //                               CUR_CURRENCY! +
  //                               " " +
  //                               tranList[index].amt!,
  //                           style: TextStyle(
  //                               color: Theme.of(context).colorScheme.fontColor,
  //                               fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                       Text(tranList[index].date!),
  //                     ],
  //                   ),
  //                   Divider(),
  //                   Row(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: <Widget>[
  //                       Text(getTranslated(context, 'ID_LBL')! +
  //                           " : " +
  //                           tranList[index].id!),
  //                       Spacer(),
  //                       Container(
  //                         margin: EdgeInsets.only(left: 8),
  //                         padding:
  //                         EdgeInsets.symmetric(horizontal: 10, vertical: 2),
  //                         decoration: BoxDecoration(
  //                             color: back,
  //                             borderRadius: new BorderRadius.all(
  //                                 const Radius.circular(4.0))),
  //                         child: Text(
  //                           tranList[index].type!,
  //                           style: TextStyle(
  //                               color: Theme.of(context).colorScheme.white),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                   tranList[index].msg != null &&
  //                       tranList[index].msg!.isNotEmpty
  //                       ? Text(getTranslated(context, 'MSG')! +
  //                       " : " +
  //                       tranList[index].msg!)
  //                       : Container(),
  //                 ]))),
  //   );
  // }

  Future<Null> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  setSnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      elevation: 1.0,
    ));
  }

  @override
  void dispose() {
    buttonController!.dispose();
    _razorpay.clear();
    super.dispose();
  }

  // Future<Null> _refresh() {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   offset = 0;
  //   total = 0;
  // //  tranList.clear();
  //  // return getTransaction();
  // }

  // _scrollListener() {
  //   if (controller.offset >= controller.position.maxScrollExtent &&
  //       !controller.position.outOfRange) {
  //     if (this.mounted) {
  //       setState(() {
  //         isLoadingmore = true;
  //
  //         if (offset < total) getTransaction();
  //       });
  //     }
  //   }
  // }

  // Future<void> _getpaymentMethod() async {
  //
  //   if (_isNetworkAvail) {
  //     try {
  //       var parameter = {
  //         'type': 'payment_method',
  //       };
  //       Response response =
  //       await post(getSettingApi, body: parameter, headers: headers)
  //           .timeout(Duration(seconds: timeOut));
  //       if (response.statusCode == 200) {
  //         var getdata = json.decode(response.body);
  //
  //         bool error = getdata["error"];
  //
  //         if (!error) {
  //           var data = getdata["data"];
  //
  //           var payment = data["payment_method"];
  //
  //           paypal = payment["paypal_payment_method"] == "1" ? true : false;
  //           paumoney =
  //           payment["payumoney_payment_method"] == "1" ? true : false;
  //           flutterwave =
  //           payment["flutterwave_payment_method"] == "1" ? true : false;
  //           razorpay = payment["razorpay_payment_method"] == "1" ? true : false;
  //           paystack = payment["paystack_payment_method"] == "1" ? true : false;
  //           stripe = payment["stripe_payment_method"] == "1" ? true : false;
  //           paytm = payment["paytm_payment_method"] == "1" ? true : false;
  //
  //           if (razorpay!) razorpayId = payment["razorpay_key_id"];
  //           if (paystack!) {
  //             paystackId = payment["paystack_key_id"];
  //
  //             paystackPlugin.initialize(publicKey: paystackId!);
  //           }
  //           if (stripe!) {
  //             stripeId = payment['stripe_publishable_key'];
  //             stripeSecret = payment['stripe_secret_key'];
  //             stripeCurCode = payment['stripe_currency_code'];
  //             stripeMode = payment['stripe_mode'] ?? 'test';
  //             StripeService.secret = stripeSecret;
  //             StripeService.init(stripeId, stripeMode);
  //           }
  //           if (paytm!) {
  //             paytmMerId = payment['paytm_merchant_id'];
  //             paytmMerKey = payment['paytm_merchant_key'];
  //             payTesting =
  //             payment['paytm_payment_mode'] == 'sandbox' ? true : false;
  //           }
  //
  //           for (int i = 0; i < paymentMethodList.length; i++) {
  //             payModel.add(RadioModel(
  //                 isSelected: i == selectedMethod ? true : false,
  //                 name: paymentMethodList[i],
  //                 img: paymentIconList[i]));
  //           }
  //         }
  //       }
  //       if (mounted)
  //         setState(() {
  //           _isLoading = false;
  //         });
  //       if (dialogState != null) dialogState!(() {});
  //     } on TimeoutException catch (_) {
  //       // setSnackbar(getTranslated(context, 'somethingMSg')!);
  //     }
  //   } else {
  //     if (mounted)
  //       setState(() {
  //         _isNetworkAvail = false;
  //       });
  //   }
  // }

  showContent() {
    return SingleChildScrollView(
      controller: controller,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        color: backgroundblack,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "${getTranslated(context, 'currentBalance')}",
                        style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),

                 wallet == null || wallet == "" ? Text("0.00") : Text("\u{20B9} ${wallet}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15),),
                  // InkWell(
                  //   onTap: () {
                  //
                  //       _showDialog();
                  //       print("it is tapped here");
                  //
                  //   },
                  //   child: Container(
                  //     margin: EdgeInsets.only(top: 10),
                  //     height: 35,
                  //     width: MediaQuery.of(context).size.width / 2,
                  //     alignment: Alignment.center,
                  //     decoration: BoxDecoration(
                  //       color: backgroundblack,
                  //       borderRadius: BorderRadius.circular(6),
                  //     ),
                  //     child: Text(
                  //       "Add money",
                  //       style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w500),
                  //     ),
                  //   ),
                  // ),

                  SizedBox(height: 30,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        showFields = !showFields;
                      });
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width/2,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: backgroundblack
                      ),
                      child: Text("Withdrawal request",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14),),),
                  ),

                  SizedBox(height: 20,),
               showFields == true ?   Container(
                    child: Column(
                      children: [
                        TextFormField(
                          controller:amountController,
                          keyboardType: TextInputType.number,
                          decoration:InputDecoration(
                            hintText: "Enter Amount",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                          ),
                        ),
                        SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            withdrawalRequest(); 
                          },
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width/2,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: backgroundblack
                            ),
                            child: Text("Send",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14),),),
                        ),
                      ],
                    ),
                  ) : SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
        // tranList.length == 0
        //     ? getNoItem(context)
        //     : ListView.builder(
        //   shrinkWrap: true,
        //   itemCount: (offset < total)
        //       ? tranList.length + 1
        //       : tranList.length,
        //   physics: NeverScrollableScrollPhysics(),
        //   itemBuilder: (context, index) {
        //     return (index == tranList.length && isLoadingmore)
        //         ? Center(child: CircularProgressIndicator())
        //         : listItem(index);
        //  },
        //),
      ]),
    );
  }
}
