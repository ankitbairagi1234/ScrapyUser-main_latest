class Data {
  Data({
      this.id, 
      this.cityId, 
      this.stateId, 
      this.countryId, 
      this.charge, 
      this.catId, 
      this.catsubId,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    cityId = json['city_id'];
    stateId = json['state_id'];
    countryId = json['country_id'];
    charge = json['charge'];
    catId = json['cat_id'];
    catsubId = json['catsub_id'];
  }
  String? id;
  String? cityId;
  String? stateId;
  String? countryId;
  String? charge;
  String? catId;
  String? catsubId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['city_id'] = cityId;
    map['state_id'] = stateId;
    map['country_id'] = countryId;
    map['charge'] = charge;
    map['cat_id'] = catId;
    map['catsub_id'] = catsubId;
    return map;
  }

}