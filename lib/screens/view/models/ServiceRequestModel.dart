class ServiceRequestModel {
  ServiceRequestModel({
      this.responseCode, 
      this.msg, 
      this.data,});

  ServiceRequestModel.fromJson(dynamic json) {
    responseCode = json['response_code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(v.fromJson(v));
      });
    }
  }
  String? responseCode;
  String? msg;
  List<dynamic>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = responseCode;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}