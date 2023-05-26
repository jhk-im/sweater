class MidLandFcst {
  String? regId;
  int? rnSt3Am;
  int? rnSt3Pm;
  int? rnSt4Am;
  int? rnSt4Pm;
  int? rnSt5Am;
  int? rnSt5Pm;
  int? rnSt6Am;
  int? rnSt6Pm;
  int? rnSt7Am;
  int? rnSt7Pm;
  int? rnSt8;
  int? rnSt9;
  int? rnSt10;
  String? wf3Am;
  String? wf3Pm;
  String? wf4Am;
  String? wf4Pm;
  String? wf5Am;
  String? wf5Pm;
  String? wf6Am;
  String? wf6Pm;
  String? wf7Am;
  String? wf7Pm;
  String? wf8;
  String? wf9;
  String? wf10;

  MidLandFcst(
      {this.regId,
        this.rnSt3Am,
        this.rnSt3Pm,
        this.rnSt4Am,
        this.rnSt4Pm,
        this.rnSt5Am,
        this.rnSt5Pm,
        this.rnSt6Am,
        this.rnSt6Pm,
        this.rnSt7Am,
        this.rnSt7Pm,
        this.rnSt8,
        this.rnSt9,
        this.rnSt10,
        this.wf3Am,
        this.wf3Pm,
        this.wf4Am,
        this.wf4Pm,
        this.wf5Am,
        this.wf5Pm,
        this.wf6Am,
        this.wf6Pm,
        this.wf7Am,
        this.wf7Pm,
        this.wf8,
        this.wf9,
        this.wf10});

  MidLandFcst.fromJson(Map<String, dynamic> json) {
    regId = json['regId'];
    rnSt3Am = json['rnSt3Am'];
    rnSt3Pm = json['rnSt3Pm'];
    rnSt4Am = json['rnSt4Am'];
    rnSt4Pm = json['rnSt4Pm'];
    rnSt5Am = json['rnSt5Am'];
    rnSt5Pm = json['rnSt5Pm'];
    rnSt6Am = json['rnSt6Am'];
    rnSt6Pm = json['rnSt6Pm'];
    rnSt7Am = json['rnSt7Am'];
    rnSt7Pm = json['rnSt7Pm'];
    rnSt8 = json['rnSt8'];
    rnSt9 = json['rnSt9'];
    rnSt10 = json['rnSt10'];
    wf3Am = json['wf3Am'];
    wf3Pm = json['wf3Pm'];
    wf4Am = json['wf4Am'];
    wf4Pm = json['wf4Pm'];
    wf5Am = json['wf5Am'];
    wf5Pm = json['wf5Pm'];
    wf6Am = json['wf6Am'];
    wf6Pm = json['wf6Pm'];
    wf7Am = json['wf7Am'];
    wf7Pm = json['wf7Pm'];
    wf8 = json['wf8'];
    wf9 = json['wf9'];
    wf10 = json['wf10'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['regId'] = regId;
    data['rnSt3Am'] = rnSt3Am;
    data['rnSt3Pm'] = rnSt3Pm;
    data['rnSt4Am'] = rnSt4Am;
    data['rnSt4Pm'] = rnSt4Pm;
    data['rnSt5Am'] = rnSt5Am;
    data['rnSt5Pm'] = rnSt5Pm;
    data['rnSt6Am'] = rnSt6Am;
    data['rnSt6Pm'] = rnSt6Pm;
    data['rnSt7Am'] = rnSt7Am;
    data['rnSt7Pm'] = rnSt7Pm;
    data['rnSt8'] = rnSt8;
    data['rnSt9'] = rnSt9;
    data['rnSt10'] = rnSt10;
    data['wf3Am'] = wf3Am;
    data['wf3Pm'] = wf3Pm;
    data['wf4Am'] = wf4Am;
    data['wf4Pm'] = wf4Pm;
    data['wf5Am'] = wf5Am;
    data['wf5Pm'] = wf5Pm;
    data['wf6Am'] = wf6Am;
    data['wf6Pm'] = wf6Pm;
    data['wf7Am'] = wf7Am;
    data['wf7Pm'] = wf7Pm;
    data['wf8'] = wf8;
    data['wf9'] = wf9;
    data['wf10'] = wf10;
    return data;
  }

  @override
  String toString() {
    return 'MidLandFcst: { regId: $regId,  rnSt3Am: $rnSt3Am, rnSt3Pm: $rnSt3Pm, wf3Am: $wf3Am, wf3Pm: $wf3Pm }';
  }
}

class MidLandFcstList {
  String? dataType;
  Items? items;
  int? pageNo;
  int? numOfRows;
  int? totalCount;

  MidLandFcstList(
      {this.dataType,
        this.items,
        this.pageNo,
        this.numOfRows,
        this.totalCount});

  MidLandFcstList.fromJson(Map<String, dynamic> json) {
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
  List<MidLandFcst>? item;

  Items({this.item});

  Items.fromJson(Map<String, dynamic> json) {
    if (json['item'] != null) {
      item = <MidLandFcst>[];
      json['item'].forEach((v) {
        item!.add(MidLandFcst.fromJson(v));
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