import 'dart:convert';
import 'dart:io';

import 'package:ez/constant/global.dart';
import 'package:ez/models/uProfileImg.dart';
import 'package:http/http.dart' as http;

class UprofileImgApi {
  Future<UpdateProImg> uProfileimgApi(
      String email, String username, File image, String userID,String mobile,String address,String city,String country) async {
    var responseJson;
    var uri = Uri.parse('${baseUrl()}user_edit');
    var request = http.MultipartRequest('POST', uri)
      ..fields['email'] = email
      ..fields['username'] = username
      ..fields['mobile'] = mobile
      ..fields['address'] = address
      ..fields['city'] = city
      ..fields['country'] = country
      ..fields['address'] = address
      ..files.add(
        await http.MultipartFile.fromPath(
          'profile_pic',
          image.path,
          // contentType: MediaType('application', 'x-tar'),
        ),
      )
      ..fields['id'] = userID;
    // var response = await request.send();
    http.Response response =
        await http.Response.fromStream(await request.send());
    responseJson = _returnResponse(response);
    return UpdateProImg.fromJson(responseJson);

    // var responseJson;
    // await http.post('${baseUrl()}/register', body: {
    //   'email': email,
    //   'password': password,
    //   'username': username,
    //   'profile_pic': image,
    // }).then((response) {
    //   responseJson = _returnResponse(response);
    // }).catchError((onError) {
    //   print(onError);
    // });
    // return SignUpModel.fromJson(responseJson);
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());

        return responseJson;
      case 400:
        throw Exception(response.body.toString());
      case 401:
        throw Exception(response.body.toString());
      case 403:
        throw Exception(response.body.toString());
      case 500:
      default:
        throw Exception(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
