import 'dart:convert';
/// response_code : "1"
/// msg : "User address list"
/// data : [{"id":"17","user_id":"22","address":"PVXX+938, Ratna Lok Colony, Indore, Madhya Pradesh 452011, India","building":"3rd floor, above destiny cafe","city":"Indore","pincode":"0","state":"MP","country":"IN","is_default":"1","is_set_for":"1","lat":"22.7484373","lng":"75.8977125","alt_mobile":null,"created_at":"2022-09-27 12:56:29","updated_at":"2022-09-27 12:56:29","name":null},{"id":"18","user_id":"22","address":"PVXX+938, Ratna Lok Colony, Indore, Madhya Pradesh 452011, India","building":"3rd floor, above dc","city":"Indore","pincode":"0","state":"MP","country":"IN","is_default":"1","is_set_for":"1","lat":"22.7484425","lng":"75.8977117","alt_mobile":null,"created_at":"2022-09-27 13:00:00","updated_at":"2022-09-27 13:00:00","name":null},{"id":"21","user_id":"22","address":"PVXX+938, Ratna Lok Colony, Indore, Madhya Pradesh 452011, India","building":"3rd floor, dc cafe","city":"Indore","pincode":"452011","state":"MP","country":"IN","is_default":"1","is_set_for":"0","lat":"22.7484397","lng":"75.8977113","alt_mobile":"9897969594","created_at":"2022-09-27 13:35:39","updated_at":"2022-09-27 13:35:39","name":"Vinay "}]

AddressModel addressModelFromJson(String str) => AddressModel.fromJson(json.decode(str));
String addressModelToJson(AddressModel data) => json.encode(data.toJson());
class AddressModel {
  AddressModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  AddressModel.fromJson(dynamic json) {
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
AddressModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => AddressModel(  responseCode: responseCode ?? _responseCode,
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

/// id : "17"
/// user_id : "22"
/// address : "PVXX+938, Ratna Lok Colony, Indore, Madhya Pradesh 452011, India"
/// building : "3rd floor, above destiny cafe"
/// city : "Indore"
/// pincode : "0"
/// state : "MP"
/// country : "IN"
/// is_default : "1"
/// is_set_for : "1"
/// lat : "22.7484373"
/// lng : "75.8977125"
/// alt_mobile : null
/// created_at : "2022-09-27 12:56:29"
/// updated_at : "2022-09-27 12:56:29"
/// name : null

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? userId, 
      String? address, 
      String? building, 
      String? city, 
      String? pincode, 
      String? state, 
      String? country, 
      String? isDefault, 
      String? isSetFor, 
      String? lat, 
      String? lng, 
      dynamic altMobile, 
      String? createdAt, 
      String? updatedAt, 
      dynamic name,}){
    _id = id;
    _userId = userId;
    _address = address;
    _building = building;
    _city = city;
    _pincode = pincode;
    _state = state;
    _country = country;
    _isDefault = isDefault;
    _isSetFor = isSetFor;
    _lat = lat;
    _lng = lng;
    _altMobile = altMobile;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _name = name;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _address = json['address'];
    _building = json['building'];
    _city = json['city'];
    _pincode = json['pincode'];
    _state = json['state'];
    _country = json['country'];
    _isDefault = json['is_default'];
    _isSetFor = json['is_set_for'];
    _lat = json['lat'];
    _lng = json['lng'];
    _altMobile = json['alt_mobile'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _name = json['name'];
  }
  String? _id;
  String? _userId;
  String? _address;
  String? _building;
  String? _city;
  String? _pincode;
  String? _state;
  String? _country;
  String? _isDefault;
  String? _isSetFor;
  String? _lat;
  String? _lng;
  dynamic _altMobile;
  String? _createdAt;
  String? _updatedAt;
  dynamic _name;
Data copyWith({  String? id,
  String? userId,
  String? address,
  String? building,
  String? city,
  String? pincode,
  String? state,
  String? country,
  String? isDefault,
  String? isSetFor,
  String? lat,
  String? lng,
  dynamic altMobile,
  String? createdAt,
  String? updatedAt,
  dynamic name,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  address: address ?? _address,
  building: building ?? _building,
  city: city ?? _city,
  pincode: pincode ?? _pincode,
  state: state ?? _state,
  country: country ?? _country,
  isDefault: isDefault ?? _isDefault,
  isSetFor: isSetFor ?? _isSetFor,
  lat: lat ?? _lat,
  lng: lng ?? _lng,
  altMobile: altMobile ?? _altMobile,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  name: name ?? _name,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get address => _address;
  String? get building => _building;
  String? get city => _city;
  String? get pincode => _pincode;
  String? get state => _state;
  String? get country => _country;
  String? get isDefault => _isDefault;
  String? get isSetFor => _isSetFor;
  String? get lat => _lat;
  String? get lng => _lng;
  dynamic get altMobile => _altMobile;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['address'] = _address;
    map['building'] = _building;
    map['city'] = _city;
    map['pincode'] = _pincode;
    map['state'] = _state;
    map['country'] = _country;
    map['is_default'] = _isDefault;
    map['is_set_for'] = _isSetFor;
    map['lat'] = _lat;
    map['lng'] = _lng;
    map['alt_mobile'] = _altMobile;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['name'] = _name;
    return map;
  }

}