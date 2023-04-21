import 'dart:convert';
/// response_code : "1"
/// msg : "get successfully data"
/// data : [{"id":"6","c_name":null,"c_name_a":null,"icon":null,"sub_title":null,"description":null,"img":null,"type":null,"p_id":null,"sub_name":null,"subimage":null,"category_id":"1","subcategory_id":"2","user_id":"2","image":"1668065758Screenshot9.png","crated_date":"2022-11-10 07:35:58","qty":"2"},{"id":"5","c_name":"Computers and telecommunications","c_name_a":"","icon":"","sub_title":"Ewaste Scrap","description":"Computers and telecommunications West","img":"636b540fc2029.jpeg","type":"vip","p_id":"89","sub_name":"Ewaste","subimage":"636b442a42b7f.jpg","category_id":"91","subcategory_id":"89","user_id":"2","image":"1668065566Appicon2.png","crated_date":"2022-11-10 07:32:46","qty":"5"},{"id":"4","c_name":null,"c_name_a":null,"icon":null,"sub_title":null,"description":null,"img":null,"type":null,"p_id":null,"sub_name":null,"subimage":null,"category_id":"1","subcategory_id":"2","user_id":"2","image":"1668065413Screenshot9.png","crated_date":"2022-11-10 07:30:13","qty":"2"},{"id":"3","c_name":null,"c_name_a":null,"icon":null,"sub_title":null,"description":null,"img":null,"type":null,"p_id":null,"sub_name":null,"subimage":null,"category_id":"1","subcategory_id":"2","user_id":"2","image":"","crated_date":"2022-11-10 07:27:38","qty":"0"},{"id":"2","c_name":null,"c_name_a":null,"icon":null,"sub_title":null,"description":null,"img":null,"type":null,"p_id":null,"sub_name":null,"subimage":null,"category_id":"1","subcategory_id":"2","user_id":"2","image":"","crated_date":"2022-11-10 07:18:49","qty":"0"},{"id":"1","c_name":null,"c_name_a":null,"icon":null,"sub_title":null,"description":null,"img":null,"type":null,"p_id":null,"sub_name":null,"subimage":null,"category_id":"1","subcategory_id":"2","user_id":"2","image":"","crated_date":"2022-11-10 07:17:43","qty":"0"}]
/// image_path : "https://developmentalphawizz.com/Kabadi//uploads/scrap_image/"

GetScrapModel getScrapModelFromJson(String str) => GetScrapModel.fromJson(json.decode(str));
String getScrapModelToJson(GetScrapModel data) => json.encode(data.toJson());
class GetScrapModel {
  GetScrapModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data, 
      String? imagePath,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
    _imagePath = imagePath;
}

  GetScrapModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _imagePath = json['image_path'];
  }
  String? _responseCode;
  String? _msg;
  List<Data>? _data;
  String? _imagePath;
GetScrapModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
  String? imagePath,
}) => GetScrapModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
  imagePath: imagePath ?? _imagePath,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<Data>? get data => _data;
  String? get imagePath => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['image_path'] = _imagePath;
    return map;
  }

}

/// id : "6"
/// c_name : null
/// c_name_a : null
/// icon : null
/// sub_title : null
/// description : null
/// img : null
/// type : null
/// p_id : null
/// sub_name : null
/// subimage : null
/// category_id : "1"
/// subcategory_id : "2"
/// user_id : "2"
/// image : "1668065758Screenshot9.png"
/// crated_date : "2022-11-10 07:35:58"
/// qty : "2"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      dynamic cName, 
      dynamic cNameA, 
      dynamic icon, 
      dynamic subTitle, 
      dynamic description, 
      dynamic img,
      dynamic name,
      dynamic type, 
      dynamic pId, 
      dynamic subName,
      dynamic price,
      dynamic total,
      dynamic subimage,
    String? msid,
      String? categories,
      String? categoryId, 
      String? subcategoryId, 
      String? userId, 
      String? image, 
      String? cratedDate, 
      String? qty,}){
    _id = id;
    _cName = cName;
    _cNameA = cNameA;
    _icon = icon;
    _subTitle = subTitle;
    _description = description;
    _img = img;
    _total = total;
    _msid = msid;
    _categories = categories;
    _price = price;
    _name = name;
    _type = type;
    _pId = pId;
    _subName = subName;
    _subimage = subimage;
    _categoryId = categoryId;
    _subcategoryId = subcategoryId;
    _userId = userId;
    _image = image;
    _cratedDate = cratedDate;
    _qty = qty;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _cName = json['c_name'];
    _cNameA = json['c_name_a'];
    _categories = json['categories'];
    _total = json['total'];
    _price = json['price'];
    _msid = json['msid'];
    _name = json['scrap_name'];
    _icon = json['icon'];
    _subTitle = json['sub_title'];
    _description = json['description'];
    _img = json['img'];
    _type = json['type'];
    _pId = json['p_id'];
    _subName = json['sub_name'];
    _subimage = json['subimage'];
    _categoryId = json['category_id'];
    _subcategoryId = json['subcategory_id'];
    _userId = json['user_id'];
    _image = json['image'];
    _cratedDate = json['crated_date'];
    _qty = json['qty'];
  }
  String? _id;
  dynamic _cName;
  String? _msid;
  String? _categories;
  dynamic _cNameA;
  dynamic _total;
  dynamic _price;
  dynamic _name;
  dynamic _icon;
  dynamic _subTitle;
  dynamic _description;
  dynamic _img;
  dynamic _type;
  dynamic _pId;
  dynamic _subName;
  dynamic _subimage;
  String? _categoryId;
  String? _subcategoryId;
  String? _userId;
  String? _image;
  String? _cratedDate;
  String? _qty;
Data copyWith({  String? id,
  dynamic cName,
  dynamic cNameA,
  dynamic total,
  dynamic price,
  dynamic name,
  String? categories,
  String? msid,
  dynamic icon,
  dynamic subTitle,
  dynamic description,
  dynamic img,
  dynamic type,
  dynamic pId,
  dynamic subName,
  dynamic subimage,
  String? categoryId,
  String? subcategoryId,
  String? userId,
  String? image,
  String? cratedDate,
  String? qty,
}) => Data(  id: id ?? _id,
  cName: cName ?? _cName,
  cNameA: cNameA ?? _cNameA,
  icon: icon ?? _icon,
  price: price ?? _price,
  msid: msid ?? _msid,
  categories: categories ?? _categories,
  total: total ?? _total,
  name: name ?? _name,
  subTitle: subTitle ?? _subTitle,
  description: description ?? _description,
  img: img ?? _img,
  type: type ?? _type,
  pId: pId ?? _pId,
  subName: subName ?? _subName,
  subimage: subimage ?? _subimage,
  categoryId: categoryId ?? _categoryId,
  subcategoryId: subcategoryId ?? _subcategoryId,
  userId: userId ?? _userId,
  image: image ?? _image,
  cratedDate: cratedDate ?? _cratedDate,
  qty: qty ?? _qty,
);
  String? get id => _id;
  dynamic get cName => _cName;
  dynamic get cNameA => _cNameA;
  dynamic get icon => _icon;
  dynamic get total => _total;
  dynamic get price => _price;
  String? get msid => _msid;
  dynamic get name => _name;
  dynamic get subTitle => _subTitle;
  dynamic get description => _description;
  dynamic get img => _img;
  dynamic get type => _type;
  dynamic get pId => _pId;
  dynamic get subName => _subName;
  dynamic get subimage => _subimage;
  String? get categories => _categories;
  String? get categoryId => _categoryId;
  String? get subcategoryId => _subcategoryId;
  String? get userId => _userId;
  String? get image => _image;
  String? get cratedDate => _cratedDate;
  String? get qty => _qty;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['price'] = _price;
    map['total'] = _total;
    map['msid'] = _msid;
    map['c_name'] = _cName;
    map['c_name_a'] = _cNameA;
    map['icon'] = _icon;
    map['sub_title'] = _subTitle;
    map['categories'] = _categories;
    map['description'] = _description;
    map['img'] = _img;
    map['scrap_name'] = name;
    map['type'] = _type;
    map['p_id'] = _pId;
    map['sub_name'] = _subName;
    map['subimage'] = _subimage;
    map['category_id'] = _categoryId;
    map['subcategory_id'] = _subcategoryId;
    map['user_id'] = _userId;
    map['image'] = _image;
    map['crated_date'] = _cratedDate;
    map['qty'] = _qty;
    return map;
  }

}