class MidTermTemperature {
  String? regId;
  int? taMin3;
  int? taMax3;
  int? taMin4;
  int? taMax4;
  int? taMin5;
  int? taMax5;
  int? taMin6;
  int? taMax6;
  int? taMin7;
  int? taMax7;
  int? taMin8;
  int? taMax8;
  int? taMin9;
  int? taMax9;
  int? taMin10;
  int? taMax10;
  String? date;

  MidTermTemperature(
      {this.regId,
        this.taMin3,
        this.taMax3,
        this.taMin4,
        this.taMax4,
        this.taMin5,
        this.taMax5,
        this.taMin6,
        this.taMax6,
        this.taMin7,
        this.taMax7,
        this.taMin8,
        this.taMax8,
        this.taMin9,
        this.taMax9,
        this.taMin10,
        this.taMax10,});

  MidTermTemperature.fromJson(Map<String, dynamic> json) {
    regId = json['regId'];
    taMin3 = json['taMin3'];
    taMax3 = json['taMax3'];
    taMin4 = json['taMin4'];
    taMax4 = json['taMax4'];
    taMin5 = json['taMin5'];
    taMax5 = json['taMax5'];
    taMin6 = json['taMin6'];
    taMax6 = json['taMax6'];
    taMin7 = json['taMin7'];
    taMax7 = json['taMax7'];
    taMin8 = json['taMin8'];
    taMax8 = json['taMax8'];
    taMin9 = json['taMin9'];
    taMax9 = json['taMax9'];
    taMin10 = json['taMin10'];
    taMax10 = json['taMax10'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['regId'] = regId;
    data['taMin3'] = taMin3;
    data['taMax3'] = taMax3;
    data['taMin4'] = taMin4;
    data['taMax4'] = taMax4;
    data['taMin5'] = taMin5;
    data['taMax5'] = taMax5;
    data['taMin6'] = taMin6;
    data['taMax6'] = taMax6;
    data['taMin7'] = taMin7;
    data['taMax7'] = taMax7;
    data['taMin8'] = taMin8;
    data['taMax8'] = taMax8;
    data['taMin9'] = taMin9;
    data['taMax9'] = taMax9;
    data['taMin10'] = taMin10;
    data['taMax10'] = taMax10;
    return data;
  }

  @override
  String toString() {
    return 'MidTermTemperature: { regId: $regId,  taMin3: $taMin3, taMax3: $taMax3, date: $date }';
  }
}

class MidTermTemperatureList {
  String? dataType;
  Items? items;
  int? pageNo;
  int? numOfRows;
  int? totalCount;

  MidTermTemperatureList(
      {this.dataType,
        this.items,
        this.pageNo,
        this.numOfRows,
        this.totalCount});

  MidTermTemperatureList.fromJson(Map<String, dynamic> json) {
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

class Items {
  List<MidTermTemperature>? item;

  Items({this.item});

  Items.fromJson(Map<String, dynamic> json) {
    if (json['item'] != null) {
      item = <MidTermTemperature>[];
      json['item'].forEach((v) {
        item!.add(MidTermTemperature.fromJson(v));
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
