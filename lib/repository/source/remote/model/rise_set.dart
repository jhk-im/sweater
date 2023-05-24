class RiseSet {
  RiseSet({
    this.locdate,
    this.location,
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.longitudeNum,
    this.latitudeNum,
    // this.aste,
    // this.astm,
    // this.civile,
    // this.civilm,
    // this.latitude,
    // this.longitude,
    // this.moontransit,
    // this.naute,
    // this.nautm,
    // this.suntransit,
  });
  int? locdate;
  String? location;
  int? sunrise;
  int? sunset;
  int? moonrise;
  int? moonset;
  double? longitudeNum;
  double? latitudeNum;

  // int? aste;
  // int? astm;
  // int? civile;
  // int? civilm;
  // int? latitude;
  // int? longitude;
  // int? moontransit;
  // int? naute;
  // int? nautm;
  // int? suntransit;

  factory RiseSet.fromJson(Map<String, dynamic> json) => RiseSet(
    locdate: json["locdate"],
    location: json["location"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
    moonrise: json["moonrise"],
    moonset: json["moonset"],
    longitudeNum: json["longitudeNum"].toDouble(),
    latitudeNum: json["latitudeNum"].toDouble(),
    // aste: json["aste"],
    // astm: json["astm"],
    // civile: json["civile"],
    // civilm: json["civilm"],
    // latitude: json["latitude"],
    // longitude: json["longitude"],
    // moontransit: json["moontransit"],
    // naute: json["naute"],
    // nautm: json["nautm"],
    // suntransit: json["suntransit"],
  );

  Map<String, dynamic> toJson() => {
    "locdate": locdate,
    "location": location,
    "sunrise": sunrise,
    "sunset": sunset,
    "moonrise": moonrise,
    "moonset": moonset,
    "longitudeNum": longitudeNum,
    "latitudeNum": latitudeNum,
    // "aste": aste,
    // "astm": astm,
    // "civile": civile,
    // "civilm": civilm,
    // "latitude": latitude,
    // "longitude": longitude,
    // "moontransit": moontransit,
    // "naute": naute,
    // "nautm": nautm,
    // "suntransit": suntransit,
  };
}