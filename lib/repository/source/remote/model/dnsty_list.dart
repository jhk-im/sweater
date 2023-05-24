import 'package:sweater/repository/source/remote/model/dnsty.dart';

class DnstyList {
  int? totalCount;
  List<Dnsty>? items;
  int? pageNo;
  int? numOfRows;

  DnstyList({this.totalCount, this.items, this.pageNo, this.numOfRows});

  DnstyList.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = <Dnsty>[];
      json['items'].forEach((v) {
        items!.add(Dnsty.fromJson(v));
      });
    }
    pageNo = json['pageNo'];
    numOfRows = json['numOfRows'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['pageNo'] = pageNo;
    data['numOfRows'] = numOfRows;
    return data;
  }
}