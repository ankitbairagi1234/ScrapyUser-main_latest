import 'package:ez/constant/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

class ApplyCharges {
  Future applyCharges(String custID, BuildContext context, String price) async {
    // print("Original" + price.toString());
    //  var long2 = double.parse(price);
    //print("Original" + long2.toString());
    // var t = int.parse(price);

    // print("t" + t.toString());

    var newString = price.replaceAll(",", "");

    var totalAmount = double.parse(newString) * 100;

    var finalAmount = totalAmount.toStringAsFixed(0);

    print(finalAmount + "<><><><><><");
    // print(totalAmount.toString() + ">>><<<");

    // String amount = "${price.toStringAsFixed(0)}";

    // print(amount.toString() + "<><><><><><");
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // final myString = preferences.getString('price') ?? '';

    try {
      final response = await http.Client().post(
        Uri.parse("https://api.stripe.com/v1/charges"),
        body: {
          "amount": finalAmount.toString(),
          "currency": "usd",
          "customer": custID,
          "description": "Testing"
        },
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
          'Authorization': 'Bearer $stripSecret'
        },
      );
      print(response.body);
    } on Exception {
      throw Exception('No Internet connection');
    }
  }

}

final applyCharges = ApplyCharges();
