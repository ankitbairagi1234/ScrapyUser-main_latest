// import 'dart:convert';
// /// status : 1
// /// msg : "Service Found"
// /// restaurants : [{"res_id":"196","cat_id":"44","scat_id":"61","res_name":"hair treatment ","res_name_u":"","res_desc":"hair treatment good ","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://alphawizztest.tk/ondemand/uploads/"},"logo":["https://alphawizztest.tk/ondemand/uploads/634167d11faf3.jpg","https://alphawizztest.tk/ondemand/uploads/634167d12024d.jpg"],"res_phone":"","res_address":"","res_isOpen":"open","res_status":"active","res_create_date":"08 Oct 2022","res_ratings":"","status":"1","res_video":"","res_url":"","mfo":null,"lat":null,"lon":null,"vid":"45","country_id":"5","state_id":"2","city_id":"2","structure":null,"hours":null,"experts":null,"service_offered":"color, shampoo","price":"258","type":[],"c_name":"FASHION STYLIST","sub_cat":"COMMERCIAL","all_image":["https://alphawizztest.tk/ondemand/uploads/"],"review_count":0,"reviews":[]}]
//
// CatModel catModelFromJson(String str) => CatModel.fromJson(json.decode(str));
// String catModelToJson(CatModel data) => json.encode(data.toJson());
// class CatModel {
//   CatModel({
//       num? status,
//       String? msg,
//       List<Restaurants>? restaurants,}){
//     _status = status;
//     _msg = msg;
//     _restaurants = restaurants;
// }
//
//   CatModel.fromJson(dynamic json) {
//     _status = json['status'];
//     _msg = json['msg'];
//     if (json['restaurants'] != null) {
//       _restaurants = [];
//       json['restaurants'].forEach((v) {
//         _restaurants?.add(Restaurants.fromJson(v));
//       });
//     }
//   }
//   num? _status;
//   String? _msg;
//   List<Restaurants>? _restaurants;
// CatModel copyWith({  num? status,
//   String? msg,
//   List<Restaurants>? restaurants,
// }) => CatModel(  status: status ?? _status,
//   msg: msg ?? _msg,
//   restaurants: restaurants ?? _restaurants,
// );
//   num? get status => _status;
//   String? get msg => _msg;
//   List<Restaurants>? get restaurants => _restaurants;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = _status;
//     map['msg'] = _msg;
//     if (_restaurants != null) {
//       map['restaurants'] = _restaurants?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// /// res_id : "196"
// /// cat_id : "44"
// /// scat_id : "61"
// /// res_name : "hair treatment "
// /// res_name_u : ""
// /// res_desc : "hair treatment good "
// /// res_desc_u : ""
// /// res_website : ""
// /// res_image : {"res_imag0":"https://alphawizztest.tk/ondemand/uploads/"}
// /// logo : ["https://alphawizztest.tk/ondemand/uploads/634167d11faf3.jpg","https://alphawizztest.tk/ondemand/uploads/634167d12024d.jpg"]
// /// res_phone : ""
// /// res_address : ""
// /// res_isOpen : "open"
// /// res_status : "active"
// /// res_create_date : "08 Oct 2022"
// /// res_ratings : ""
// /// status : "1"
// /// res_video : ""
// /// res_url : ""
// /// mfo : null
// /// lat : null
// /// lon : null
// /// vid : "45"
// /// country_id : "5"
// /// state_id : "2"
// /// city_id : "2"
// /// structure : null
// /// hours : null
// /// experts : null
// /// service_offered : "color, shampoo"
// /// price : "258"
// /// type : []
// /// c_name : "FASHION STYLIST"
// /// sub_cat : "COMMERCIAL"
// /// all_image : ["https://alphawizztest.tk/ondemand/uploads/"]
// /// review_count : 0
// /// reviews : []
//
// Restaurants restaurantsFromJson(String str) => Restaurants.fromJson(json.decode(str));
// String restaurantsToJson(Restaurants data) => json.encode(data.toJson());
// class Restaurants {
//   Restaurants({
//       String? resId,
//       String? catId,
//       String? scatId,
//       String? resName,
//       String? resNameU,
//       String? resDesc,
//       String? resDescU,
//       String? resWebsite,
//       ResImage? resImage,
//       List<String>? logo,
//       String? resPhone,
//       String? resAddress,
//       String? resIsOpen,
//       String? resStatus,
//       String? resCreateDate,
//       String? resRatings,
//       String? status,
//       String? resVideo,
//       String? resUrl,
//       dynamic mfo,
//       dynamic lat,
//       dynamic lon,
//       String? vid,
//       String? countryId,
//       String? stateId,
//       String? cityId,
//       dynamic structure,
//       dynamic hours,
//       dynamic experts,
//       String? serviceOffered,
//       String? price,
//       List<dynamic>? type,
//       String? cName,
//       String? subCat,
//       List<String>? allImage,
//       num? reviewCount,
//       List<dynamic>? reviews,}){
//     _resId = resId;
//     _catId = catId;
//     _scatId = scatId;
//     _resName = resName;
//     _resNameU = resNameU;
//     _resDesc = resDesc;
//     _resDescU = resDescU;
//     _resWebsite = resWebsite;
//     _resImage = resImage;
//     _logo = logo;
//     _resPhone = resPhone;
//     _resAddress = resAddress;
//     _resIsOpen = resIsOpen;
//     _resStatus = resStatus;
//     _resCreateDate = resCreateDate;
//     _resRatings = resRatings;
//     _status = status;
//     _resVideo = resVideo;
//     _resUrl = resUrl;
//     _mfo = mfo;
//     _lat = lat;
//     _lon = lon;
//     _vid = vid;
//     _countryId = countryId;
//     _stateId = stateId;
//     _cityId = cityId;
//     _structure = structure;
//     _hours = hours;
//     _experts = experts;
//     _serviceOffered = serviceOffered;
//     _price = price;
//     _type = type;
//     _cName = cName;
//     _subCat = subCat;
//     _allImage = allImage;
//     _reviewCount = reviewCount;
//     _reviews = reviews;
// }
//
//   Restaurants.fromJson(dynamic json) {
//     _resId = json['res_id'];
//     _catId = json['cat_id'];
//     _scatId = json['scat_id'];
//     _resName = json['res_name'];
//     _resNameU = json['res_name_u'];
//     _resDesc = json['res_desc'];
//     _resDescU = json['res_desc_u'];
//     _resWebsite = json['res_website'];
//     _resImage = json['res_image'] != null ? ResImage.fromJson(json['res_image']) : null;
//      _logo = json['logo'] != null ? json['logo'].cast<String>() : [];
//      //_logo = json['logo'];
//     _resPhone = json['res_phone'];
//     _resAddress = json['res_address'];
//     _resIsOpen = json['res_isOpen'];
//     _resStatus = json['res_status'];
//     _resCreateDate = json['res_create_date'];
//     _resRatings = json['res_ratings'];
//     _status = json['status'];
//     _resVideo = json['res_video'];
//     _resUrl = json['res_url'];
//     _mfo = json['mfo'];
//     _lat = json['lat'];
//     _lon = json['lon'];
//     _vid = json['vid'];
//     _countryId = json['country_id'];
//     _stateId = json['state_id'];
//     _cityId = json['city_id'];
//     _structure = json['structure'];
//     _hours = json['hours'];
//     _experts = json['experts'];
//     _serviceOffered = json['service_offered'];
//     _price = json['price'];
//     if (json['type'] != null) {
//       _type = [];
//       json['type'].forEach((v) {
//         _type?.add(v.fromJson(v));
//       });
//     }
//     _cName = json['c_name'];
//     _subCat = json['sub_cat'];
//     _allImage = json['all_image'] != null ? json['all_image'].cast<String>() : [];
//     _reviewCount = json['review_count'];
//     if (json['reviews'] != null) {
//       _reviews = [];
//       json['reviews'].forEach((v) {
//         _reviews?.add(v.fromJson(v));
//       });
//     }
//   }
//   String? _resId;
//   String? _catId;
//   String? _scatId;
//   String? _resName;
//   String? _resNameU;
//   String? _resDesc;
//   String? _resDescU;
//   String? _resWebsite;
//   ResImage? _resImage;
//   List<String>? _logo;
//   String? _resPhone;
//   String? _resAddress;
//   String? _resIsOpen;
//   String? _resStatus;
//   String? _resCreateDate;
//   String? _resRatings;
//   String? _status;
//   String? _resVideo;
//   String? _resUrl;
//   dynamic _mfo;
//   dynamic _lat;
//   dynamic _lon;
//   String? _vid;
//   String? _countryId;
//   String? _stateId;
//   String? _cityId;
//   dynamic _structure;
//   dynamic _hours;
//   dynamic _experts;
//   String? _serviceOffered;
//   String? _price;
//   List<dynamic>? _type;
//   String? _cName;
//   String? _subCat;
//   List<String>? _allImage;
//   num? _reviewCount;
//   List<dynamic>? _reviews;
// Restaurants copyWith({  String? resId,
//   String? catId,
//   String? scatId,
//   String? resName,
//   String? resNameU,
//   String? resDesc,
//   String? resDescU,
//   String? resWebsite,
//   ResImage? resImage,
//   List<String>? logo,
//   String? resPhone,
//   String? resAddress,
//   String? resIsOpen,
//   String? resStatus,
//   String? resCreateDate,
//   String? resRatings,
//   String? status,
//   String? resVideo,
//   String? resUrl,
//   dynamic mfo,
//   dynamic lat,
//   dynamic lon,
//   String? vid,
//   String? countryId,
//   String? stateId,
//   String? cityId,
//   dynamic structure,
//   dynamic hours,
//   dynamic experts,
//   String? serviceOffered,
//   String? price,
//   List<dynamic>? type,
//   String? cName,
//   String? subCat,
//   List<String>? allImage,
//   num? reviewCount,
//   List<dynamic>? reviews,
// }) => Restaurants(  resId: resId ?? _resId,
//   catId: catId ?? _catId,
//   scatId: scatId ?? _scatId,
//   resName: resName ?? _resName,
//   resNameU: resNameU ?? _resNameU,
//   resDesc: resDesc ?? _resDesc,
//   resDescU: resDescU ?? _resDescU,
//   resWebsite: resWebsite ?? _resWebsite,
//   resImage: resImage ?? _resImage,
//   logo: logo ?? _logo,
//   resPhone: resPhone ?? _resPhone,
//   resAddress: resAddress ?? _resAddress,
//   resIsOpen: resIsOpen ?? _resIsOpen,
//   resStatus: resStatus ?? _resStatus,
//   resCreateDate: resCreateDate ?? _resCreateDate,
//   resRatings: resRatings ?? _resRatings,
//   status: status ?? _status,
//   resVideo: resVideo ?? _resVideo,
//   resUrl: resUrl ?? _resUrl,
//   mfo: mfo ?? _mfo,
//   lat: lat ?? _lat,
//   lon: lon ?? _lon,
//   vid: vid ?? _vid,
//   countryId: countryId ?? _countryId,
//   stateId: stateId ?? _stateId,
//   cityId: cityId ?? _cityId,
//   structure: structure ?? _structure,
//   hours: hours ?? _hours,
//   experts: experts ?? _experts,
//   serviceOffered: serviceOffered ?? _serviceOffered,
//   price: price ?? _price,
//   type: type ?? _type,
//   cName: cName ?? _cName,
//   subCat: subCat ?? _subCat,
//   allImage: allImage ?? _allImage,
//   reviewCount: reviewCount ?? _reviewCount,
//   reviews: reviews ?? _reviews,
// );
//   String? get resId => _resId;
//   String? get catId => _catId;
//   String? get scatId => _scatId;
//   String? get resName => _resName;
//   String? get resNameU => _resNameU;
//   String? get resDesc => _resDesc;
//   String? get resDescU => _resDescU;
//   String? get resWebsite => _resWebsite;
//   ResImage? get resImage => _resImage;
//   List<String>? get logo => _logo;
//   String? get resPhone => _resPhone;
//   String? get resAddress => _resAddress;
//   String? get resIsOpen => _resIsOpen;
//   String? get resStatus => _resStatus;
//   String? get resCreateDate => _resCreateDate;
//   String? get resRatings => _resRatings;
//   String? get status => _status;
//   String? get resVideo => _resVideo;
//   String? get resUrl => _resUrl;
//   dynamic get mfo => _mfo;
//   dynamic get lat => _lat;
//   dynamic get lon => _lon;
//   String? get vid => _vid;
//   String? get countryId => _countryId;
//   String? get stateId => _stateId;
//   String? get cityId => _cityId;
//   dynamic get structure => _structure;
//   dynamic get hours => _hours;
//   dynamic get experts => _experts;
//   String? get serviceOffered => _serviceOffered;
//   String? get price => _price;
//   List<dynamic>? get type => _type;
//   String? get cName => _cName;
//   String? get subCat => _subCat;
//   List<String>? get allImage => _allImage;
//   num? get reviewCount => _reviewCount;
//   List<dynamic>? get reviews => _reviews;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['res_id'] = _resId;
//     map['cat_id'] = _catId;
//     map['scat_id'] = _scatId;
//     map['res_name'] = _resName;
//     map['res_name_u'] = _resNameU;
//     map['res_desc'] = _resDesc;
//     map['res_desc_u'] = _resDescU;
//     map['res_website'] = _resWebsite;
//     if (_resImage != null) {
//       map['res_image'] = _resImage?.toJson();
//     }
//     map['logo'] = _logo;
//     map['res_phone'] = _resPhone;
//     map['res_address'] = _resAddress;
//     map['res_isOpen'] = _resIsOpen;
//     map['res_status'] = _resStatus;
//     map['res_create_date'] = _resCreateDate;
//     map['res_ratings'] = _resRatings;
//     map['status'] = _status;
//     map['res_video'] = _resVideo;
//     map['res_url'] = _resUrl;
//     map['mfo'] = _mfo;
//     map['lat'] = _lat;
//     map['lon'] = _lon;
//     map['vid'] = _vid;
//     map['country_id'] = _countryId;
//     map['state_id'] = _stateId;
//     map['city_id'] = _cityId;
//     map['structure'] = _structure;
//     map['hours'] = _hours;
//     map['experts'] = _experts;
//     map['service_offered'] = _serviceOffered;
//     map['price'] = _price;
//     if (_type != null) {
//       map['type'] = _type?.map((v) => v.toJson()).toList();
//     }
//     map['c_name'] = _cName;
//     map['sub_cat'] = _subCat;
//     map['all_image'] = _allImage;
//     map['review_count'] = _reviewCount;
//     if (_reviews != null) {
//       map['reviews'] = _reviews?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// /// res_imag0 : "https://alphawizztest.tk/ondemand/uploads/"
//
// ResImage resImageFromJson(String str) => ResImage.fromJson(json.decode(str));
// String resImageToJson(ResImage data) => json.encode(data.toJson());
// class ResImage {
//   ResImage({
//       String? resImag0,}){
//     _resImag0 = resImag0;
// }
//
//   ResImage.fromJson(dynamic json) {
//     _resImag0 = json['res_imag0'];
//   }
//   String? _resImag0;
// ResImage copyWith({  String? resImag0,
// }) => ResImage(  resImag0: resImag0 ?? _resImag0,
// );
//   String? get resImag0 => _resImag0;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['res_imag0'] = _resImag0;
//     return map;
//   }
//
// }

class CatModal {
  int? status;
  String? msg;
  List<Restaurants>? restaurants;

  CatModal({this.status, this.msg, this.restaurants});

  CatModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['restaurants'] != null) {

      restaurants = List<Restaurants>.empty(growable: true);
      json['restaurants'].forEach((v) {
        restaurants!.add(new Restaurants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurants {
  String? resId;
  String? catId;
  String? scatId;
  String? resName;
  String? resNameU;
  String? resDesc;
  String? cityName;
  String? resRating;
  String? resDescU;
  String? resWebsite;
  ResImage? resImage;
  List<dynamic>? logo;
  String? resPhone;
  String? resAddress;
  String? resIsOpen;
  String? resStatus;
  String? resCreateDate;
  String? resRatings;
  String? status;
  String? resVideo;
  String? resUrl;
  String? mfo;
  String? lat;
  String? lon;
  String? vid;
  String? structure;
  String? hours;
  String? experts;
  String? cName;
  String? price;
  List<String>? allImage;
  int? reviewCount;
  List<Type>? type;
  List<Reviews>? reviews;

  Restaurants(
      {this.resId,
        this.catId,
        this.scatId,
        this.resName,
        this.cityName,
        this.resRating,
        this.resNameU,
        this.resDesc,
        this.resDescU,
        this.resWebsite,
        this.resImage,
        this.logo,
        this.resPhone,
        this.resAddress,
        this.resIsOpen,
        this.resStatus,
        this.resCreateDate,
        this.resRatings,
        this.status,
        this.resVideo,
        this.resUrl,
        this.mfo,
        this.lat,
        this.lon,
        this.vid,
        this.structure,
        this.hours,this.experts,
        this.cName,
        this.allImage,
        this.reviewCount,
        this.type,
        this.reviews,
        this.price});

  Restaurants.fromJson(Map<String, dynamic> json) {
    resId = json['res_id'];
    catId = json['cat_id'];
    scatId = json['scat_id'];
    cityName = json['city_name'];
    resRating = json['res_ratings'];
    resName = json['res_name'];
    resNameU = json['res_name_u'];
    resDesc = json['res_desc'];
    resDescU = json['res_desc_u'];
    resWebsite = json['res_website'];
    resImage = json['res_image'] != null
        ? new ResImage.fromJson(json['res_image'])
        : null;
    logo = json['logo'];
    resPhone = json['res_phone'];
    resAddress = json['res_address'];
    resIsOpen = json['res_isOpen'];
    resStatus = json['res_status'];
    resCreateDate = json['res_create_date'];
    resRatings = json['res_ratings'];
    status = json['status'];
    resVideo = json['res_video'];
    resUrl = json['res_url'];
    mfo = json['mfo'];
    lat = json['lat'];
    lon = json['lon'];
    vid = json['vid'];
    structure = json['structure'];
    hours = json['hours'];
    experts = json['experts'];
    cName = json['c_name'];
    allImage = json['all_image'].cast<String>();
    reviewCount = json['review_count'];
    price = json['price'];
    if (json['type'] != null) {
      // type = new List<Type>();
      type = List<Type>.empty(growable: true);
      json['type'].forEach((v) {
        type!.add(new Type.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      // reviews = new List<Reviews>();
      reviews = List<Reviews>.empty(growable: true);
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['res_id'] = this.resId;
    data['cat_id'] = this.catId;
    data['scat_id'] = this.scatId;
    data['res_ratings'] = this.resRating;
    data['city_name'] = this.cityName;
    data['res_name'] = this.resName;
    data['res_name_u'] = this.resNameU;
    data['res_desc'] = this.resDesc;
    data['res_desc_u'] = this.resDescU;
    data['res_website'] = this.resWebsite;
    if (this.resImage != null) {
      data['res_image'] = this.resImage!.toJson();
    }
    data['logo'] = this.logo;
    data['res_phone'] = this.resPhone;
    data['res_address'] = this.resAddress;
    data['res_isOpen'] = this.resIsOpen;
    data['res_status'] = this.resStatus;
    data['res_create_date'] = this.resCreateDate;
    data['res_ratings'] = this.resRatings;
    data['status'] = this.status;
    data['res_video'] = this.resVideo;
    data['res_url'] = this.resUrl;
    data['mfo'] = this.mfo;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['vid'] = this.vid;
    data['structure'] = this.structure;
    data['hours'] = this.hours;
    data['experts'] = this.experts;
    data['c_name'] = this.cName;
    data['all_image'] = this.allImage;
    data['review_count'] = this.reviewCount;
    data['price'] = this.price;
    if (this.type != null) {
      data['type'] = this.type!.map((v) => v.toJson()).toList();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResImage {
  String? resImag0;
  String? resImag1;
  String? resImag2;

  ResImage({this.resImag0, this.resImag1, this.resImag2});

  ResImage.fromJson(Map<String, dynamic> json) {
    resImag0 = json['res_imag0'];
    resImag1 = json['res_imag1'];
    resImag2 = json['res_imag2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['res_imag0'] = this.resImag0;
    data['res_imag1'] = this.resImag1;
    data['res_imag2'] = this.resImag2;
    return data;
  }
}

class Type {
  String? type;
  String? typeName;
  String? price;

  Type({this.type, this.typeName, this.price});

  Type.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    typeName = json['type_name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['type_name'] = this.typeName;
    data['price'] = this.price;
    return data;
  }
}

class Reviews {
  String? revId;
  String? revUser;
  String? revRes;
  String? revStars;
  String? revText;
  String? revDate;
  RevUserData? revUserData;

  Reviews(
      {this.revId,
        this.revUser,
        this.revRes,
        this.revStars,
        this.revText,
        this.revDate,
        this.revUserData});

  Reviews.fromJson(Map<String, dynamic> json) {
    revId = json['rev_id'];
    revUser = json['rev_user'];
    revRes = json['rev_res'];
    revStars = json['rev_stars'];
    revText = json['rev_text'];
    revDate = json['rev_date'];
    revUserData = json['rev_user_data'] != null
        ? new RevUserData.fromJson(json['rev_user_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rev_id'] = this.revId;
    data['rev_user'] = this.revUser;
    data['rev_res'] = this.revRes;
    data['rev_stars'] = this.revStars;
    data['rev_text'] = this.revText;
    data['rev_date'] = this.revDate;
    if (this.revUserData != null) {
      data['rev_user_data'] = this.revUserData!.toJson();
    }
    return data;
  }
}

class RevUserData {
  String? id;
  String? email;
  String? password;
  String? username;
  String? profilePic;
  String? isGold;
  String? date;
  String? mobile;
  String? address;
  String? city;
  String? country;

  RevUserData(
      {this.id,
        this.email,
        this.password,
        this.username,
        this.profilePic,
        this.isGold,
        this.date,
        this.mobile,
        this.address,
        this.city,
        this.country});

  RevUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    username = json['username'];
    profilePic = json['profile_pic'];
    isGold = json['isGold'];
    date = json['date'];
    mobile = json['mobile'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['password'] = this.password;
    data['username'] = this.username;
    data['profile_pic'] = this.profilePic;
    data['isGold'] = this.isGold;
    data['date'] = this.date;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    return data;
  }
}