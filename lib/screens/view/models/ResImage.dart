class ResImage {
  ResImage({
    this.resImag0,});

  ResImage.fromJson(dynamic json) {
    resImag0 = json['res_imag0'];
  }
  String? resImag0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['res_imag0'] = resImag0;
    return map;
  }

}