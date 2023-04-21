import 'dart:convert';
/// response_code : "1"
/// msg : "Coupans"
/// data : [{"id":"88","name":"Aditya Gupta","start_date":"2022-11-05","end_date":"2022-11-25","discount":"66","cat_id":"88","subcat_id":"92","c_name":"Metal ","c_name_a":"","icon":"","sub_title":"Metal Scrap","description":"Metal","img":"63723f3ca3387.jpg","type":"vip","p_id":"0","sub_name":"LED Bulbs ","subcategory_title":"LED Bulbs Scrap","sub_image":"63723e5eee5df.jpg"}]

OfferModel offerModelFromJson(String str) => OfferModel.fromJson(json.decode(str));
String offerModelToJson(OfferModel data) => json.encode(data.toJson());
class OfferModel {
  OfferModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  OfferModel.fromJson(dynamic json) {
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
OfferModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => OfferModel(  responseCode: responseCode ?? _responseCode,
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

/// id : "88"
/// name : "Aditya Gupta"
/// start_date : "2022-11-05"
/// end_date : "2022-11-25"
/// discount : "66"
/// cat_id : "88"
/// subcat_id : "92"
/// c_name : "Metal "
/// c_name_a : ""
/// icon : ""
/// sub_title : "Metal Scrap"
/// description : "Metal"
/// img : "63723f3ca3387.jpg"
/// type : "vip"
/// p_id : "0"
/// sub_name : "LED Bulbs "
/// subcategory_title : "LED Bulbs Scrap"
/// sub_image : "63723e5eee5df.jpg"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? name, 
      String? startDate, 
      String? endDate, 
      String? discount, 
      String? catId, 
      String? subcatId, 
      String? cName, 
      String? cNameA, 
      String? icon, 
      String? subTitle, 
      String? description, 
      String? img, 
      String? type, 
      String? pId, 
      String? subName, 
      String? subcategoryTitle, 
      String? subImage,}){
    _id = id;
    _name = name;
    _startDate = startDate;
    _endDate = endDate;
    _discount = discount;
    _catId = catId;
    _subcatId = subcatId;
    _cName = cName;
    _cNameA = cNameA;
    _icon = icon;
    _subTitle = subTitle;
    _description = description;
    _img = img;
    _type = type;
    _pId = pId;
    _subName = subName;
    _subcategoryTitle = subcategoryTitle;
    _subImage = subImage;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _discount = json['discount'];
    _catId = json['cat_id'];
    _subcatId = json['subcat_id'];
    _cName = json['c_name'];
    _cNameA = json['c_name_a'];
    _icon = json['icon'];
    _subTitle = json['sub_title'];
    _description = json['description'];
    _img = json['img'];
    _type = json['type'];
    _pId = json['p_id'];
    _subName = json['sub_name'];
    _subcategoryTitle = json['subcategory_title'];
    _subImage = json['sub_image'];
  }
  String? _id;
  String? _name;
  String? _startDate;
  String? _endDate;
  String? _discount;
  String? _catId;
  String? _subcatId;
  String? _cName;
  String? _cNameA;
  String? _icon;
  String? _subTitle;
  String? _description;
  String? _img;
  String? _type;
  String? _pId;
  String? _subName;
  String? _subcategoryTitle;
  String? _subImage;
Data copyWith({  String? id,
  String? name,
  String? startDate,
  String? endDate,
  String? discount,
  String? catId,
  String? subcatId,
  String? cName,
  String? cNameA,
  String? icon,
  String? subTitle,
  String? description,
  String? img,
  String? type,
  String? pId,
  String? subName,
  String? subcategoryTitle,
  String? subImage,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  discount: discount ?? _discount,
  catId: catId ?? _catId,
  subcatId: subcatId ?? _subcatId,
  cName: cName ?? _cName,
  cNameA: cNameA ?? _cNameA,
  icon: icon ?? _icon,
  subTitle: subTitle ?? _subTitle,
  description: description ?? _description,
  img: img ?? _img,
  type: type ?? _type,
  pId: pId ?? _pId,
  subName: subName ?? _subName,
  subcategoryTitle: subcategoryTitle ?? _subcategoryTitle,
  subImage: subImage ?? _subImage,
);
  String? get id => _id;
  String? get name => _name;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get discount => _discount;
  String? get catId => _catId;
  String? get subcatId => _subcatId;
  String? get cName => _cName;
  String? get cNameA => _cNameA;
  String? get icon => _icon;
  String? get subTitle => _subTitle;
  String? get description => _description;
  String? get img => _img;
  String? get type => _type;
  String? get pId => _pId;
  String? get subName => _subName;
  String? get subcategoryTitle => _subcategoryTitle;
  String? get subImage => _subImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['discount'] = _discount;
    map['cat_id'] = _catId;
    map['subcat_id'] = _subcatId;
    map['c_name'] = _cName;
    map['c_name_a'] = _cNameA;
    map['icon'] = _icon;
    map['sub_title'] = _subTitle;
    map['description'] = _description;
    map['img'] = _img;
    map['type'] = _type;
    map['p_id'] = _pId;
    map['sub_name'] = _subName;
    map['subcategory_title'] = _subcategoryTitle;
    map['sub_image'] = _subImage;
    return map;
  }

}