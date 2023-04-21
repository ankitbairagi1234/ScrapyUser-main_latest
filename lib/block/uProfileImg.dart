import 'dart:io';

import 'package:ez/models/uProfileImg.dart';
import 'package:ez/repositary/repositary.dart';
import 'package:rxdart/rxdart.dart';

class UprofileImgBloc {
  final _signupBlocController = PublishSubject<UpdateProImg>();

  //Observable<UpdateProImg> get signupStream => _signupBlocController.stream;

  Future<UpdateProImg> uProfileImgSink(
    String email,
    String username,
    File image,
    String userID,
    String mobile,
    String address,
    String city,
    String country
  ) async {
    return await Repository().uProfileImg(email, username, image, userID,mobile,address,city,country);
  }

  dispose() {
    _signupBlocController.close();
  }
}

final uProfileImgBloc = UprofileImgBloc();
