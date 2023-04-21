import 'dart:convert';
/// response_code : "0"
/// msg : "Cities Data "
/// data : [{"id":"1","name":"Jaipur","image":"6368ffdd58b9c.jpg","description":"Jaipur, the pink city, is a place that will continue to live in your dreams for long with its memorable blend of heritage and culture. Its rich heritage will stay as fond memories in your lens forever through which you can relive the charm of the city and cherish the authenticity of Rajasthan over and over. Also called 'the Paris of India', Jaipur won't fail to mesmerise you with its architectural brilliance and royal magnificence.","country_id":"1","state_id":"12","created_at":"2022-11-07 12:53:49","updated_at":"2022-11-07 12:53:49"},{"id":"2","name":"Mumbai","image":"6369000c4cd6f.jpg","description":"If there's one city which is active all the day round, it's the city of dreams “Bombay”. It's always on the rails with diverse people chasing so many dreams and aiming to become zero to hero! This modern city with old world charm is known to fulfil the dreams of people around the country. The Maharashtrian cuisine, from street-side vada pavs and pani puris to the magnificent Taj, the city has to offer everyone a share of its delicacies and success.","country_id":"1","state_id":"1","created_at":"2022-11-07 12:54:36","updated_at":"2022-11-07 12:54:36"},{"id":"3","name":"Delhi","image":"6369002f4f987.jpg","description":"The capital of India, famous for its heritage, culture, people and food, never fails to make a special place in its visitor's hearts. The red contemporary buildings etch into a traveller's mind depicting historic grandeur. From busy flea markets to high-end luxury shopping malls, Delhi has a way to every traveller's heart through shopping and food. From purani dilli ki chaat to the lip-smacking paranthas of paranthe wali gali, your taste buds will refuse to forget the taste of Delhi's delicacies.","country_id":"1","state_id":"11","created_at":"2022-11-07 12:55:11","updated_at":"2022-11-07 12:55:11"},{"id":"4","name":"Bangalore","image":"6369067c1fddf.jpg","description":"The city of techies is a place for all the people on the map. Bangalore is popular for its technology industry and welcoming nature for newcomers. This is a mini continent blessed with all the flavours from weather to lands where you can find diverse landscapes and varying temperatures. A unique blend of British style and modern style is one of the main attractions for anyone who visits Bangalore.","country_id":"1","state_id":"9","created_at":"2022-11-07 12:55:55","updated_at":"2022-11-07 13:22:04"},{"id":"5","name":"Goa","image":"63690092d6a16.jpg","description":"The mini Hawaii of India is the go-to destination for any friends’ trip or a wedding or a family vacation for the party-holics in town. Goa is a colourful town with shacks all around amongst the waves and humidity making it a perfect spot for tourists. Its impressive coastline has several beaches with a serene view and offers a beautiful memory to blend in the heart and lens forever.","country_id":"1","state_id":"10","created_at":"2022-11-07 12:56:50","updated_at":"2022-11-07 12:56:50"},{"id":"6","name":"Cochin","image":"636900d9a63d4.jpg","description":"The city with a history of Arab, Chinese and European merchants yet with its glory towards the culture of India, it’s the city of Cochin for you! Its colonial bungalows and the diverse houses of worship is something that can be a “wow” moment for anyone. The biennale festival which is an attraction to see its main authentic dance form Kathakali is the highlight of this beautiful city.","country_id":"1","state_id":"8","created_at":"2022-11-07 12:58:01","updated_at":"2022-11-07 12:58:01"},{"id":"7","name":"Hyderabad","image":"63690134ed229.jpg","description":"The City of Pearls, Hyderabad is home to many masjids, temples, churches, and bazaars. The city has its Islamic culture mixed with the Andhra blood. Golconda and Charminar are notable wonders of the mesmerising city. Hyderabad's ancient global centre is home to much diversity and is famous for its varieties of Biryanis and South Indian Thali.","country_id":"1","state_id":"13","created_at":"2022-11-07 12:59:32","updated_at":"2022-11-07 12:59:32"},{"id":"8","name":"Coorg","image":"636901a6e1223.jpg","description":"Popular as the Scotland of India, Coorg is home to major tea and coffee companies across the country. It's a perfect tourist spot for anyone who loves the green lush and the white mist. The scenic beauty of clouds touching the hills can make you feel sublime and fall in love with the weather. The surroundings of Western Ghats and thick dense forests make this place a major tourist attraction.","country_id":"1","state_id":"9","created_at":"2022-11-07 13:01:26","updated_at":"2022-11-07 13:01:26"},{"id":"9","name":"Manali","image":"636901f4542d3.jpg","description":"To the backpackers, Manali is the perfect trip spot that you can explore with friends and family. The white stretches of mountains with abundant snow are one of its major attractions. This is the go-to place for all adventure freaks who love to try something new. In the winter, temperatures in Manali drop to minus degrees leaving you freezing. The place is one of the coldest in India with three hills adjacent to each other, each with a village and an old shrine.","country_id":"1","state_id":"6","created_at":"2022-11-07 13:02:44","updated_at":"2022-11-07 13:02:44"},{"id":"10","name":"Shimla","image":"63690265da89a.jpg","description":"Shimla greets you with its majestic snow-clad mountains, lush greenery and beautiful lakes. It holds the magic in the air which makes you drop your jaw. This is the perfect place for a vacation with family, friends or someone special. The place is pretty well known for its Victorian architecture and scenic beauty. Shimla offers the perfect view of snow and mountain ranges ranging into your camera through your eyes.","country_id":"1","state_id":"6","created_at":"2022-11-07 13:04:37","updated_at":"2022-11-07 13:04:37"},{"id":"11","name":"Chandigarh","image":"636902b83aa81.jpg","description":"The idea of serenity and a city are opposite concepts. Chandigarh, however, is a rare example of modernity co-existing with nature's preservation. It's known for its tidiness and beauty of maintenance. This city has one of the best architecture. Punjabi mirth is sometimes rivalled by their girth, and the foodies here often stay up late eating.","country_id":"1","state_id":"5","created_at":"2022-11-07 13:06:00","updated_at":"2022-11-07 13:06:00"},{"id":"12","name":"Amritsar","image":"636902e068706.jpg","description":"The rich Sikh culture’s land is a major tourist spot for Amritsar’s Golden Temple. It's a lifetime of experience to seek blessings from the golden temple and share a meal of langar with dozens of other devotees gathered around the enormous, volunteer-run kitchen. Amritsar is a place for all the Punjabi foodies to add to their “Must Try” list. Feel patriotism in its true sense during the Wagah Border Ceremony, and wander around the city during your expedition to the Pakistani border.","country_id":"1","state_id":"5","created_at":"2022-11-07 13:06:40","updated_at":"2022-11-07 13:06:40"},{"id":"13","name":"Nainital","image":"636903026f97f.jpg","description":"Nainital is a Himalayan resort town in Uttarakhand, India. It radiated around the very famous lake Naini, from which the state derives its name. Nainital is home to a variety of aquatic animals, including crocodiles. The serene lands with white flares of hills are scenic for the camera and a treat to the eyes. A ride on colourful boats in Nainital's lake is an unforgettable experience.","country_id":"1","state_id":"3","created_at":"2022-11-07 13:07:14","updated_at":"2022-11-07 13:07:14"},{"id":"14","name":"Agra","image":"636903315bc7e.jpg","description":"A peek into the great Mughal heritage of India can be witnessed and explored in the present-day city of Agra. Housing one of the Seven Wonders of the World, the Taj Mahal is undoubtedly one of the greatest symbols of love and India's pride. Banking along the Yamuna River is the city’s rich history and architecture, Agra offers an experience of not only Mughal heritage but also Roman catholic culture too which lures the tourists to dive deeper into the history of the city.","country_id":"1","state_id":"4","created_at":"2022-11-07 13:08:01","updated_at":"2022-11-07 13:08:01"},{"id":"15","name":"Dubai","image":"636903a192583.jpeg","description":"Luxury, Adventure and Entertainment define the life in Dubai!","country_id":"2","state_id":"14","created_at":"2022-11-07 13:09:53","updated_at":"2022-11-07 13:09:53"},{"id":"16","name":"Abu Dhabi","image":"636903ba8c8d1.jpeg","description":"A summer like none other! Abu Dhabi is the luxurious world your family would never get over.","country_id":"2","state_id":"14","created_at":"2022-11-07 13:10:18","updated_at":"2022-11-07 13:10:18"},{"id":"17","name":"Ras Al Khaimah (RAK)","image":"6369062745f4b.jpeg","description":"Ras Al Khaimah (RAK) lies at the northernmost part of the United Arab Emirates (UAE)","country_id":"2","state_id":"14","created_at":"2022-11-07 13:20:39","updated_at":"2022-11-07 13:20:39"},{"id":"18","name":"Sharjah","image":"63690652ec55f.jpg","description":"Whether travelling solo or with a bunch of friends, Sharjah is a must visit destination while you","country_id":"2","state_id":"14","created_at":"2022-11-07 13:21:22","updated_at":"2022-11-07 13:21:22"}]

NewCityModel newCityModelFromJson(String str) => NewCityModel.fromJson(json.decode(str));
String newCityModelToJson(NewCityModel data) => json.encode(data.toJson());
class NewCityModel {
  NewCityModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  NewCityModel.fromJson(dynamic json) {
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
NewCityModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => NewCityModel(  responseCode: responseCode ?? _responseCode,
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

/// id : "1"
/// name : "Jaipur"
/// image : "6368ffdd58b9c.jpg"
/// description : "Jaipur, the pink city, is a place that will continue to live in your dreams for long with its memorable blend of heritage and culture. Its rich heritage will stay as fond memories in your lens forever through which you can relive the charm of the city and cherish the authenticity of Rajasthan over and over. Also called 'the Paris of India', Jaipur won't fail to mesmerise you with its architectural brilliance and royal magnificence."
/// country_id : "1"
/// state_id : "12"
/// created_at : "2022-11-07 12:53:49"
/// updated_at : "2022-11-07 12:53:49"

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