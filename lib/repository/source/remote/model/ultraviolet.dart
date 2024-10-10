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
    final Map<String, dynamic> data = <String, dynamic>{};
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
