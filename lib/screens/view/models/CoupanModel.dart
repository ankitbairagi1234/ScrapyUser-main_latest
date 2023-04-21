import 'dart:convert';
/// response_code : "1"
/// msg : "Promo code applied"
/// data : {"discount_amount":"100","total_amount":"500","amount_after_discount":"400.00"}

CoupanModel coupanModelFromJson(String str) => CoupanModel.fromJson(json.decode(str));
String coupanModelToJson(CoupanModel data) => json.encode(data.toJson());
class CoupanModel {
  CoupanModel({
      String? responseCode, 
      String? msg, 
      Data? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  CoupanModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _responseCode;
  String? _msg;
  Data? _data;
CoupanModel copyWith({  String? responseCode,
  String? msg,
  Data? data,
}) => CoupanModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// discount_amount : "100"
/// total_amount : "500"
/// amount_after_discount : "400.00"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? discountAmount, 
      String? totalAmount, 
      String? amountAfterDiscount,}){
    _discountAmount = discountAmount;
    _totalAmount = totalAmount;
    _amountAfterDiscount = amountAfterDiscount;
}

  Data.fromJson(dynamic json) {
    _discountAmount = json['discount_amount'];
    _totalAmount = json['total_amount'];
    _amountAfterDiscount = json['amount_after_discount'];
  }
  String? _discountAmount;
  String? _totalAmount;
  String? _amountAfterDiscount;
Data copyWith({  String? discountAmount,
  String? totalAmount,
  String? amountAfterDiscount,
}) => Data(  discountAmount: discountAmount ?? _discountAmount,
  totalAmount: totalAmount ?? _totalAmount,
  amountAfterDiscount: amountAfterDiscount ?? _amountAfterDiscount,
);
  String? get discountAmount => _discountAmount;
  String? get totalAmount => _totalAmount;
  String? get amountAfterDiscount => _amountAfterDiscount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['discount_amount'] = _discountAmount;
    map['total_amount'] = _totalAmount;
    map['amount_after_discount'] = _amountAfterDiscount;
    return map;
  }

}