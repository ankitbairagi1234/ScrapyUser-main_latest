import 'dart:convert';
/// response_code : "1"
/// msg : "Destinations"
/// data : [{"id":"2","name":"Indore","image":"https://alphawizztest.tk/ondemand/uploads/city/633fd1b354a3d.jpg","description":"Indore is a city in west-central India. It’s known for the 7-story Rajwada Palace and the Lal Baag Palace, which date back to Indore’s 19th-century Holkar dynasty. The Holkar rulers are honored by a cluster of tombs and cenotaphs at Chhatri Baag. The night market Sarafa Bazar sells street food. East is the Indo-Gothic Gandhi Hall and clock tower. The Jain temple Kanch Mandir has a mirrored mosaic interior.","country_id":"5","state_id":"2","created_at":"2022-09-28 17:57:21","updated_at":"2022-10-07 12:43:55"},{"id":"4","name":"Mumbai","image":"https://alphawizztest.tk/ondemand/uploads/city/634906e5b6953.jpg","description":"Mumbai is a mix of iconic old-world charm architecture, strikingly modern high rises, cultural and traditional structures, and whatnot. The city is known as the commercial capital of India, but there is more to it than that. Mumbai is all about art, history, culture, food, theatre, cinema, nightlife and a lot more.","country_id":"5","state_id":"3","created_at":"2022-09-28 18:56:39","updated_at":"2022-10-14 12:21:17"},{"id":"6","name":"Bhopal","image":"https://alphawizztest.tk/ondemand/uploads/city/6349074077114.jpg","description":"There are many places for tourists in Bhopal like Upper Lake, lower lake, Birla Temple, Van Vihar, Bharat Bhavan, Indira Gandhi National Museum of Man, Manu Bhaun ki tekari, cave temples, the Taj-ul-Masjid, Jama Masjid, Gauhar Mahal, Shaukat Mahal, Regional Science Centre, Fish aquarium, Kerwa dam etc.","country_id":"5","state_id":"2","created_at":"2022-09-29 12:35:04","updated_at":"2022-10-14 12:22:48"},{"id":"7","name":"Jabalpur","image":"https://alphawizztest.tk/ondemand/uploads/city/634908cab4ad4.jpg","description":"Jabalpur is one of the most important city of Madhya Pradesh and also known as the cultural capital of state. The city is famous for major tourist attractions such as Dhuandhar Falls,Bhedaghat and Chausat Yogini Temple along with the festival of Navratri and Dusshera.","country_id":"5","state_id":"2","created_at":"2022-09-29 12:35:24","updated_at":"2022-10-14 12:29:22"}]

DestinationModel destinationModelFromJson(String str) => DestinationModel.fromJson(json.decode(str));
String destinationModelToJson(DestinationModel data) => json.encode(data.toJson());
class DestinationModel {
  DestinationModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  DestinationModel.fromJson(dynamic json) {
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
DestinationModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => DestinationModel(  responseCode: responseCode ?? _responseCode,
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
/// name : "Indore"
/// image : "https://alphawizztest.tk/ondemand/uploads/city/633fd1b354a3d.jpg"
/// description : "Indore is a city in west-central India. It’s known for the 7-story Rajwada Palace and the Lal Baag Palace, which date back to Indore’s 19th-century Holkar dynasty. The Holkar rulers are honored by a cluster of tombs and cenotaphs at Chhatri Baag. The night market Sarafa Bazar sells street food. East is the Indo-Gothic Gandhi Hall and clock tower. The Jain temple Kanch Mandir has a mirrored mosaic interior."
/// country_id : "5"
/// state_id : "2"
/// created_at : "2022-09-28 17:57:21"
/// updated_at : "2022-10-07 12:43:55"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? name, 
      String? image, 
      String? description, 
      String? countryId, 
      String? stateId, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _image = image;
    _description = description;
    _countryId = countryId;
    _stateId = stateId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _description = json['description'];
    _countryId = json['country_id'];
    _stateId = json['state_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _name;
  String? _image;
  String? _description;
  String? _countryId;
  String? _stateId;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  String? id,
  String? name,
  String? image,
  String? description,
  String? countryId,
  String? stateId,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  image: image ?? _image,
  description: description ?? _description,
  countryId: countryId ?? _countryId,
  stateId: stateId ?? _stateId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get name => _name;
  String? get image => _image;
  String? get description => _description;
  String? get countryId => _countryId;
  String? get stateId => _stateId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['description'] = _description;
    map['country_id'] = _countryId;
    map['state_id'] = _stateId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}