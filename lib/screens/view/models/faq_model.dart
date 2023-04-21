/// status : "1"
/// msg : "Service providers"
/// setting : [{"id":"11","title":"How many days in advance should I book my services?","description":"We suggest bookings are done at least one week in advance to ensure your preferred time, date, and ants(professional)"},{"id":"12","title":" Does social distancing affect the experience and quality of services ?","description":"Not at all! Our services are about the human-to-human connection between client and ants (professionals). Our professionals are equipped with the best gear in the industry to assure quality services regardless of social distancing."},{"id":"13","title":"What are your social distancing practices due to coronavirus (COVID-19)?","description":"We encourage our professionals to use their masks at all times, avoid physical contact, and follow the CDC’s health recommendations."},{"id":"15","title":"How many people can be part of my service experience?","description":"Check with your professional once booking the services."},{"id":"16","title":"Can I choose my ants (professionals) and view their portfolio ?","description":"Absolutely! Once you've selected your destination, you can view all the service providers designated to that area, browse their portfolio and select your favorite. Not sure who to choose? We can pair you with the best ants (professionals) for your needs o"},{"id":"17","title":"What happens if professionals are not allowed in the venue/location I want?","description":"If you hope to have your services at a specific location (i.e. hotel, resort, museum, historical site) it is your responsibility to insure the location permits external vendors and pay any associated fees. Please research this before booking. Refunds will"},{"id":"18","title":"Where do I meet my ant (professional)?","description":"You can choose the location where you want to meet your ant (professional). If you are not familiar with the area, ask your ant (professional) to suggest the best place to meet!"},{"id":"19","title":"Will scrapy5 ask for permission to share my completed service on your website and/or social media?","description":"We respect your privacy and will never share your pictures/work on our blog or social media without your permission! If you prefer to keep your photos/work private, that’s totally fine – opt out in the checkout form. As a bonus, if you review your experie"},{"id":"20","title":"Will I be able to contact or chat with my ant (professional)?","description":"Yes, once you have booked the service provider, you can log in to your account and chat with your professionals."},{"id":"21","title":"What’s the status of my order after paying?","description":"After your payment is processed, you can chat immediately and in the platform with your ant (professional) to coordinate details including meeting time, place and inspiration."},{"id":"22","title":"Can I reschedule my service?","description":"We highly don’t recommend this as our professionals plan their work and bookings in advance. However, it can acceptable under certain circumstances * Check with your professional."},{"id":"23","title":"Can I cancel my scheduled service?","description":"If you need to cancel your session, please notify us via email at info@scrapy5.co with at least 3 days notice. Our cancelation policy is as follows: a) If you cancel more than 3 days in advance of your session, we will issue you with a credit of the same"},{"id":"24","title":"What happens if I don’t make it to my scheduled service?","description":"No refund will be issued for no-shows (except for emergencies or unforeseen circumstances)."},{"id":"25","title":" I’m running late! How will this affect my session?","description":"If you’re running late (hey, it happens!), message your ant (professional) as soon as possible. Sometimes your ant (professional) may be able to wait for you, but in cases where they have another service scheduled, they may not be able to stay longer. • S"},{"id":"26","title":"You don’t offer professionals in my desired destination. What are my options?","description":"Send us your request to our live chat or email us directly to info@scrapy5.co . Our team will get back to you within 24-hours with a solution."},{"id":"27","title":" Once I pay the services, are there any additional fees/charges I need to know about ?","description":"1.Not from our end. Transportation fees may apply depending on the exact location you decided for your service.\r\n\r\n2. Please, have in mind that you are responsible for any admission fees or transportation fees during the sessions (entry to the museum, Ube"}]
/// privacy_policy : {"id":"1","data":"Privacy Policy","discription":"Scrapy5.com is provided to you to discover, explore and book professionals through our featured content and interactive functionality available via the Internet (the “Scrapy5 Services”). The Terms of Use include our policy for acceptable use of the Scrapy5"}
/// term_condition : {"id":"1","data":"<h2>Terms Condition</h2>","discription":"<h5>Terms of Use</h5>             <p>The website, <strong>www.scrapy5.co </strong>(the <strong>“Website”</strong>) developed, owned and operated by <strong>scrapy5 Private Limited</strong> (hereinafter called “<strong> Company</strong"}

class FaqModel {
  FaqModel({
      String? status, 
      String? msg, 
      List<Setting>? setting, 
      PrivacyPolicy? privacyPolicy, 
      TermCondition? termCondition,}){
    _status = status;
    _msg = msg;
    _setting = setting;
    _privacyPolicy = privacyPolicy;
    _termCondition = termCondition;
}

  FaqModel.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['setting'] != null) {
      _setting = [];
      json['setting'].forEach((v) {
        _setting?.add(Setting.fromJson(v));
      });
    }
    _privacyPolicy = json['privacy_policy'] != null ? PrivacyPolicy.fromJson(json['privacy_policy']) : null;
    _termCondition = json['term_condition'] != null ? TermCondition.fromJson(json['term_condition']) : null;
  }
  String? _status;
  String? _msg;
  List<Setting>? _setting;
  PrivacyPolicy? _privacyPolicy;
  TermCondition? _termCondition;
FaqModel copyWith({  String? status,
  String? msg,
  List<Setting>? setting,
  PrivacyPolicy? privacyPolicy,
  TermCondition? termCondition,
}) => FaqModel(  status: status ?? _status,
  msg: msg ?? _msg,
  setting: setting ?? _setting,
  privacyPolicy: privacyPolicy ?? _privacyPolicy,
  termCondition: termCondition ?? _termCondition,
);
  String? get status => _status;
  String? get msg => _msg;
  List<Setting>? get setting => _setting;
  PrivacyPolicy? get privacyPolicy => _privacyPolicy;
  TermCondition? get termCondition => _termCondition;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_setting != null) {
      map['setting'] = _setting?.map((v) => v.toJson()).toList();
    }
    if (_privacyPolicy != null) {
      map['privacy_policy'] = _privacyPolicy?.toJson();
    }
    if (_termCondition != null) {
      map['term_condition'] = _termCondition?.toJson();
    }
    return map;
  }

}

/// id : "1"
/// data : "<h2>Terms Condition</h2>"
/// discription : "<h5>Terms of Use</h5>             <p>The website, <strong>www.scrapy5.co </strong>(the <strong>“Website”</strong>) developed, owned and operated by <strong>scrapy5 Private Limited</strong> (hereinafter called “<strong> Company</strong"

class TermCondition {
  TermCondition({
      String? id, 
      String? data, 
      String? discription,}){
    _id = id;
    _data = data;
    _discription = discription;
}

  TermCondition.fromJson(dynamic json) {
    _id = json['id'];
    _data = json['data'];
    _discription = json['discription'];
  }
  String? _id;
  String? _data;
  String? _discription;
TermCondition copyWith({  String? id,
  String? data,
  String? discription,
}) => TermCondition(  id: id ?? _id,
  data: data ?? _data,
  discription: discription ?? _discription,
);
  String? get id => _id;
  String? get data => _data;
  String? get discription => _discription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['data'] = _data;
    map['discription'] = _discription;
    return map;
  }

}

/// id : "1"
/// data : "Privacy Policy"
/// discription : "Scrapy5.com is provided to you to discover, explore and book professionals through our featured content and interactive functionality available via the Internet (the “Scrapy5 Services”). The Terms of Use include our policy for acceptable use of the Scrapy5"

class PrivacyPolicy {
  PrivacyPolicy({
      String? id, 
      String? data, 
      String? discription,}){
    _id = id;
    _data = data;
    _discription = discription;
}

  PrivacyPolicy.fromJson(dynamic json) {
    _id = json['id'];
    _data = json['data'];
    _discription = json['discription'];
  }
  String? _id;
  String? _data;
  String? _discription;
PrivacyPolicy copyWith({  String? id,
  String? data,
  String? discription,
}) => PrivacyPolicy(  id: id ?? _id,
  data: data ?? _data,
  discription: discription ?? _discription,
);
  String? get id => _id;
  String? get data => _data;
  String? get discription => _discription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['data'] = _data;
    map['discription'] = _discription;
    return map;
  }

}

/// id : "11"
/// title : "How many days in advance should I book my services?"
/// description : "We suggest bookings are done at least one week in advance to ensure your preferred time, date, and ants(professional)"

class Setting {
  Setting({
      String? id, 
      String? title, 
      String? description,}){
    _id = id;
    _title = title;
    _description = description;
}

  Setting.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
  }
  String? _id;
  String? _title;
  String? _description;
Setting copyWith({  String? id,
  String? title,
  String? description,
}) => Setting(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    return map;
  }

}