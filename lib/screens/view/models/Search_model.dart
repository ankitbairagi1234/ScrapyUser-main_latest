import 'dart:convert';
/// response_code : "1"
/// message : "Services Found!"
/// restaurants : [{"res_id":"111","cat_id":"15","scat_id":"17","res_name":"WEDDING","res_name_u":"","res_desc":" makeup artists","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://alphawizztest.tk/ondemand/uploads/6329bb2e12a45.jpg"},"logo":"https://alphawizztest.tk/ondemand/uploads/6329bb2e12f21.jpg","res_phone":"09632587410","res_address":"TestTestTestTest1111Restaurant Description22","res_isOpen":"open","res_status":"active","res_create_date":"1605959578","res_ratings":"3.5","status":"","res_video":"","res_url":"","mfo":"","lat":"","lon":"","vid":"12","structure":"a:1:{i:0;s:6:\"12,480\";}","hours":"2 to 4 Hrs","experts":"03 Experts","price":"200","type":"0","all_image":["https://alphawizztest.tk/ondemand/uploads/6329bb2e12a45.jpg"],"review_count":2},{"res_id":"112","cat_id":"18","scat_id":"17","res_name":"FASHION","res_name_u":"","res_desc":"When it comes to keeping your hands clean in an infected area with industry-standard ...","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://alphawizztest.tk/ondemand/uploads/6329b9290608d.jpg"},"logo":"https://alphawizztest.tk/ondemand/uploads/6329b9290650b.jpg","res_phone":"","res_address":"","res_isOpen":"","res_status":"","res_create_date":"1624674307","res_ratings":"3","status":"","res_video":"","res_url":"","mfo":"","lat":"","lon":"","vid":"4","structure":"a:1:{i:0;s:6:\"12,480\";}","hours":"3 to 6 Hrs","experts":"05 Experts","price":"750","type":"0","all_image":["https://alphawizztest.tk/ondemand/uploads/6329b9290608d.jpg"],"review_count":1},{"res_id":"131","cat_id":"18","scat_id":"22","res_name":"new store","res_name_u":"","res_desc":"fdfdf","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://alphawizztest.tk/ondemand/uploads/632af62b8cfcc.jpg"},"logo":"https://alphawizztest.tk/ondemand/uploads/632af62b8d950.jpg","res_phone":"","res_address":"","res_isOpen":"","res_status":"","res_create_date":"1663759915","res_ratings":"","status":"","res_video":"","res_url":"","mfo":"","lat":"","lon":"","vid":"12","structure":"a:1:{i:0;s:6:\"12,480\";}","hours":"4","experts":"5","price":"600","type":"0","all_image":["https://alphawizztest.tk/ondemand/uploads/632af62b8cfcc.jpg"],"review_count":0},{"res_id":"130","cat_id":"13","scat_id":"0","res_name":"WEDDING","res_name_u":"","res_desc":"Create timeless memories without the hassle. We’ll capture the moments you never want...","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://alphawizztest.tk/ondemand/uploads/6329b66b2b02e.jpg"},"logo":"https://alphawizztest.tk/ondemand/uploads/6329b66b2ba6b.jpg","res_phone":"","res_address":"","res_isOpen":"","res_status":"","res_create_date":"1663666702","res_ratings":"","status":"","res_video":"","res_url":"","mfo":"","lat":"","lon":"","vid":"6","structure":"a:1:{i:0;s:6:\"12,480\";}","hours":"2","experts":"2","price":"900","type":"0","all_image":["https://alphawizztest.tk/ondemand/uploads/6329b66b2b02e.jpg"],"review_count":0},{"res_id":"114","cat_id":"14","scat_id":"19","res_name":"COMMERCIAL","res_name_u":"","res_desc":"Personal presentation in a workplace impacts many aspects of business, when staff look...","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://alphawizztest.tk/ondemand/uploads/6329b9e05c60b.jpg"},"logo":"https://alphawizztest.tk/ondemand/uploads/6329b9e05cf32.jpg","res_phone":"","res_address":"","res_isOpen":"","res_status":"","res_create_date":"1624761589","res_ratings":"","status":"","res_video":"","res_url":"","mfo":"","lat":"","lon":"","vid":"12","structure":"a:1:{i:0;s:6:\"12,480\";}","hours":"2-3 Hrs","experts":"2 Experts","price":"980","type":"0","all_image":["https://alphawizztest.tk/ondemand/uploads/6329b9e05c60b.jpg"],"review_count":0},{"res_id":"115","cat_id":"13","scat_id":"19","res_name":"TRAVELLERS","res_name_u":"","res_desc":"Capture life's moments, anywhere!! We’ll connect you with the best available local photographer...","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://alphawizztest.tk/ondemand/uploads/6329b8e7e86f2.jpg"},"logo":"https://alphawizztest.tk/ondemand/uploads/6329b8e7e8c29.jpg","res_phone":"","res_address":"","res_isOpen":"","res_status":"","res_create_date":"1624761858","res_ratings":"","status":"","res_video":"","res_url":"","mfo":"","lat":"","lon":"","vid":"4","structure":"a:1:{i:0;s:6:\"12,480\";}","hours":"4 to 3 Hrs","experts":"2 Experts","price":"910","type":"0","all_image":["https://alphawizztest.tk/ondemand/uploads/6329b8e7e86f2.jpg"],"review_count":0},{"res_id":"116","cat_id":"14","scat_id":"19","res_name":"EVENTS / SPECIAL OCCASION","res_name_u":"","res_desc":"Do you have a special occasion that you want to look great from head to toe? We will tailor ...","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://alphawizztest.tk/ondemand/uploads/6329ba5f09667.jpg"},"logo":"https://alphawizztest.tk/ondemand/uploads/6329ba5f0991c.jpg","res_phone":"","res_address":"","res_isOpen":"","res_status":"","res_create_date":"1624761925","res_ratings":"","status":"","res_video":"","res_url":"","mfo":"","lat":"","lon":"","vid":"5","structure":"a:1:{i:0;s:6:\"12,480\";}","hours":"4 to 3 Hrs","experts":"2 Experts","price":"350","type":"0","all_image":["https://alphawizztest.tk/ondemand/uploads/6329ba5f09667.jpg"],"review_count":0},{"res_id":"117","cat_id":"15","scat_id":"19","res_name":"FASHION","res_name_u":"","res_desc":"Make-Up Artist","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://alphawizztest.tk/ondemand/uploads/6329bc0816682.jpg"},"logo":"https://alphawizztest.tk/ondemand/uploads/6329bc0816a30.jpg","res_phone":"","res_address":"","res_isOpen":"","res_status":"","res_create_date":"1624762048","res_ratings":"","status":"","res_video":"","res_url":"","mfo":"","lat":"","lon":"","vid":"12","structure":"a:1:{i:0;s:6:\"12,480\";}","hours":"4 to 3 Hrs","experts":"2 Experts","price":"250","type":"0","all_image":["https://alphawizztest.tk/ondemand/uploads/6329bc0816682.jpg"],"review_count":0},{"res_id":"119","cat_id":"13","scat_id":"0","res_name":"BIRTHDAYS","res_name_u":"","res_desc":"Our birthday photographers have first-hand experience documenting countless parties...","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://alphawizztest.tk/ondemand/uploads/6329b6a34a14c.jpg"},"logo":"https://alphawizztest.tk/ondemand/uploads/6329b6a34a73b.jpg","res_phone":"","res_address":"","res_isOpen":"","res_status":"","res_create_date":"1625653176","res_ratings":"","status":"","res_video":"","res_url":"","mfo":"","lat":"","lon":"","vid":"6","structure":"a:1:{i:0;s:6:\"12,480\";}","hours":"1 to 2 hrs","experts":"05 Experts","price":"300","type":"0","all_image":["https://alphawizztest.tk/ondemand/uploads/6329b6a34a14c.jpg"],"review_count":0},{"res_id":"126","cat_id":"14","scat_id":"0","res_name":"PERSONAL","res_name_u":"","res_desc":"Maybe you simply don’t have time to spend combing stores and would like us...","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://alphawizztest.tk/ondemand/uploads/6329ba8eb921b.jpg"},"logo":"https://alphawizztest.tk/ondemand/uploads/6329ba8eb97dc.jpg","res_phone":"","res_address":"","res_isOpen":"","res_status":"","res_create_date":"1663324149","res_ratings":"","status":"","res_video":"","res_url":"","mfo":"","lat":"","lon":"","vid":"5","structure":"a:1:{i:0;s:6:\"12,480\";}","hours":"6","experts":"5","price":"350","type":"0","all_image":["https://alphawizztest.tk/ondemand/uploads/6329ba8eb921b.jpg"],"review_count":0},{"res_id":"136","cat_id":"15","scat_id":"27","res_name":"fashion Store","res_name_u":"","res_desc":"We are providing good Service.","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://alphawizztest.tk/ondemand/uploads/632d4856732bf.png"},"logo":"https://alphawizztest.tk/ondemand/uploads/632d4856746f6.png","res_phone":"","res_address":"","res_isOpen":"","res_status":"","res_create_date":"1663912022","res_ratings":"","status":"","res_video":"","res_url":"","mfo":"","lat":"","lon":"","vid":"12","structure":"a:1:{i:0;s:7:\"10,1500\";}","hours":"1 to 2 Hours.","experts":"3","price":"300","type":"0","all_image":["https://alphawizztest.tk/ondemand/uploads/632d4856732bf.png"],"review_count":0},{"res_id":"137","cat_id":"15","scat_id":"26","res_name":"New Store","res_name_u":"","res_desc":"We are providing home as well as shop services.","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://alphawizztest.tk/ondemand/uploads/632d5dbab442f.jpg"},"logo":"https://alphawizztest.tk/ondemand/uploads/632d5dbab4b7c.jpg","res_phone":"","res_address":"","res_isOpen":"","res_status":"","res_create_date":"1663917498","res_ratings":"","status":"","res_video":"","res_url":"","mfo":"","lat":"","lon":"","vid":"12","structure":"a:2:{i:0;s:7:\"13,1600\";i:1;s:7:\"10,2000\";}","hours":"1 to 2 hours ","experts":"3","price":"600","type":"0","all_image":["https://alphawizztest.tk/ondemand/uploads/632d5dbab442f.jpg"],"review_count":0},{"res_id":"135","cat_id":"18","scat_id":"22","res_name":"new store","res_name_u":"","res_desc":"this is my new store","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://alphawizztest.tk/ondemand/uploads/632b18049773c.jpg"},"logo":"https://alphawizztest.tk/ondemand/uploads/632b180497fad.jpg","res_phone":"","res_address":"","res_isOpen":"","res_status":"","res_create_date":"1663768580","res_ratings":"","status":"","res_video":"","res_url":"","mfo":"","lat":"","lon":"","vid":"6","structure":"a:1:{i:0;s:7:\"12,1250\";}","hours":"2","experts":"2","price":"500","type":"0","all_image":["https://alphawizztest.tk/ondemand/uploads/632b18049773c.jpg"],"review_count":0},{"res_id":"138","cat_id":"13","scat_id":"0","res_name":"new store","res_name_u":"","res_desc":"new store","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://alphawizztest.tk/ondemand/uploads/632db9e2a9441.jpeg"},"logo":"https://alphawizztest.tk/ondemand/uploads/632db9e2a9b8e.jpeg","res_phone":"","res_address":"","res_isOpen":"","res_status":"","res_create_date":"1663941090","res_ratings":"","status":"","res_video":"","res_url":"","mfo":"","lat":"","lon":"","vid":"12","structure":"a:2:{i:0;s:7:\"10,5000\";i:1;s:7:\"13,3000\";}","hours":"2 to 3 hours","experts":"10 Year ","price":"500","type":"0","all_image":["https://alphawizztest.tk/ondemand/uploads/632db9e2a9441.jpeg"],"review_count":0},{"res_id":"140","cat_id":"15","scat_id":"26","res_name":"pankaj Store","res_name_u":"","res_desc":".................","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://alphawizztest.tk/ondemand/uploads/632ea0b859a67.jpg"},"logo":"https://alphawizztest.tk/ondemand/uploads/632ea0b85a451.jpg","res_phone":"","res_address":"","res_isOpen":"","res_status":"","res_create_date":"1664000184","res_ratings":"","status":"","res_video":"","res_url":"","mfo":"","lat":"","lon":"","vid":"6","structure":"","hours":"2","experts":"10 Year ","price":"10000","type":"0","all_image":["https://alphawizztest.tk/ondemand/uploads/632ea0b859a67.jpg"],"review_count":0},{"res_id":"141","cat_id":"15","scat_id":"26","res_name":"pankaj Store","res_name_u":"","res_desc":"HFH","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://alphawizztest.tk/ondemand/uploads/632ea3667314c.jpg"},"logo":"https://alphawizztest.tk/ondemand/uploads/632ea36673b44.jpg","res_phone":"","res_address":"","res_isOpen":"","res_status":"","res_create_date":"1664000870","res_ratings":"","status":"","res_video":"","res_url":"","mfo":"","lat":"","lon":"","vid":"6","structure":"","hours":"2","experts":"10 Year ","price":"100","type":"0","all_image":["https://alphawizztest.tk/ondemand/uploads/632ea3667314c.jpg"],"review_count":0},{"res_id":"142","cat_id":"28","scat_id":"31","res_name":"sk store","res_name_u":"","res_desc":"fashion","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://alphawizztest.tk/ondemand/uploads/632ea6ba66b1b.jpeg"},"logo":"https://alphawizztest.tk/ondemand/uploads/632ea6ba672c3.jpeg","res_phone":"","res_address":"","res_isOpen":"","res_status":"","res_create_date":"1664001722","res_ratings":"","status":"","res_video":"","res_url":"","mfo":"","lat":"","lon":"","vid":"13","structure":"","hours":"10 to 12 hours","experts":"4 experts","price":"2000","type":"0","all_image":["https://alphawizztest.tk/ondemand/uploads/632ea6ba66b1b.jpeg"],"review_count":0},{"res_id":"144","cat_id":"28","scat_id":"32","res_name":"sk store","res_name_u":"","res_desc":"dcascd","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://alphawizztest.tk/ondemand/uploads/632eb21b4f51a.jpeg"},"logo":"https://alphawizztest.tk/ondemand/uploads/632eb21b4fd6d.jpeg","res_phone":"","res_address":"","res_isOpen":"","res_status":"","res_create_date":"1664004635","res_ratings":"","status":"","res_video":"","res_url":"","mfo":"","lat":"","lon":"","vid":"13","structure":"","hours":"10 to 12 hours","experts":"4 experts","price":"3000","type":"0","all_image":["https://alphawizztest.tk/ondemand/uploads/632eb21b4f51a.jpeg"],"review_count":0},{"res_id":"145","cat_id":"13","scat_id":"33","res_name":"Photo Creation","res_name_u":"","res_desc":"we are provide services.","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://alphawizztest.tk/ondemand/uploads/632ecdcb2a6be.jpg"},"logo":"https://alphawizztest.tk/ondemand/uploads/632ecdcb2ae18.jpg","res_phone":"","res_address":"","res_isOpen":"","res_status":"","res_create_date":"1664011723","res_ratings":"","status":"","res_video":"","res_url":"","mfo":"","lat":"","lon":"","vid":"6","structure":"","hours":"2","experts":"2 year","price":"2000","type":"0","all_image":["https://alphawizztest.tk/ondemand/uploads/632ecdcb2a6be.jpg"],"review_count":0},{"res_id":"146","cat_id":"13","scat_id":"34","res_name":"birthday","res_name_u":"","res_desc":"birthday","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://alphawizztest.tk/ondemand/uploads/6331837e216af.png"},"logo":"https://alphawizztest.tk/ondemand/uploads/6331837e21d17.png","res_phone":"","res_address":"","res_isOpen":"","res_status":"","res_create_date":"1664189310","res_ratings":"","status":"","res_video":"","res_url":"","mfo":"","lat":"","lon":"","vid":"6","structure":"","hours":"2","experts":"10 Year ","price":"200","type":"0","all_image":["https://alphawizztest.tk/ondemand/uploads/6331837e216af.png"],"review_count":0},{"res_id":"147","cat_id":"13","scat_id":"34","res_name":"manisha photoshop","res_name_u":"","res_desc":"shooting videos and photography ","res_desc_u":"","res_website":"","res_image":{"res_imag0":"https://alphawizztest.tk/ondemand/uploads/63318a827bd21.jpg"},"logo":"https://alphawizztest.tk/ondemand/uploads/63318a827d611.JPEG","res_phone":"","res_address":"","res_isOpen":"","res_status":"","res_create_date":"1664191106","res_ratings":"","status":"","res_video":"","res_url":"","mfo":"","lat":"","lon":"","vid":"4","structure":"","hours":"2","experts":"3","price":"999","type":"0","all_image":["https://alphawizztest.tk/ondemand/uploads/63318a827bd21.jpg"],"review_count":0}]
/// status : "success"

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));
String searchModelToJson(SearchModel data) => json.encode(data.toJson());
class SearchModel {
  SearchModel({
      String? responseCode, 
      String? message, 
      List<Restaurants>? restaurants, 
      String? status,}){
    _responseCode = responseCode;
    _message = message;
    _restaurants = restaurants;
    _status = status;
}

  SearchModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    if (json['restaurants'] != null) {
      _restaurants = [];
      json['restaurants'].forEach((v) {
        _restaurants?.add(Restaurants.fromJson(v));
      });
    }
    _status = json['status'];
  }
  String? _responseCode;
  String? _message;
  List<Restaurants>? _restaurants;
  String? _status;
SearchModel copyWith({  String? responseCode,
  String? message,
  List<Restaurants>? restaurants,
  String? status,
}) => SearchModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  restaurants: restaurants ?? _restaurants,
  status: status ?? _status,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  List<Restaurants>? get restaurants => _restaurants;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    if (_restaurants != null) {
      map['restaurants'] = _restaurants?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    return map;
  }

}

/// res_id : "111"
/// cat_id : "15"
/// scat_id : "17"
/// res_name : "WEDDING"
/// res_name_u : ""
/// res_desc : " makeup artists"
/// res_desc_u : ""
/// res_website : ""
/// res_image : {"res_imag0":"https://alphawizztest.tk/ondemand/uploads/6329bb2e12a45.jpg"}
/// logo : "https://alphawizztest.tk/ondemand/uploads/6329bb2e12f21.jpg"
/// res_phone : "09632587410"
/// res_address : "TestTestTestTest1111Restaurant Description22"
/// res_isOpen : "open"
/// res_status : "active"
/// res_create_date : "1605959578"
/// res_ratings : "3.5"
/// status : ""
/// res_video : ""
/// res_url : ""
/// mfo : ""
/// lat : ""
/// lon : ""
/// vid : "12"
/// structure : "a:1:{i:0;s:6:\"12,480\";}"
/// hours : "2 to 4 Hrs"
/// experts : "03 Experts"
/// price : "200"
/// type : "0"
/// all_image : ["https://alphawizztest.tk/ondemand/uploads/6329bb2e12a45.jpg"]
/// review_count : 2

Restaurants restaurantsFromJson(String str) => Restaurants.fromJson(json.decode(str));
String restaurantsToJson(Restaurants data) => json.encode(data.toJson());
class Restaurants {
  Restaurants({
      String? resId, 
      String? catId, 
      String? scatId, 
      String? resName, 
      String? resNameU, 
      String? resDesc, 
      String? resDescU, 
      String? resWebsite, 
      ResImage? resImage, 
      String? logo, 
      String? resPhone, 
      String? resAddress, 
      String? resIsOpen, 
      String? resStatus, 
      String? resCreateDate, 
      String? resRatings, 
      String? status, 
      String? resVideo, 
      String? resUrl, 
      String? mfo, 
      String? lat, 
      String? lon, 
      String? vid, 
      String? structure, 
      String? hours, 
      String? experts, 
      String? price, 
      String? type, 
      List<String>? allImage, 
      num? reviewCount,}){
    _resId = resId;
    _catId = catId;
    _scatId = scatId;
    _resName = resName;
    _resNameU = resNameU;
    _resDesc = resDesc;
    _resDescU = resDescU;
    _resWebsite = resWebsite;
    _resImage = resImage;
    _logo = logo;
    _resPhone = resPhone;
    _resAddress = resAddress;
    _resIsOpen = resIsOpen;
    _resStatus = resStatus;
    _resCreateDate = resCreateDate;
    _resRatings = resRatings;
    _status = status;
    _resVideo = resVideo;
    _resUrl = resUrl;
    _mfo = mfo;
    _lat = lat;
    _lon = lon;
    _vid = vid;
    _structure = structure;
    _hours = hours;
    _experts = experts;
    _price = price;
    _type = type;
    _allImage = allImage;
    _reviewCount = reviewCount;
}

  Restaurants.fromJson(dynamic json) {
    _resId = json['res_id'];
    _catId = json['cat_id'];
    _scatId = json['scat_id'];
    _resName = json['res_name'];
    _resNameU = json['res_name_u'];
    _resDesc = json['res_desc'];
    _resDescU = json['res_desc_u'];
    _resWebsite = json['res_website'];
    _resImage = json['res_image'] != null ? ResImage.fromJson(json['res_image']) : null;
    _logo = json['logo'];
    _resPhone = json['res_phone'];
    _resAddress = json['res_address'];
    _resIsOpen = json['res_isOpen'];
    _resStatus = json['res_status'];
    _resCreateDate = json['res_create_date'];
    _resRatings = json['res_ratings'];
    _status = json['status'];
    _resVideo = json['res_video'];
    _resUrl = json['res_url'];
    _mfo = json['mfo'];
    _lat = json['lat'];
    _lon = json['lon'];
    _vid = json['vid'];
    _structure = json['structure'];
    _hours = json['hours'];
    _experts = json['experts'];
    _price = json['price'];
    _type = json['type'];
    _allImage = json['all_image'] != null ? json['all_image'].cast<String>() : [];
    _reviewCount = json['review_count'];
  }
  String? _resId;
  String? _catId;
  String? _scatId;
  String? _resName;
  String? _resNameU;
  String? _resDesc;
  String? _resDescU;
  String? _resWebsite;
  ResImage? _resImage;
  String? _logo;
  String? _resPhone;
  String? _resAddress;
  String? _resIsOpen;
  String? _resStatus;
  String? _resCreateDate;
  String? _resRatings;
  String? _status;
  String? _resVideo;
  String? _resUrl;
  String? _mfo;
  String? _lat;
  String? _lon;
  String? _vid;
  String? _structure;
  String? _hours;
  String? _experts;
  String? _price;
  String? _type;
  List<String>? _allImage;
  num? _reviewCount;
Restaurants copyWith({  String? resId,
  String? catId,
  String? scatId,
  String? resName,
  String? resNameU,
  String? resDesc,
  String? resDescU,
  String? resWebsite,
  ResImage? resImage,
  String? logo,
  String? resPhone,
  String? resAddress,
  String? resIsOpen,
  String? resStatus,
  String? resCreateDate,
  String? resRatings,
  String? status,
  String? resVideo,
  String? resUrl,
  String? mfo,
  String? lat,
  String? lon,
  String? vid,
  String? structure,
  String? hours,
  String? experts,
  String? price,
  String? type,
  List<String>? allImage,
  num? reviewCount,
}) => Restaurants(  resId: resId ?? _resId,
  catId: catId ?? _catId,
  scatId: scatId ?? _scatId,
  resName: resName ?? _resName,
  resNameU: resNameU ?? _resNameU,
  resDesc: resDesc ?? _resDesc,
  resDescU: resDescU ?? _resDescU,
  resWebsite: resWebsite ?? _resWebsite,
  resImage: resImage ?? _resImage,
  logo: logo ?? _logo,
  resPhone: resPhone ?? _resPhone,
  resAddress: resAddress ?? _resAddress,
  resIsOpen: resIsOpen ?? _resIsOpen,
  resStatus: resStatus ?? _resStatus,
  resCreateDate: resCreateDate ?? _resCreateDate,
  resRatings: resRatings ?? _resRatings,
  status: status ?? _status,
  resVideo: resVideo ?? _resVideo,
  resUrl: resUrl ?? _resUrl,
  mfo: mfo ?? _mfo,
  lat: lat ?? _lat,
  lon: lon ?? _lon,
  vid: vid ?? _vid,
  structure: structure ?? _structure,
  hours: hours ?? _hours,
  experts: experts ?? _experts,
  price: price ?? _price,
  type: type ?? _type,
  allImage: allImage ?? _allImage,
  reviewCount: reviewCount ?? _reviewCount,
);
  String? get resId => _resId;
  String? get catId => _catId;
  String? get scatId => _scatId;
  String? get resName => _resName;
  String? get resNameU => _resNameU;
  String? get resDesc => _resDesc;
  String? get resDescU => _resDescU;
  String? get resWebsite => _resWebsite;
  ResImage? get resImage => _resImage;
  String? get logo => _logo;
  String? get resPhone => _resPhone;
  String? get resAddress => _resAddress;
  String? get resIsOpen => _resIsOpen;
  String? get resStatus => _resStatus;
  String? get resCreateDate => _resCreateDate;
  String? get resRatings => _resRatings;
  String? get status => _status;
  String? get resVideo => _resVideo;
  String? get resUrl => _resUrl;
  String? get mfo => _mfo;
  String? get lat => _lat;
  String? get lon => _lon;
  String? get vid => _vid;
  String? get structure => _structure;
  String? get hours => _hours;
  String? get experts => _experts;
  String? get price => _price;
  String? get type => _type;
  List<String>? get allImage => _allImage;
  num? get reviewCount => _reviewCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['res_id'] = _resId;
    map['cat_id'] = _catId;
    map['scat_id'] = _scatId;
    map['res_name'] = _resName;
    map['res_name_u'] = _resNameU;
    map['res_desc'] = _resDesc;
    map['res_desc_u'] = _resDescU;
    map['res_website'] = _resWebsite;
    if (_resImage != null) {
      map['res_image'] = _resImage?.toJson();
    }
    map['logo'] = _logo;
    map['res_phone'] = _resPhone;
    map['res_address'] = _resAddress;
    map['res_isOpen'] = _resIsOpen;
    map['res_status'] = _resStatus;
    map['res_create_date'] = _resCreateDate;
    map['res_ratings'] = _resRatings;
    map['status'] = _status;
    map['res_video'] = _resVideo;
    map['res_url'] = _resUrl;
    map['mfo'] = _mfo;
    map['lat'] = _lat;
    map['lon'] = _lon;
    map['vid'] = _vid;
    map['structure'] = _structure;
    map['hours'] = _hours;
    map['experts'] = _experts;
    map['price'] = _price;
    map['type'] = _type;
    map['all_image'] = _allImage;
    map['review_count'] = _reviewCount;
    return map;
  }

}

/// res_imag0 : "https://alphawizztest.tk/ondemand/uploads/6329bb2e12a45.jpg"

ResImage resImageFromJson(String str) => ResImage.fromJson(json.decode(str));
String resImageToJson(ResImage data) => json.encode(data.toJson());
class ResImage {
  ResImage({
      String? resImag0,}){
    _resImag0 = resImag0;
}

  ResImage.fromJson(dynamic json) {
    _resImag0 = json['res_imag0'];
  }
  String? _resImag0;
ResImage copyWith({  String? resImag0,
}) => ResImage(  resImag0: resImag0 ?? _resImag0,
);
  String? get resImag0 => _resImag0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['res_imag0'] = _resImag0;
    return map;
  }

}