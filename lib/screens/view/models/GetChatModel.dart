import 'dart:convert';
/// response_code : "0"
/// msg : "Message chat success"
/// data : [{"id":"1","message":"Hello Vendor, please make it soon","message_type":"text","sender_id":"31","sender_type":"user","booking_id":"215","created_at":"2022-11-04 22:30:33","updated_at":"2022-11-04 22:30:33","user":"Shivam 12 Kanathe"},{"id":"2","message":"Hello world","message_type":"text","sender_id":"31","sender_type":"user","booking_id":"215","created_at":"2022-11-04 22:31:10","updated_at":"2022-11-04 22:31:10","user":"Shivam 12 Kanathe"},{"id":"3","message":"Hello world","message_type":"text","sender_id":"31","sender_type":"user","booking_id":"215","created_at":"2022-11-04 22:32:46","updated_at":"2022-11-04 22:32:46","user":"Shivam 12 Kanathe"},{"id":"4","message":"Hello world","message_type":"text","sender_id":"31","sender_type":"user","booking_id":"215","created_at":"2022-11-04 22:34:00","updated_at":"2022-11-04 22:34:00","user":"Shivam 12 Kanathe"},{"id":"5","message":"Hello Customer","message_type":"text","sender_id":"34","sender_type":"vendor","booking_id":"215","created_at":"2022-11-04 22:34:50","updated_at":"2022-11-04 22:34:50","user":"Sawan Shakya"},{"id":"6","message":"Hello Customer","message_type":"text","sender_id":"34","sender_type":"vendor","booking_id":"215","created_at":"2022-11-04 22:35:16","updated_at":"2022-11-04 22:35:16","user":"Sawan Shakya"},{"id":"7","message":"Hello Customer","message_type":"text","sender_id":"34","sender_type":"vendor","booking_id":"215","created_at":"2022-11-04 22:35:46","updated_at":"2022-11-04 22:35:46","user":"Sawan Shakya"},{"id":"8","message":"Hello Customer","message_type":"text","sender_id":"34","sender_type":"vendor","booking_id":"215","created_at":"2022-11-04 22:36:02","updated_at":"2022-11-04 22:36:02","user":"Sawan Shakya"},{"id":"9","message":"Hello i am fine","message_type":"text","sender_id":"34","sender_type":"user","booking_id":"215","created_at":"2022-11-04 23:12:40","updated_at":"2022-11-04 23:12:40","user":"Yogesh Shukla"}]

GetChatModel getChatModelFromJson(String str) => GetChatModel.fromJson(json.decode(str));
String getChatModelToJson(GetChatModel data) => json.encode(data.toJson());
class GetChatModel {
  GetChatModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  GetChatModel.fromJson(dynamic json) {
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
GetChatModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => GetChatModel(  responseCode: responseCode ?? _responseCode,
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
/// message : "Hello Vendor, please make it soon"
/// message_type : "text"
/// sender_id : "31"
/// sender_type : "user"
/// booking_id : "215"
/// created_at : "2022-11-04 22:30:33"
/// updated_at : "2022-11-04 22:30:33"
/// user : "Shivam 12 Kanathe"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? message, 
      String? messageType, 
      String? senderId, 
      String? senderType, 
      String? bookingId, 
      String? createdAt, 
      String? updatedAt, 
      String? user,}){
    _id = id;
    _message = message;
    _messageType = messageType;
    _senderId = senderId;
    _senderType = senderType;
    _bookingId = bookingId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _message = json['message'];
    _messageType = json['message_type'];
    _senderId = json['sender_id'];
    _senderType = json['sender_type'];
    _bookingId = json['booking_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _user = json['user'];
  }
  String? _id;
  String? _message;
  String? _messageType;
  String? _senderId;
  String? _senderType;
  String? _bookingId;
  String? _createdAt;
  String? _updatedAt;
  String? _user;
Data copyWith({  String? id,
  String? message,
  String? messageType,
  String? senderId,
  String? senderType,
  String? bookingId,
  String? createdAt,
  String? updatedAt,
  String? user,
}) => Data(  id: id ?? _id,
  message: message ?? _message,
  messageType: messageType ?? _messageType,
  senderId: senderId ?? _senderId,
  senderType: senderType ?? _senderType,
  bookingId: bookingId ?? _bookingId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  user: user ?? _user,
);
  String? get id => _id;
  String? get message => _message;
  String? get messageType => _messageType;
  String? get senderId => _senderId;
  String? get senderType => _senderType;
  String? get bookingId => _bookingId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['message'] = _message;
    map['message_type'] = _messageType;
    map['sender_id'] = _senderId;
    map['sender_type'] = _senderType;
    map['booking_id'] = _bookingId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['user'] = _user;
    return map;
  }

}