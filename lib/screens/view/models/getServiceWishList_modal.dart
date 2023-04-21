class GetServiceWishListModal {
  String? responseCode;
  String? message;
  List<Wishlist>? wishlist;
  String? status;

  GetServiceWishListModal(
      {this.responseCode, this.message, this.wishlist, this.status});

  GetServiceWishListModal.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    if (json['wishlist'] != null) {
      //wishlist = new List<Wishlist>();
       wishlist = List<Wishlist>.empty(growable: true);
      json['wishlist'].forEach((v) {
        wishlist!.add(new Wishlist.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.wishlist != null) {
      data['wishlist'] = this.wishlist!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Wishlist {
  String? resId;
  String? resName;
  String? resDesc;
  String? resImage;

  Wishlist({this.resId, this.resName, this.resDesc, this.resImage});

  Wishlist.fromJson(Map<String, dynamic> json) {
    resId = json['res_id'];
    resName = json['res_name'];
    resDesc = json['res_desc'];
    resImage = json['res_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['res_id'] = this.resId;
    data['res_name'] = this.resName;
    data['res_desc'] = this.resDesc;
    data['res_image'] = this.resImage;
    return data;
  }
}