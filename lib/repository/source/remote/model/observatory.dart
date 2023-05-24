class Observatory {
  int? code;
  String? depth1;
  String? depth2;
  String? depth3;
  int? gridX;
  int? gridY;
  int? lonHour;
  int? lonMin;
  double? lonSec;
  int? latHour;
  int? latMin;
  double? latSec;
  double? longitude;
  double? latitude;

  Observatory(
      {this.code,
      this.depth1,
      this.depth2,
      this.depth3,
      this.gridX,
      this.gridY,
      this.lonHour,
      this.lonMin,
      this.lonSec,
      this.latHour,
      this.latMin,
      this.latSec,
      this.longitude,
      this.latitude});

  Observatory.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    depth1 = json['depth1'];
    depth2 = json['depth2'];
    depth3 = json['depth3'];
    gridX = json['gridX'];
    gridY = json['gridY'];
    lonHour = json['lonHour'];
    lonMin = json['lonMin'];
    lonSec = json['lonSec'];
    latHour = json['latHour'];
    latMin = json['latMin'];
    latSec = json['latSec'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['depth1'] = depth1;
    data['depth2'] = depth2;
    data['depth3'] = depth3;
    data['gridX'] = gridX;
    data['gridY'] = gridY;
    data['lonHour'] = lonHour;
    data['lonMin'] = lonMin;
    data['lonSec'] = lonSec;
    data['latHour'] = latHour;
    data['latMin'] = latMin;
    data['latSec'] = latSec;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }

  @override
  String toString() {
    return 'Observatory: { code: $code, depth1: $depth1, depth2: $depth2, depth3: $depth3, longitude: $longitude, latitude: $latitude, }';
  }
}
