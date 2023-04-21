class NewSubCategoryModel {
  String? responseCode;
  String? msg;
  List<Data>? data;

  NewSubCategoryModel({this.responseCode, this.msg, this.data});

  NewSubCategoryModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? cityId;
  String? stateId;
  String? countryId;
  String? charge;
  String? catId;
  String? catsubId;
  String? cName;
  String? cNameA;
  String? icon;
  String? subTitle;
  String? description;
  String? img;
  String? type;
  String? pId;
  String? mCatId;

  Data(
      {this.id,
        this.cityId,
        this.stateId,
        this.countryId,
        this.charge,
        this.catId,
        this.catsubId,
        this.cName,
        this.cNameA,
        this.icon,
        this.subTitle,
        this.description,
        this.img,
        this.type,
        this.pId,
        this.mCatId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityId = json['city_id'];
    stateId = json['state_id'];
    countryId = json['country_id'];
    charge = json['charge'];
    catId = json['cat_id'];
    catsubId = json['catsub_id'];
    cName = json['c_name'];
    cNameA = json['c_name_a'];
    icon = json['icon'];
    subTitle = json['sub_title'];
    description = json['description'];
    img = json['img'];
    type = json['type'];
    pId = json['p_id'];
    mCatId = json['m_cat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city_id'] = this.cityId;
    data['state_id'] = this.stateId;
    data['country_id'] = this.countryId;
    data['charge'] = this.charge;
    data['cat_id'] = this.catId;
    data['catsub_id'] = this.catsubId;
    data['c_name'] = this.cName;
    data['c_name_a'] = this.cNameA;
    data['icon'] = this.icon;
    data['sub_title'] = this.subTitle;
    data['description'] = this.description;
    data['img'] = this.img;
    data['type'] = this.type;
    data['p_id'] = this.pId;
    data['m_cat_id'] = this.mCatId;
    return data;
  }
}
