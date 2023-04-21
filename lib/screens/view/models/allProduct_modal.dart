import 'dart:convert';
/// status : "1"
/// msg : "Service providers"
/// setting : [{"id":"6","fname":"S2m","lname":"Samy","email":"al_mughairi@hotmail.com","uname":"samysam","password":"95f7b60da218e92c4422ed51fa18dfa6","profile_image":"https://alphawizztest.tk/ondemand/uploads/profile_pics/6329ca1637046.jpg","status":"1"},{"id":"12","fname":"devesh dd","lname":"singh","email":"devesg@gmail.com","uname":"devesh123","password":"25d55ad283aa400af464c76d713c07ad","profile_image":"https://alphawizztest.tk/ondemand/uploads/profile_pics/6329563382504.jpeg","status":"1"},{"id":"13","fname":"Yogesh","lname":"Shukla","email":"Yogeshalpha@gmail.com","uname":"Yogesh Shukla","password":"25d55ad283aa400af464c76d713c07ad","profile_image":"https://alphawizztest.tk/ondemand/uploads/profile_pics/632e9be4218b7.jpeg","status":"1"},{"id":"16","fname":"12","lname":"14","email":"raghu@g","uname":"12@@@","password":"e10adc3949ba59abbe56e057f20f883e","profile_image":"https://alphawizztest.tk/ondemand/uploads/profile_pics/632ef808c9dfc.jpeg","status":"1"}]

AllProductModal allProductModalFromJson(String str) => AllProductModal.fromJson(json.decode(str));
String allProductModalToJson(AllProductModal data) => json.encode(data.toJson());
class AllProductModal {
  AllProductModal({
      String? status, 
      String? msg, 
      List<Setting>? setting,}){
    _status = status;
    _msg = msg;
    _setting = setting;
}

  AllProductModal.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['setting'] != null) {
      _setting = [];
      json['setting'].forEach((v) {
        _setting?.add(Setting.fromJson(v));
      });
    }
  }
  String? _status;
  String? _msg;
  List<Setting>? _setting;
AllProductModal copyWith({  String? status,
  String? msg,
  List<Setting>? setting,
}) => AllProductModal(  status: status ?? _status,
  msg: msg ?? _msg,
  setting: setting ?? _setting,
);
  String? get status => _status;
  String? get msg => _msg;
  List<Setting>? get setting => _setting;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_setting != null) {
      map['setting'] = _setting?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "6"
/// fname : "S2m"
/// lname : "Samy"
/// email : "al_mughairi@hotmail.com"
/// uname : "samysam"
/// password : "95f7b60da218e92c4422ed51fa18dfa6"
/// profile_image : "https://alphawizztest.tk/ondemand/uploads/profile_pics/6329ca1637046.jpg"
/// status : "1"

Setting settingFromJson(String str) => Setting.fromJson(json.decode(str));
String settingToJson(Setting data) => json.encode(data.toJson());
class Setting {
  Setting({
      String? id, 
      String? fname, 
      String? lname, 
      String? email, 
      String? uname, 
      String? password, 
      String? profileImage, 
      String? status,}){
    _id = id;
    _fname = fname;
    _lname = lname;
    _email = email;
    _uname = uname;
    _password = password;
    _profileImage = profileImage;
    _status = status;
}

  Setting.fromJson(dynamic json) {
    _id = json['id'];
    _fname = json['fname'];
    _lname = json['lname'];
    _email = json['email'];
    _uname = json['uname'];
    _password = json['password'];
    _profileImage = json['profile_image'];
    _status = json['status'];
  }
  String? _id;
  String? _fname;
  String? _lname;
  String? _email;
  String? _uname;
  String? _password;
  String? _profileImage;
  String? _status;
Setting copyWith({  String? id,
  String? fname,
  String? lname,
  String? email,
  String? uname,
  String? password,
  String? profileImage,
  String? status,
}) => Setting(  id: id ?? _id,
  fname: fname ?? _fname,
  lname: lname ?? _lname,
  email: email ?? _email,
  uname: uname ?? _uname,
  password: password ?? _password,
  profileImage: profileImage ?? _profileImage,
  status: status ?? _status,
);
  String? get id => _id;
  String? get fname => _fname;
  String? get lname => _lname;
  String? get email => _email;
  String? get uname => _uname;
  String? get password => _password;
  String? get profileImage => _profileImage;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['fname'] = _fname;
    map['lname'] = _lname;
    map['email'] = _email;
    map['uname'] = _uname;
    map['password'] = _password;
    map['profile_image'] = _profileImage;
    map['status'] = _status;
    return map;
  }

}