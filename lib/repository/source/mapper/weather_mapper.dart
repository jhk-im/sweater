import 'package:sweater/repository/source/local/entity/observatory_entity.dart';
import 'package:sweater/repository/source/local/entity/rise_set_entity.dart';
import 'package:sweater/repository/source/local/entity/uv_rays_entity.dart';
import 'package:sweater/repository/source/remote/dto/observatory_dto.dart';
import 'package:sweater/repository/source/remote/model/address.dart';
import 'package:sweater/repository/source/remote/model/dnsty.dart';
import 'package:sweater/repository/source/remote/model/fcst.dart';
import 'package:sweater/repository/source/remote/model/ncst.dart';
import 'package:sweater/repository/source/remote/model/observatory.dart';
import 'package:sweater/repository/source/remote/model/uv_rays.dart';
import 'package:sweater/repository/source/remote/model/weather_category.dart';
import 'package:sweater/repository/source/local/entity/address_entity.dart';
import 'package:sweater/repository/source/local/entity/dnsty_entity.dart';
import 'package:sweater/repository/source/local/entity/fcst_entity.dart';
import 'package:sweater/repository/source/local/entity/ncst_entity.dart';

import '../remote/model/rise_set.dart';

// 날씨 실황
extension ToNcst on NcstEntity {
  Ncst toNcst() {
    var ncst = Ncst(
      baseDate: baseDate,
      baseTime: baseTime,
      category: category,
      nx: nx,
      ny: ny,
      obsrValue: obsrValue,
    );
    ncst.weatherCategory =
        WeatherCategory(name: name, unit: unit, codeValues: codeValues);
    return ncst;
  }
}
extension ToNcstEntity on Ncst {
  NcstEntity toNcstEntity() {
    var entity =
        NcstEntity(category: category ?? '', obsrValue: obsrValue ?? '');
    entity.baseTime = baseTime;
    entity.baseDate = baseDate;
    entity.nx = nx;
    entity.ny = ny;
    entity.name = weatherCategory?.name ?? '';
    entity.unit = weatherCategory?.unit ?? '';
    entity.codeValues = weatherCategory?.codeValues ?? [];
    return entity;
  }
}

// 날씨 예보
extension ToFcst on FcstEntity {
  Fcst toFcst() {
    var fcst = Fcst(
      baseDate: baseDate,
      baseTime: baseTime,
      category: category,
      fcstDate: fcstDate,
      fcstTime: fcstTime,
      fcstValue: fcstValue,
      nx: nx,
      ny: ny,
    );
    fcst.weatherCategory =
        WeatherCategory(name: name, unit: unit, codeValues: codeValues);
    return fcst;
  }
}
extension ToFcstEntity on Fcst {
  FcstEntity toFcstEntity() {
    var entity =
        FcstEntity(category: category ?? '', fcstValue: fcstValue ?? '');
    entity.baseTime = baseTime;
    entity.baseDate = baseDate;
    entity.fcstTime = fcstTime;
    entity.fcstDate = fcstDate;
    entity.nx = nx;
    entity.ny = ny;
    entity.codeValues = weatherCategory?.codeValues ?? [];
    entity.name = weatherCategory?.name ?? '';
    entity.unit = weatherCategory?.unit ?? '';
    return entity;
  }
}

// 미세먼지
extension ToDnsty on DnstyEntity {
  Dnsty toDnsty() {
    var dnsty = Dnsty();
    dnsty.so2Grade = so2Grade;
    dnsty.coFlag = coFlag;
    dnsty.khaiValue = khaiValue;
    dnsty.so2Value = so2Value;
    dnsty.coValue = coValue;
    dnsty.pm10Flag = pm10Flag;
    dnsty.pm10Value = pm10Value;
    dnsty.pm10Value24 = pm10Value24;
    dnsty.pm25Value = pm25Value;
    dnsty.pm25Value24 = pm25Value24;
    dnsty.o3Grade = o3Grade;
    dnsty.khaiGrade = khaiGrade;
    dnsty.no2Flag = no2Flag;
    dnsty.no2Grade = no2Grade;
    dnsty.o3Flag = o3Flag;
    dnsty.so2Flag = so2Flag;
    dnsty.dataTime = dataTime;
    dnsty.coGrade = coGrade;
    dnsty.no2Value = no2Value;
    dnsty.pm10Grade = pm10Grade;
    dnsty.o3Value = o3Value;
    return dnsty;
  }
}
extension ToDnstyEntity on Dnsty {
  DnstyEntity toDnstyEntity() {
    var dnstyEntity = DnstyEntity();
    dnstyEntity.so2Grade = so2Grade;
    dnstyEntity.coFlag = coFlag;
    dnstyEntity.khaiValue = khaiValue;
    dnstyEntity.so2Value = so2Value;
    dnstyEntity.coValue = coValue;
    dnstyEntity.pm10Flag = pm10Flag;
    dnstyEntity.pm10Value = pm10Value;
    dnstyEntity.pm10Value24 = pm10Value24;
    dnstyEntity.pm25Value = pm25Value;
    dnstyEntity.pm25Value24 = pm25Value24;
    dnstyEntity.o3Grade = o3Grade;
    dnstyEntity.khaiGrade = khaiGrade;
    dnstyEntity.no2Flag = no2Flag;
    dnstyEntity.no2Grade = no2Grade;
    dnstyEntity.o3Flag = o3Flag;
    dnstyEntity.so2Flag = so2Flag;
    dnstyEntity.dataTime = dataTime;
    dnstyEntity.coGrade = coGrade;
    dnstyEntity.no2Value = no2Value;
    dnstyEntity.pm10Grade = pm10Grade;
    dnstyEntity.o3Value = o3Value;
    return dnstyEntity;
  }
}

// 주소
extension ToAddressEntity on Address {
  AddressEntity toAddressEntity() {
    var entity = AddressEntity();
    entity.addressName = addressName;
    entity.region1depthName = region1depthName;
    entity.region2depthName = region2depthName;
    entity.region3depthName = region3depthName;
    entity.region4depthName = region4depthName;
    entity.x = x;
    entity.y = y;
    entity.code = code;
    entity.regionType = regionType;
    return entity;
  }
}
extension ToAddress on AddressEntity {
  Address toAddress() {
    var address = Address(
      addressName: addressName,
      region1depthName: region1depthName,
      region2depthName: region2depthName,
      region3depthName: region3depthName,
      region4depthName: region4depthName,
      x: x,
      y: y,
      code: code,
      regionType: regionType,
    );
    return address;
  }
}

// 출몰
extension ToRiseSetEntity on RiseSet {
  RiseSetEntity toRiseSetEntity() {
    var entity = RiseSetEntity();
    entity.locdate = locdate;
    entity.location = location;
    entity.sunrise = sunrise;
    entity.sunset = sunset;
    entity.moonrise = moonrise;
    entity.moonset = moonset;
    entity.longitudeNum = longitudeNum;
    entity.latitudeNum = latitudeNum;
    return entity;
  }
}
extension ToRiseSet on RiseSetEntity {
  RiseSet toRiseSet() {
    var address = RiseSet(
      locdate: locdate,
      location: location,
      sunrise: sunrise,
      sunset: sunset,
      moonrise: moonrise,
      moonset: moonset,
      longitudeNum: longitudeNum,
      latitudeNum: latitudeNum,
    );
    return address;
  }
}

// 관측소
extension ToObservatory on ObservatoryDto {
  Observatory toObservatory() {
    //print(code);
    return Observatory(
      code: code,
      depth1: depth1,
      depth2: depth2,
      depth3: depth3,
      gridX: gridX,
      gridY: gridY,
      lonHour: lonHour,
      lonMin: lonMin,
      lonSec: lonSec,
      latHour: latHour,
      latMin: latMin,
      latSec: latSec,
      longitude: longitude,
      latitude: latitude,
    );
  }
}
extension ToObservatoryEntity on Observatory {
  ObservatoryEntity toObservatoryEntity() {
    var entity = ObservatoryEntity();
    entity.code = code;
    entity.depth1 = depth1;
    entity.depth2 = depth2;
    entity.depth3 = depth3;
    entity.gridX = gridX;
    entity.gridY = gridY;
    entity.lonHour = lonHour;
    entity.lonMin = lonMin;
    entity.lonSec = lonSec;
    entity.latHour = latHour;
    entity.latMin = latMin;
    entity.latSec = latSec;
    entity.longitude = longitude;
    entity.latitude = latitude;
    return entity;
  }
}
extension ToObservatoryFromEntity on ObservatoryEntity {
  Observatory toObservatory() {
    //print(code);
    return Observatory(
      code: code,
      depth1: depth1,
      depth2: depth2,
      depth3: depth3,
      gridX: gridX,
      gridY: gridY,
      lonHour: lonHour,
      lonMin: lonMin,
      lonSec: lonSec,
      latHour: latHour,
      latMin: latMin,
      latSec: latSec,
      longitude: longitude,
      latitude: latitude,
    );
  }
}

// 자외선
extension ToUVRaysEntity on UVRays {
  UVRaysEntity toUVRaysEntity() {
    var entity = UVRaysEntity();
    entity.code = code;
    entity.areaNo = areaNo;
    entity.date = date;
    entity.h0 = h0;
    entity.h3 = h3;
    entity.h6 = h6;
    entity.h9 = h9;
    entity.h12 = h12;
    entity.h15 = h15;
    entity.h18 = h18;
    entity.h21 = h21;
    entity.h24 = h24;
    return entity;
  }
}
extension ToUVRays on UVRaysEntity {
  UVRays toUVRays() {
    var uvRays = UVRays(
      code: code,
      areaNo: areaNo,
      date: date,
      h0: h0,
      h3: h3,
      h6: h6,
      h9: h9,
      h12: h12,
      h15: h15,
      h18: h18,
      h21: h21,
      h24: h24,
    );
    return uvRays;
  }
}