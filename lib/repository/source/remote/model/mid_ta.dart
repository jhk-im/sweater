class MidTa {
  String? regId;
  int? taMin3;
  int? taMin3Low;
  int? taMin3High;
  int? taMax3;
  int? taMax3Low;
  int? taMax3High;
  int? taMin4;
  int? taMin4Low;
  int? taMin4High;
  int? taMax4;
  int? taMax4Low;
  int? taMax4High;
  int? taMin5;
  int? taMin5Low;
  int? taMin5High;
  int? taMax5;
  int? taMax5Low;
  int? taMax5High;
  int? taMin6;
  int? taMin6Low;
  int? taMin6High;
  int? taMax6;
  int? taMax6Low;
  int? taMax6High;
  int? taMin7;
  int? taMin7Low;
  int? taMin7High;
  int? taMax7;
  int? taMax7Low;
  int? taMax7High;
  int? taMin8;
  int? taMin8Low;
  int? taMin8High;
  int? taMax8;
  int? taMax8Low;
  int? taMax8High;
  int? taMin9;
  int? taMin9Low;
  int? taMin9High;
  int? taMax9;
  int? taMax9Low;
  int? taMax9High;
  int? taMin10;
  int? taMin10Low;
  int? taMin10High;
  int? taMax10;
  int? taMax10Low;
  int? taMax10High;
  String? date;

  MidTa(
      {this.regId,
        this.taMin3,
        this.taMin3Low,
        this.taMin3High,
        this.taMax3,
        this.taMax3Low,
        this.taMax3High,
        this.taMin4,
        this.taMin4Low,
        this.taMin4High,
        this.taMax4,
        this.taMax4Low,
        this.taMax4High,
        this.taMin5,
        this.taMin5Low,
        this.taMin5High,
        this.taMax5,
        this.taMax5Low,
        this.taMax5High,
        this.taMin6,
        this.taMin6Low,
        this.taMin6High,
        this.taMax6,
        this.taMax6Low,
        this.taMax6High,
        this.taMin7,
        this.taMin7Low,
        this.taMin7High,
        this.taMax7,
        this.taMax7Low,
        this.taMax7High,
        this.taMin8,
        this.taMin8Low,
        this.taMin8High,
        this.taMax8,
        this.taMax8Low,
        this.taMax8High,
        this.taMin9,
        this.taMin9Low,
        this.taMin9High,
        this.taMax9,
        this.taMax9Low,
        this.taMax9High,
        this.taMin10,
        this.taMin10Low,
        this.taMin10High,
        this.taMax10,
        this.taMax10Low,
        this.taMax10High});

  MidTa.fromJson(Map<String, dynamic> json) {
    regId = json['regId'];
    taMin3 = json['taMin3'];
    taMin3Low = json['taMin3Low'];
    taMin3High = json['taMin3High'];
    taMax3 = json['taMax3'];
    taMax3Low = json['taMax3Low'];
    taMax3High = json['taMax3High'];
    taMin4 = json['taMin4'];
    taMin4Low = json['taMin4Low'];
    taMin4High = json['taMin4High'];
    taMax4 = json['taMax4'];
    taMax4Low = json['taMax4Low'];
    taMax4High = json['taMax4High'];
    taMin5 = json['taMin5'];
    taMin5Low = json['taMin5Low'];
    taMin5High = json['taMin5High'];
    taMax5 = json['taMax5'];
    taMax5Low = json['taMax5Low'];
    taMax5High = json['taMax5High'];
    taMin6 = json['taMin6'];
    taMin6Low = json['taMin6Low'];
    taMin6High = json['taMin6High'];
    taMax6 = json['taMax6'];
    taMax6Low = json['taMax6Low'];
    taMax6High = json['taMax6High'];
    taMin7 = json['taMin7'];
    taMin7Low = json['taMin7Low'];
    taMin7High = json['taMin7High'];
    taMax7 = json['taMax7'];
    taMax7Low = json['taMax7Low'];
    taMax7High = json['taMax7High'];
    taMin8 = json['taMin8'];
    taMin8Low = json['taMin8Low'];
    taMin8High = json['taMin8High'];
    taMax8 = json['taMax8'];
    taMax8Low = json['taMax8Low'];
    taMax8High = json['taMax8High'];
    taMin9 = json['taMin9'];
    taMin9Low = json['taMin9Low'];
    taMin9High = json['taMin9High'];
    taMax9 = json['taMax9'];
    taMax9Low = json['taMax9Low'];
    taMax9High = json['taMax9High'];
    taMin10 = json['taMin10'];
    taMin10Low = json['taMin10Low'];
    taMin10High = json['taMin10High'];
    taMax10 = json['taMax10'];
    taMax10Low = json['taMax10Low'];
    taMax10High = json['taMax10High'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['regId'] = regId;
    data['taMin3'] = taMin3;
    data['taMin3Low'] = taMin3Low;
    data['taMin3High'] = taMin3High;
    data['taMax3'] = taMax3;
    data['taMax3Low'] = taMax3Low;
    data['taMax3High'] = taMax3High;
    data['taMin4'] = taMin4;
    data['taMin4Low'] = taMin4Low;
    data['taMin4High'] = taMin4High;
    data['taMax4'] = taMax4;
    data['taMax4Low'] = taMax4Low;
    data['taMax4High'] = taMax4High;
    data['taMin5'] = taMin5;
    data['taMin5Low'] = taMin5Low;
    data['taMin5High'] = taMin5High;
    data['taMax5'] = taMax5;
    data['taMax5Low'] = taMax5Low;
    data['taMax5High'] = taMax5High;
    data['taMin6'] = taMin6;
    data['taMin6Low'] = taMin6Low;
    data['taMin6High'] = taMin6High;
    data['taMax6'] = taMax6;
    data['taMax6Low'] = taMax6Low;
    data['taMax6High'] = taMax6High;
    data['taMin7'] = taMin7;
    data['taMin7Low'] = taMin7Low;
    data['taMin7High'] = taMin7High;
    data['taMax7'] = taMax7;
    data['taMax7Low'] = taMax7Low;
    data['taMax7High'] = taMax7High;
    data['taMin8'] = taMin8;
    data['taMin8Low'] = taMin8Low;
    data['taMin8High'] = taMin8High;
    data['taMax8'] = taMax8;
    data['taMax8Low'] = taMax8Low;
    data['taMax8High'] = taMax8High;
    data['taMin9'] = taMin9;
    data['taMin9Low'] = taMin9Low;
    data['taMin9High'] = taMin9High;
    data['taMax9'] = taMax9;
    data['taMax9Low'] = taMax9Low;
    data['taMax9High'] = taMax9High;
    data['taMin10'] = taMin10;
    data['taMin10Low'] = taMin10Low;
    data['taMin10High'] = taMin10High;
    data['taMax10'] = taMax10;
    data['taMax10Low'] = taMax10Low;
    data['taMax10High'] = taMax10High;
    return data;
  }

  @override
  String toString() {
    return 'MidTa: { regId: $regId,  taMin3: $taMin3, taMin3Low: $taMin3Low, taMin3High: $taMin3High, date: $date }';
  }
}

class MidTaList {
  String? dataType;
  Items? items;
  int? pageNo;
  int? numOfRows;
  int? totalCount;

  MidTaList(
      {this.dataType,
        this.items,
        this.pageNo,
        this.numOfRows,
        this.totalCount});

  MidTaList.fromJson(Map<String, dynamic> json) {
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
  List<MidTa>? item;

  Items({this.item});

  Items.fromJson(Map<String, dynamic> json) {
    if (json['item'] != null) {
      item = <MidTa>[];
      json['item'].forEach((v) {
        item!.add(MidTa.fromJson(v));
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
