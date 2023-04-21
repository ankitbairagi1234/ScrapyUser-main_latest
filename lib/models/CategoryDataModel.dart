import 'dart:convert';
/// response_code : "1"
/// msg : "Categories Found"
/// data : [{"id":"101","c_name":"test1","c_name_a":"","icon":"https://developmentalphawizz.com/Kabadi/uploads/","sub_title":"test","description":"test","img":"https://developmentalphawizz.com/Kabadi/uploads/637b7b8ddd398.jpeg","type":"vip","p_id":"0","m_cat_id":"2"},{"id":"102","c_name":"test","c_name_a":"","icon":"https://developmentalphawizz.com/Kabadi/uploads/","sub_title":"test","description":"test","img":"https://developmentalphawizz.com/Kabadi/uploads/637b7d9cb376d.jpeg","type":"vip","p_id":"101","m_cat_id":"2"}]

CategoryDataModel categoryDataModelFromJson(String str) => CategoryDataModel.fromJson(json.decode(str));
String categoryDataModelToJson(CategoryDataModel data) => json.encode(data.toJson());
class CategoryDataModel {
  CategoryDataModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  CategoryDataModel.fromJson(dynamic json) {
    _responseCode = json['response_code'] ;
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
CategoryDataModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => CategoryDataModel(  responseCode: responseCode ?? _responseCode,
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

/// id : "101"
/// c_name : "test1"
/// c_name_a : ""
/// icon : "https://developmentalphawizz.com/Kabadi/uploads/"
/// sub_title : "test"
/// description : "test"
/// img : "https://developmentalphawizz.com/Kabadi/uploads/637b7b8ddd398.jpeg"
/// type : "vip"
/// p_id : "0"
/// m_cat_id : "2"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? cName, 
      String? cNameA, 
      String? icon, 
      String? subTitle, 
      String? description, 
      String? img, 
      String? type, 
      String? pId, 
      String? mCatId,}){
    _id = id;
    _cName = cName;
    _cNameA = cNameA;
    _icon = icon;
    _subTitle = subTitle;
    _description = description;
    _img = img;
    _type = type;
    _pId = pId;
    _mCatId = mCatId;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _cName = json['c_name'];
    _cNameA = json['c_name_a'];
    _icon = json['icon'];
    _subTitle = json['sub_title'];
    _description = json['description'];
    _img = json['img'];
    _type = json['type'];
    _pId = json['p_id'];
    _mCatId = json['m_cat_id'];
  }
  String? _id;
  String? _cName;
  String? _cNameA;
  String? _icon;
  String? _subTitle;
  String? _description;
  String? _img;
  String? _type;
  String? _pId;
  String? _mCatId;
Data copyWith({  String? id,
  String? cName,
  String? cNameA,
  String? icon,
  String? subTitle,
  String? description,
  String? img,
  String? type,
  String? pId,
  String? mCatId,
}) => Data(  id: id ?? _id,
  cName: cName ?? _cName,
  cNameA: cNameA ?? _cNameA,
  icon: icon ?? _icon,
  subTitle: subTitle ?? _subTitle,
  description: description ?? _description,
  img: img ?? _img,
  type: type ?? _type,
  pId: pId ?? _pId,
  mCatId: mCatId ?? _mCatId,
);
  String? get id => _id;
  String? get cName => _cName;
  String? get cNameA => _cNameA;
  String? get icon => _icon;
  String? get subTitle => _subTitle;
  String? get description => _description;
  String? get img => _img;
  String? get type => _type;
  String? get pId => _pId;
  String? get mCatId => _mCatId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['c_name'] = _cName;
    map['c_name_a'] = _cNameA;
    map['icon'] = _icon;
    map['sub_title'] = _subTitle;
    map['description'] = _description;
    map['img'] = _img;
    map['type'] = _type;
    map['p_id'] = _pId;
    map['m_cat_id'] = _mCatId;
    return map;
  }

}