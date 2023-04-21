// ignore: camel_case_types
class AllCateModel {
  int? status;
  String? msg;
  List<Categories>? categories;

  AllCateModel({this.status, this.msg, this.categories});

  AllCateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['categories'] != null) {
      categories = List<Categories>.empty(growable: true);
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? id;
  String? cName;
  String? cNameA;
  String? description;
  String? subTittle;
  String? icon;
  String? img;
  String? type;
  bool? dataV = false;

  Categories(
      {this.id,
        this.cName,
        this.description,
        this.subTittle,
        this.cNameA,
        this.icon,
        this.img,
        this.type,
        this.dataV});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cName = json['c_name'];
    cNameA = json['c_name_a'];
    icon = json['icon'];
    img = json['img'];
    subTittle = json['sub_title'];
    description = json['description'];
    type = json['type'];
    dataV = json['dataV'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['c_name'] = this.cName;
    data['c_name_a'] = this.cNameA;
    data['icon'] = this.icon;
    data['description'] = this.description;
    data['sub_title'] = this.subTittle;
    data['img'] = this.img;
    data['type'] = this.type;
    data['dataV'] = this.dataV;
    return data;
  }
}