import 'dart:convert';
/// response_code : "0"
/// msg : "Service Charge "
/// data : [{"id":"3","city_id":"2","state_id":"1","country_id":"1","charge":"100","cat_id":"86","catsub_id":"97"}]

GetServiceChargeModel getServiceChargeModelFromJson(String str) => GetServiceChargeModel.fromJson(json.decode(str));
String getServiceChargeModelToJson(GetServiceChargeModel data) => json.encode(data.toJson());
class GetServiceChargeModel {
  GetServiceChargeModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  GetServiceChargeModel.fromJson(dynamic json) {
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
GetServiceChargeModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => GetServiceChargeModel(  responseCode: responseCode ?? _responseCode,
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

/// id : "3"
/// city_id : "2"
/// state_id : "1"
/// country_id : "1"
/// charge : "100"
/// cat_id : "86"
/// catsub_id : "97"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? cityId, 
      String? stateId, 
      String? countryId, 
      String? charge, 
      String? catId, 
      String? catsubId,}){
    _id = id;
    _cityId = cityId;
    _stateId = stateId;
    _countryId = countryId;
    _charge = charge;
    _catId = catId;
    _catsubId = catsubId;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _cityId = json['city_id'];
    _stateId = json['state_id'];
    _countryId = json['country_id'];
    _charge = json['charge'];
    _catId = json['cat_id'];
    _catsubId = json['catsub_id'];
  }
  String? _id;
  String? _cityId;
  String? _stateId;
  String? _countryId;
  String? _charge;
  String? _catId;
  String? _catsubId;
Data copyWith({  String? id,
  String? cityId,
  String? stateId,
  String? countryId,
  String? charge,
  String? catId,
  String? catsubId,
}) => Data(  id: id ?? _id,
  cityId: cityId ?? _cityId,
  stateId: stateId ?? _stateId,
  countryId: countryId ?? _countryId,
  charge: charge ?? _charge,
  catId: catId ?? _catId,
  catsubId: catsubId ?? _catsubId,
);
  String? get id => _id;
  String? get cityId => _cityId;
  String? get stateId => _stateId;
  String? get countryId => _countryId;
  String? get charge => _charge;
  String? get catId => _catId;
  String? get catsubId => _catsubId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['city_id'] = _cityId;
    map['state_id'] = _stateId;
    map['country_id'] = _countryId;
    map['charge'] = _charge;
    map['cat_id'] = _catId;
    map['catsub_id'] = _catsubId;
    return map;
  }

}