class GeeUserModel {
  String? responseCode;
  String? message;
  User? user;
  String? status;

  GeeUserModel({this.responseCode, this.message, this.user, this.status});

  GeeUserModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class User {
  String? username;
  String? email;
  String? mobile;
  String? wallet;
  String? address;
  String? city;
  String? country;
  String? isGold;
  String? profilePic;
  String? profileCreated;

  User(
      {this.username,
      this.email,
      this.mobile,
      this.address,
      this.city,
      this.country,
      this.wallet,
      this.isGold,
      this.profilePic,
      this.profileCreated});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    city = json['city'];
    wallet = json['wallet'];
    country = json['country'];
    isGold = json['isGold'];
    profilePic = json['profile_pic'];
    profileCreated = json['profile_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['wallet'] = this.wallet;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    data['isGold'] = this.isGold;
    data['profile_pic'] = this.profilePic;
    data['profile_created'] = this.profileCreated;
    return data;
  }
}