class Address {
  String? regionType;
  String? addressName;
  String? region1depthName;
  String? region2depthName;
  String? region3depthName;
  String? region4depthName;
  String? code;
  double? x;
  double? y;

  Address(
      {this.regionType,
        this.addressName,
        this.region1depthName,
        this.region2depthName,
        this.region3depthName,
        this.region4depthName,
        this.code,
        this.x,
        this.y});

  Address.fromJson(Map<String, dynamic> json) {
    regionType = json['region_type'];
    addressName = json['address_name'];
    region1depthName = json['region_1depth_name'];
    region2depthName = json['region_2depth_name'];
    region3depthName = json['region_3depth_name'];
    region4depthName = json['region_4depth_name'];
    code = json['code'];
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['region_type'] = regionType;
    data['address_name'] = addressName;
    data['region_1depth_name'] = region1depthName;
    data['region_2depth_name'] = region2depthName;
    data['region_3depth_name'] = region3depthName;
    data['region_4depth_name'] = region4depthName;
    data['code'] = code;
    data['x'] = x;
    data['y'] = y;
    return data;
  }

  @override
  String toString() {
    return 'Address: { region1depthName: $region1depthName, region2depthName: $region2depthName, region3depthName: $region3depthName, x: $x, y: $y }';
  }
}

class AddressList {
  Meta? meta;
  List<Address>? documents;

  AddressList({this.meta, this.documents});

  AddressList.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['documents'] != null) {
      documents = <Address>[];
      json['documents'].forEach((v) {
        documents!.add(Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  int? totalCount;

  Meta({this.totalCount});

  Meta.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_count'] = totalCount;
    return data;
  }
}
