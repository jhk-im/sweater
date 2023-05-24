import 'dart:convert';

import 'package:sweater/repository/source/remote/model/rise_set.dart';

RiseSetInfo riseSetInfoFromJson(String str) => RiseSetInfo.fromJson(json.decode(str));

String riseSetInfoToJson(RiseSetInfo data) => json.encode(data.toJson());

class RiseSetInfo {
  RiseSetInfo({
    this.item,
  });

  RiseSet? item;

  factory RiseSetInfo.fromJson(Map<String, dynamic> json) => RiseSetInfo(
    item: RiseSet.fromJson(json["item"]),
  );

  Map<String, dynamic> toJson() => {
    "item": item?.toJson(),
  };
}
