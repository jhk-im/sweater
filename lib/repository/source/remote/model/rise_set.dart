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
  String? locdate;
  String? location;
  String? sunrise;
  String? sunset;
  String? moonrise;
  String? moonset;
  String? longitudeNum;
  String? latitudeNum;

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
    locdate: json["locdate"].toString().replaceAll(" ", "").replaceAll("-", ""),
    location: json["location"].toString().replaceAll(" ", "").replaceAll("-", ""),
    sunrise: json["sunrise"].toString().replaceAll(" ", "").replaceAll("-", ""),
    sunset: json["sunset"].toString().replaceAll(" ", "").replaceAll("-", ""),
    moonrise: json["moonrise"].toString().replaceAll(" ", "").replaceAll("-", ""),
    moonset: json["moonset"].toString().replaceAll(" ", "").replaceAll("-", ""),
    longitudeNum: json["longitudeNum"].toString().replaceAll(" ", "").replaceAll("-", ""),
    latitudeNum: json["latitudeNum"].toString().replaceAll(" ", "").replaceAll("-", ""),
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

  @override
  String toString() {
    // TODO: implement toString
    return 'RiseSet: { locdate: $locdate,  location: $location, sunrise: $sunrise, sunset: $sunset, moonrise: $moonrise, moonset: $moonset, longitudeNum: $longitudeNum, latitudeNum: $latitudeNum }';
  }
}