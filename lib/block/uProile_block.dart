import 'package:ez/models/uProfileModal.dart';
import 'package:ez/repositary/repositary.dart';
import 'package:rxdart/rxdart.dart';

class UprofileBloc {
  final _signupBlocController = PublishSubject<UpdatePro>();

  //Observable<UpdatePro> get signupStream => _signupBlocController.stream;

  Future<UpdatePro> uProfileSink(
    String email,
    String username,
    String userID,
    String mobile,
    String address,
    String city,
    String country
  ) async {
    return await Repository().uProfile(email, username, userID,mobile,address,city,country);
  }

  dispose() {
    _signupBlocController.close();
  }
}

final ProfileBloc = UprofileBloc();
