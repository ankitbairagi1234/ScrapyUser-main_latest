import 'dart:convert';
/// response_code : "1"
/// msg : "Categories Found"
/// data : [{"id":"2","categories":"Industry ","image":"https://developmentalphawizz.com/Kabadi/uploads/637724c5b61ea.jpeg"},{"id":"3","categories":"service","image":"https://developmentalphawizz.com/Kabadi/uploads/63772da1881c5.jpg"}]

MaterCategoryModel materCategoryModelFromJson(String str) => MaterCategoryModel.fromJson(json.decode(str));
String materCategoryModelToJson(MaterCategoryModel data) => json.encode(data.toJson());
class MaterCategoryModel {
  MaterCategoryModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  MaterCategoryModel.fromJson(dynamic json) {
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
MaterCategoryModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => MaterCategoryModel(  responseCode: responseCode ?? _responseCode,
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

/// id : "2"
/// categories : "Industry "
/// image : "https://developmentalphawizz.com/Kabadi/uploads/637724c5b61ea.jpeg"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? categories, 
      String? image,}){
    _id = id;
    _categories = categories;
    _image = image;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _categories = json['categories'];
    _image = json['image'];
  }
  String? _id;
  String? _categories;
  String? _image;
Data copyWith({  String? id,
  String? categories,
  String? image,
}) => Data(  id: id ?? _id,
  categories: categories ?? _categories,
  image: image ?? _image,
);
  String? get id => _id;
  String? get categories => _categories;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['categories'] = _categories;
    map['image'] = _image;
    return map;
  }

}