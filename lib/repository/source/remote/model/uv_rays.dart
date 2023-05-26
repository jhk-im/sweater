class Items {
  List<UVRays>? item;

  Items({this.item});

  Items.fromJson(Map<String, dynamic> json) {
    if (json['item'] != null) {
      item = <UVRays>[];
      json['item'].forEach((v) {
        item!.add(UVRays.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (item != null) {
      data['item'] = item!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UVRays {
  String? code;
  String? areaNo;
  String? date;
  String? h0;
  String? h3;
  String? h6;
  String? h9;
  String? h12;
  String? h15;
  String? h18;
  String? h21;
  String? h24;
  // String? h27;
  // String? h30;
  // String? h33;
  // String? h36;
  // String? h39;
  // String? h42;
  // String? h45;
  // String? h48;
  // String? h51;
  // String? h54;
  // String? h57;
  // String? h60;
  // String? h63;
  // String? h66;
  // String? h69;
  // String? h72;
  // String? h75;

  UVRays({
    this.code,
    this.areaNo,
    this.date,
    this.h0,
    this.h3,
    this.h6,
    this.h9,
    this.h12,
    this.h15,
    this.h18,
    this.h21,
    this.h24,
    // this.h27,
    // this.h30,
    // this.h33,
    // this.h36,
    // this.h39,
    // this.h42,
    // this.h45,
    // this.h48,
    // this.h51,
    // this.h54,
    // this.h57,
    // this.h60,
    // this.h63,
    // this.h66,
    // this.h69,
    // this.h72,
    // this.h75
  });

  UVRays.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    areaNo = json['areaNo'];
    date = json['date'];
    h0 = json['h0'];
    h3 = json['h3'];
    h6 = json['h6'];
    h9 = json['h9'];
    h12 = json['h12'];
    h15 = json['h15'];
    h18 = json['h18'];
    h21 = json['h21'];
    h24 = json['h24'];
    // h27 = json['h27'];
    // h30 = json['h30'];
    // h33 = json['h33'];
    // h36 = json['h36'];
    // h39 = json['h39'];
    // h42 = json['h42'];
    // h45 = json['h45'];
    // h48 = json['h48'];
    // h51 = json['h51'];
    // h54 = json['h54'];
    // h57 = json['h57'];
    // h60 = json['h60'];
    // h63 = json['h63'];
    // h66 = json['h66'];
    // h69 = json['h69'];
    // h72 = json['h72'];
    // h75 = json['h75'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['areaNo'] = areaNo;
    data['date'] = date;
    data['h0'] = h0;
    data['h3'] = h3;
    data['h6'] = h6;
    data['h9'] = h9;
    data['h12'] = h12;
    data['h15'] = h15;
    data['h18'] = h18;
    data['h21'] = h21;
    data['h24'] = h24;
    // data['h27'] = h27;
    // data['h30'] = h30;
    // data['h33'] = h33;
    // data['h36'] = h36;
    // data['h39'] = h39;
    // data['h42'] = h42;
    // data['h45'] = h45;
    // data['h48'] = h48;
    // data['h51'] = h51;
    // data['h54'] = h54;
    // data['h57'] = h57;
    // data['h60'] = h60;
    // data['h63'] = h63;
    // data['h66'] = h66;
    // data['h69'] = h69;
    // data['h72'] = h72;
    // data['h75'] = h75;
    return data;
  }

  @override
  String toString() {
    return 'UVRays: { code: $code,  areaNo: $areaNo, date: $date, h0: $h0 }';
  }
}

class UVRaysList {
  String? dataType;
  Items? items;
  int? pageNo;
  int? numOfRows;
  int? totalCount;

  UVRaysList(
      {this.dataType,
        this.items,
        this.pageNo,
        this.numOfRows,
        this.totalCount});

  UVRaysList.fromJson(Map<String, dynamic> json) {
    dataType = json['dataType'];
    items = json['items'] != null ? Items.fromJson(json['items']) : null;
    pageNo = json['pageNo'];
    numOfRows = json['numOfRows'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dataType'] = dataType;
    if (items != null) {
      data['items'] = items!.toJson();
    }
    data['pageNo'] = pageNo;
    data['numOfRows'] = numOfRows;
    data['totalCount'] = totalCount;
    return data;
  }
}
