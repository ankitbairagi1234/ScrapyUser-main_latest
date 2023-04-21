class Categories {
  Categories({
      this.id, 
      this.cName, 
      this.cNameA, 
      this.icon, 
      this.subTitle, 
      this.description, 
      this.img, 
      this.type, 
      this.pId,});

  Categories.fromJson(dynamic json) {
    id = json['id'];
    cName = json['c_name'];
    cNameA = json['c_name_a'];
    icon = json['icon'];
    subTitle = json['sub_title'];
    description = json['description'];
    img = json['img'];
    type = json['type'];
    pId = json['p_id'];
  }
  String? id;
  String? cName;
  String? cNameA;
  String? icon;
  String? subTitle;
  String? description;
  String? img;
  String? type;
  String? pId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['c_name'] = cName;
    map['c_name_a'] = cNameA;
    map['icon'] = icon;
    map['sub_title'] = subTitle;
    map['description'] = description;
    map['img'] = img;
    map['type'] = type;
    map['p_id'] = pId;
    return map;
  }

}