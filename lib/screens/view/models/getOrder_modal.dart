class GetOrdersModal {
  String? responseCode;
  String? message;
  List<Orders>? orders;
  String? status;

  GetOrdersModal({this.responseCode, this.message, this.orders, this.status});

  GetOrdersModal.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    if (json['orders'] != null) {
      // orders = new List<Orders>();
       orders = List<Orders>.empty(growable: true);
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Orders {
  String? orderId;
  String? total;
  String? date;
  String? paymentMode;
  String? address;
  String? txnId;
  String? pStatus;
  String? pDate;
  List<Products>? products;
  int? count;

  Orders(
      {this.orderId,
      this.total,
      this.date,
      this.paymentMode,
      this.address,
      this.txnId,
      this.pStatus,
      this.pDate,
      this.products,
      this.count});

  Orders.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    total = json['total'];
    date = json['date'];
    paymentMode = json['payment_mode'];
    address = json['address'];
    txnId = json['txn_id'];
    pStatus = json['p_status'];
    pDate = json['p_date'];
    if (json['products'] != null) {
      // products = new List<Products>();
       products = List<Products>.empty(growable: true);
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['total'] = this.total;
    data['date'] = this.date;
    data['payment_mode'] = this.paymentMode;
    data['address'] = this.address;
    data['txn_id'] = this.txnId;
    data['p_status'] = this.pStatus;
    data['p_date'] = this.pDate;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class Products {
  String? productId;
  String? productName;
  String? productDescription;
  String? productPrice;
  String? productImage;
  String? proRatings;
  String? productCreateDate;
  String? quantity;

  Products(
      {this.productId,
      this.productName,
      this.productDescription,
      this.productPrice,
      this.productImage,
      this.proRatings,
      this.productCreateDate,
      this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    productPrice = json['product_price'];
    productImage = json['product_image'];
    proRatings = json['pro_ratings'];
    productCreateDate = json['product_create_date'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_description'] = this.productDescription;
    data['product_price'] = this.productPrice;
    data['product_image'] = this.productImage;
    data['pro_ratings'] = this.proRatings;
    data['product_create_date'] = this.productCreateDate;
    data['quantity'] = this.quantity;
    return data;
  }
}