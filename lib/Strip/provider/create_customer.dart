import 'package:ez/constant/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CreateCutomer {
  Future createCutomer(String token, String email, BuildContext context) async {
    try {
      final response = await http.Client()
          .post(Uri.parse("https://api.stripe.com/v1/customers"), body: {
        "description": email,
        "source": token,
      }, headers: {
        'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
        'Authorization': 'Bearer $stripSecret'
      });
      print(response.body);
    } on Exception {
      throw Exception('No Internet connection');
    }
  }

}

final createCutomer = CreateCutomer();
