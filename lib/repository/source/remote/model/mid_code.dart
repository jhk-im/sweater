class MidCode {
  String? city;
  String? code;

  MidCode({
    this.city,
    this.code,
  });

  MidCode.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['code'] = code;
    return data;
  }

  @override
  String toString() {
    return 'MidCode: { city: $city, code: $code }';
  }
}
