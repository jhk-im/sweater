import 'dart:math' as math;

class ConvertGps {
  static const double kRE = 6371.00877; // 지구 반경(km)
  static const double kGRID = 5.0; // 격자 간격(km)
  static const double kSLAT1 = 30.0; // 투영 위도1(degree)
  static const double kSLAT2 = 60.0; // 투영 위도2(degree)
  static const double kOLON = 126.0; // 기준점 경도(degree)
  static const double kOLAT = 38.0; // 기준점 위도(degree)
  static const double kXO = 43; // 기준점 X좌표(GRID)
  static const double kYO = 136; // 기1준점 Y좌표(GRID)

  static const double kDEGRAD = math.pi / 180.0;
  static const double kRADDEG = 180.0 / math.pi;

  static double get re => kRE / kGRID;
  static double get slat1 => kSLAT1 * kDEGRAD;
  static double get slat2 => kSLAT2 * kDEGRAD;
  static double get oLon => kOLON * kDEGRAD;
  static double get oLat => kOLAT * kDEGRAD;

  static double get snTmp =>
      math.tan(math.pi * 0.25 + slat2 * 0.5) /
      math.tan(math.pi * 0.25 + slat1 * 0.5);
  static double get sn =>
      math.log(math.cos(slat1) / math.cos(slat2)) / math.log(snTmp);

  static double get sfTmp => math.tan(math.pi * 0.25 + slat1 * 0.5);
  static double get sf => math.pow(sfTmp, sn) * math.cos(slat1) / sn;

  static double get roTmp => math.tan(math.pi * 0.25 + oLat * 0.5);

  static double get ro => re * sf / math.pow(roTmp, sn);

  static gridToGPS(int v1, int v2) {
    var rs = {};
    double theta;

    rs['x'] = v1;
    rs['y'] = v2;
    int xn = (v1 - kXO).toInt();
    int yn = (ro - v2 + kYO).toInt();
    var ra = math.sqrt(xn * xn + yn * yn);
    if (sn < 0.0) ra = -ra;
    var alat = math.pow((re * sf / ra), (1.0 / sn));
    alat = 2.0 * math.atan(alat) - math.pi * 0.5;

    if (xn.abs() <= 0.0) {
      theta = 0.0;
    } else {
      if (yn.abs() <= 0.0) {
        theta = math.pi * 0.5;
        if (xn < 0.0) theta = -theta;
      } else {
        theta = math.atan2(xn, yn);
      }
    }
    var alon = theta / sn + oLon;
    rs['lat'] = alat * kRADDEG;
    rs['lng'] = alon * kRADDEG;

    return rs;
  }

  static gpsToGRID(double v1, double v2) {
    var rs = {};
    double theta;

    rs['lat'] = v1;
    rs['lng'] = v2;
    var ra = math.tan(math.pi * 0.25 + (v1) * kDEGRAD * 0.5);
    ra = re * sf / math.pow(ra, sn);
    theta = v2 * kDEGRAD - oLon;
    if (theta > math.pi) theta -= 2.0 * math.pi;
    if (theta < -math.pi) theta += 2.0 * math.pi;
    theta *= sn;
    rs['x'] = (ra * math.sin(theta) + kXO + 0.5).floor();
    rs['y'] = (ro - ra * math.cos(theta) + kYO + 0.5).floor();

    return rs;
  }
}
