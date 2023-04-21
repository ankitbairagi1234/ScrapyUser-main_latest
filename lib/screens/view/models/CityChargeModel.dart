import 'dart:convert';
/// response_code : "0"
/// msg : "Service Charge "
/// data : [{"id":"97","city_id":"1","state_id":"1","country_id":"1","charge":"100","cat_id":"86","catsub_id":"97","c_name":"News Paper","c_name_a":"","icon":"","sub_title":"News Paper Scrap","description":"News Paper West","img":"636b571095027.jpg","type":"vip","p_id":"86"}]

CityChargeModel cityChargeModelFromJson(String str) => CityChargeModel.fromJson(json.decode(str));
String cityChargeModelToJson(CityChargeModel data) => json.encode(data.toJson());
class CityChargeModel {
  CityChargeModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  CityChargeModel.fromJson(dynamic json) {
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
CityChargeModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => CityChargeModel(  responseCode: responseCode ?? _responseCode,
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

/// id : "97"
/// city_id : "1"
/// state_id : "1"
/// country_id : "1"
/// charge : "100"
/// cat_id : "86"
/// catsub_id : "97"
/// c_name : "News Paper"
/// c_name_a : ""
/// icon : ""
/// sub_title : "News Paper Scrap"
/// description : "News Paper West"
/// img : "636b571095027.jpg"
/// type : "vip"
/// p_id : "86"

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
      String? catsubId, 
      String? cName, 
      String? cNameA, 
      String? icon, 
      String? subTitle, 
      String? description, 
      String? img, 
      String? type, 
      String? pId,}){
    _id = id;
    _cityId = cityId;
    _stateId = stateId;
    _countryId = countryId;
    _charge = charge;
    _catId = catId;
    _catsubId = catsubId;
    _cName = cName;
    _cNameA = cNameA;
    _icon = icon;
    _subTitle = subTitle;
    _description = description;
    _img = img;
    _type = type;
    _pId = pId;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _cityId = json['city_id'];
    _stateId = json['state_id'];
    _countryId = json['country_id'];
    _charge = json['charge'];
    _catId = json['cat_id'];
    _catsubId = json['catsub_id'];
    _cName = json['c_name'];
    _cNameA = json['c_name_a'];
    _icon = json['icon'];
    _subTitle = json['sub_title'];
    _description = json['description'];
    _img = json['img'];
    _type = json['type'];
    _pId = json['p_id'];
  }
  String? _id;
  String? _cityId;
  String? _stateId;
  String? _countryId;
  String? _charge;
  String? _catId;
  String? _catsubId;
  String? _cName;
  String? _cNameA;
  String? _icon;
  String? _subTitle;
  String? _description;
  String? _img;
  String? _type;
  String? _pId;
Data copyWith({  String? id,
  String? cityId,
  String? stateId,
  String? countryId,
  String? charge,
  String? catId,
  String? catsubId,
  String? cName,
  String? cNameA,
  String? icon,
  String? subTitle,
  String? description,
  String? img,
  String? type,
  String? pId,
}) => Data(  id: id ?? _id,
  cityId: cityId ?? _cityId,
  stateId: stateId ?? _stateId,
  countryId: countryId ?? _countryId,
  charge: charge ?? _charge,
  catId: catId ?? _catId,
  catsubId: catsubId ?? _catsubId,
  cName: cName ?? _cName,
  cNameA: cNameA ?? _cNameA,
  icon: icon ?? _icon,
  subTitle: subTitle ?? _subTitle,
  description: description ?? _description,
  img: img ?? _img,
  type: type ?? _type,
  pId: pId ?? _pId,
);
  String? get id => _id;
  String? get cityId => _cityId;
  String? get stateId => _stateId;
  String? get countryId => _countryId;
  String? get charge => _charge;
  String? get catId => _catId;
  String? get catsubId => _catsubId;
  String? get cName => _cName;
  String? get cNameA => _cNameA;
  String? get icon => _icon;
  String? get subTitle => _subTitle;
  String? get description => _description;
  String? get img => _img;
  String? get type => _type;
  String? get pId => _pId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['city_id'] = _cityId;
    map['state_id'] = _stateId;
    map['country_id'] = _countryId;
    map['charge'] = _charge;
    map['cat_id'] = _catId;
    map['catsub_id'] = _catsubId;
    map['c_name'] = _cName;
    map['c_name_a'] = _cNameA;
    map['icon'] = _icon;
    map['sub_title'] = _subTitle;
    map['description'] = _description;
    map['img'] = _img;
    map['type'] = _type;
    map['p_id'] = _pId;
    return map;
  }

}