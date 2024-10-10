class SunRiseSet {
  SunRiseSet({
    this.locdate,
    this.location,
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.longitudeNum,
    this.latitudeNum,
  });
  String? locdate;
  String? location;
  String? sunrise;
  String? sunset;
  String? moonrise;
  String? moonset;
  String? longitudeNum;
  String? latitudeNum;

  factory SunRiseSet.fromJson(Map<String, dynamic> json) => SunRiseSet(
    locdate: json["locdate"].toString().replaceAll(" ", "").replaceAll("-", ""),
    location: json["location"].toString().replaceAll(" ", "").replaceAll("-", ""),
    sunrise: json["sunrise"].toString().replaceAll(" ", "").replaceAll("-", ""),
    sunset: json["sunset"].toString().replaceAll(" ", "").replaceAll("-", ""),
    moonrise: json["moonrise"].toString().replaceAll(" ", "").replaceAll("-", ""),
    moonset: json["moonset"].toString().replaceAll(" ", "").replaceAll("-", ""),
    longitudeNum: json["longitudeNum"].toString().replaceAll(" ", "").replaceAll("-", ""),
    latitudeNum: json["latitudeNum"].toString().replaceAll(" ", "").replaceAll("-", ""),
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
  };

  @override
  String toString() {
    return 'SunRiseSet: { locdate: $locdate,  location: $location, sunrise: $sunrise, sunset: $sunset, moonrise: $moonrise, moonset: $moonset, longitudeNum: $longitudeNum, latitudeNum: $latitudeNum }';
  }
}