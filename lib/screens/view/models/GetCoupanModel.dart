import 'dart:convert';
/// response_code : "1"
/// msg : "Coupans"
/// data : [{"id":"1","name":"Wel Come discounts","code":"WELCOME20","start_date":"2022-10-15","end_date":"2022-11-25","type":"1","discount":"100","status":"1","created_at":"2022-10-15 09:41:01","updated_at":"2022-10-29 07:55:34"},{"id":"12","name":"ravi","code":"ravi10","start_date":"2022-10-30","end_date":"2022-11-24","type":"1","discount":"50","status":"1","created_at":"2022-11-01 10:52:23","updated_at":"2022-11-01 10:59:17"},{"id":"13","name":"Diwali Offer ","code":"DI_123offer","start_date":"2022-11-11","end_date":"2022-12-02","type":"1","discount":"200","status":"1","created_at":"2022-11-03 13:06:08","updated_at":"2022-11-15 11:45:48"}]

GetCoupanModel getCoupanModelFromJson(String str) => GetCoupanModel.fromJson(json.decode(str));
String getCoupanModelToJson(GetCoupanModel data) => json.encode(data.toJson());
class GetCoupanModel {
  GetCoupanModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  GetCoupanModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<Data>? _data;
GetCoupanModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => GetCoupanModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// name : "Wel Come discounts"
/// code : "WELCOME20"
/// start_date : "2022-10-15"
/// end_date : "2022-11-25"
/// type : "1"
/// discount : "100"
/// status : "1"
/// created_at : "2022-10-15 09:41:01"
/// updated_at : "2022-10-29 07:55:34"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? name, 
      String? code, 
      String? startDate, 
      String? endDate, 
      String? type, 
      String? discount, 
      String? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _code = code;
    _startDate = startDate;
    _endDate = endDate;
    _type = type;
    _discount = discount;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _code = json['code'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _type = json['type'];
    _discount = json['discount'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _name;
  String? _code;
  String? _startDate;
  String? _endDate;
  String? _type;
  String? _discount;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  String? id,
  String? name,
  String? code,
  String? startDate,
  String? endDate,
  String? type,
  String? discount,
  String? status,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  code: code ?? _code,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  type: type ?? _type,
  discount: discount ?? _discount,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get name => _name;
  String? get code => _code;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get type => _type;
  String? get discount => _discount;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['code'] = _code;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['type'] = _type;
    map['discount'] = _discount;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}