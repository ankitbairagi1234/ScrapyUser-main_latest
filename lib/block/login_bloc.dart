import 'package:ez/models/login_modal.dart';
import 'package:ez/repositary/repositary.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final _loginBlocController = PublishSubject<LoginModel>();

  //Observable<LoginModel> get loginStream => _loginBlocController.stream;

  Future<LoginModel> loginSink(String username, String password,String token) async {
    return await Repository().loginApiRepository(username, password,token);
  }

  dispose() {
    _loginBlocController.close();
  }
}

final loginBloc = LoginBloc();
