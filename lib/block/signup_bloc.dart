import 'package:ez/models/signup_model.dart';
import 'package:ez/repositary/repositary.dart';
import 'package:rxdart/rxdart.dart';

class SignupBloc {
  final _signupBlocController = PublishSubject<signupModel>();

  //Observable<signupModel> get signupStream => _signupBlocController.stream;

  Future<signupModel> signupSink(
    String email,
    String password,
    String username,
      String mobile,
      String latitude,
      String longitude,
      String? cityId,
  ) async {
    return await Repository().signupRepository(
      email,
      password,
      username,
      mobile,
      latitude,
      longitude,
      cityId,
    );
  }

  dispose() {
    _signupBlocController.close();
  }
}

final signupBloc = SignupBloc();
