class Setting {
  Setting({
      this.id, 
      this.data, 
      this.discription,});

  Setting.fromJson(dynamic json) {
    id = json['id'];
    data = json['data'];
    discription = json['discription'];
  }
  String? id;
  String? data;
  String? discription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['data'] = data;
    map['discription'] = discription;
    return map;
  }

}