import 'dart:io';
import 'package:ez/models/login_modal.dart';
import 'package:ez/models/profile_model.dart';
import 'package:ez/models/signup_model.dart';
import 'package:ez/models/uProfileImg.dart';
import 'package:ez/models/uProfileModal.dart';
import 'package:ez/provider/login_api.dart';
import 'package:ez/provider/profile_api.dart';
import 'package:ez/provider/signup_api.dart';
import 'package:ez/provider/uProfile.dart';
import 'package:ez/provider/uProfileImg_api.dart';

class Repository {
  Future<LoginModel> loginApiRepository(
      String username, String password,String token) async {
    return await LoginApi().loginApi(username, password,token);
  }

  Future<signupModel> signupRepository(
    String email,
    String password,
    String username,
      String mobile,
      String? latittude,
      String? longitude,
      String? cityId,
  ) async {
    return await SignupApi().signupApi(
      email,
      password,
      username,
      mobile,
      latittude,
      longitude,
      cityId
    );
  }

  Future<ProfileModel> profileRepository(String userID) async {
    return await ProfileApi().profileApi(userID);
  }

  Future<UpdateProImg> uProfileImg(
      String email,
      String username,
      File image,
      String id,
      String mobile,
      String address,
      String city,
      String country) async {
    return await UprofileImgApi().uProfileimgApi(
        email, username, image, id, mobile, address, city, country);
  }

  Future<UpdatePro> uProfile(String email, String username, String id,
      String mobile, String address, String city, String country) async {
    return await UprofileApi()
        .uProfileApi(email, username, id, mobile, address, city, country);
  }
}
