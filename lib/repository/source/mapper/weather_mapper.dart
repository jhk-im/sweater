import 'package:sweater/repository/source/local/entity/mid_code_entity.dart';
import 'package:sweater/repository/source/local/entity/mid_ta_entity.dart';
import 'package:sweater/repository/source/local/entity/mid_land_fcst_entity.dart';
import 'package:sweater/repository/source/local/entity/observatory_entity.dart';
import 'package:sweater/repository/source/local/entity/rise_set_entity.dart';
import 'package:sweater/repository/source/local/entity/uv_rays_entity.dart';
import 'package:sweater/repository/source/remote/dto/mid_code_dto.dart';
import 'package:sweater/repository/source/remote/dto/observatory_dto.dart';
import 'package:sweater/repository/source/remote/model/address_response.dart';
import 'package:sweater/repository/source/remote/model/fine_dust.dart';
import 'package:sweater/repository/source/remote/model/short_term.dart';
import 'package:sweater/repository/source/remote/model/mid_code.dart';
import 'package:sweater/repository/source/remote/model/mid_term_land.dart';
import 'package:sweater/repository/source/remote/model/mid_term_temperature.dart';
import 'package:sweater/repository/source/remote/model/observatory.dart';
import 'package:sweater/repository/source/remote/model/ultra_short_term_response.dart';
import 'package:sweater/repository/source/remote/model/ultraviolet.dart';
import 'package:sweater/repository/source/remote/model/weather_category.dart';
import 'package:sweater/repository/source/local/entity/address_entity.dart';
import 'package:sweater/repository/source/local/entity/dnsty_entity.dart';
import 'package:sweater/repository/source/local/entity/fcst_entity.dart';
import 'package:sweater/repository/source/local/entity/ultra_short_term_entity.dart';

import '../remote/model/sun_rise_set.dart';

// 날씨 실황
extension ToUltraShortTerm on UltraShortTermEntity {
  UltraShortTerm toUltraShortTermEntity() {
    var model = UltraShortTerm(
      baseDate: baseDate,
      baseTime: baseTime,
      category: category,
      nx: nx,
      ny: ny,
      obsrValue: obsrValue,
    );
    model.weatherCategory =
        WeatherCategory(name: name, unit: unit, codeValues: codeValues);
    return model;
  }
}

extension ToUltraShortTermEntity on UltraShortTerm {
  UltraShortTermEntity toUltraShortTermEntity() {
    var entity =
    UltraShortTermEntity(category: category ?? '', obsrValue: obsrValue ?? '');
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
  ShortTerm toFcst() {
    var fcst = ShortTerm(
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

extension ToFcstEntity on ShortTerm {
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
  FineDust toDnsty() {
    var dnsty = FineDust();
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

extension ToDnstyEntity on FineDust {
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
extension ToAddressEntity on AddressResult {
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
  AddressResult toAddress() {
    return AddressResult(
      addressName: addressName ?? '',
      region1depthName: region1depthName ?? '',
      region2depthName: region2depthName ?? '',
      region3depthName: region3depthName ?? '',
      region4depthName: region4depthName ?? '',
      x: x ?? 0,
      y: y ?? 0,
      code: code ?? '',
      regionType: regionType ?? '',
    );
  }
}

// 출몰
extension ToRiseSetEntity on SunRiseSet {
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
  SunRiseSet toRiseSet() {
    var address = SunRiseSet(
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

// 중기 예보
extension ToMidCode on MidCodeDto {
  MidCode toMidCode() {
    return MidCode(
      city: city,
      code: code,
    );
  }
}

extension ToMidCodeEntity on MidCode {
  MidCodeEntity toMidCodeEntity() {
    var entity = MidCodeEntity();
    entity.city = city;
    entity.code = code;
    return entity;
  }
}

extension ToMidCodeFromEntity on MidCodeEntity {
  MidCode toMidCode() {
    return MidCode(
      city: city,
      code: code,
    );
  }
}

extension ToMidTaEntity on MidTermTemperature {
  MidTaEntity toMidTaEntity() {
    var entity = MidTaEntity();
    entity.regId = regId;
    entity.taMin3 = taMin3;
    entity.taMax3 = taMax3;
    entity.taMin3 = taMin3;
    entity.taMax3 = taMax3;
    entity.taMin4 = taMin4;
    entity.taMax4 = taMax4;
    entity.taMin5 = taMin5;
    entity.taMax5 = taMax5;
    entity.taMin6 = taMin6;
    entity.taMax6 = taMax6;
    entity.taMin7 = taMin7;
    entity.taMax7 = taMax7;
    entity.taMin8 = taMin8;
    entity.taMax8 = taMax8;
    entity.taMin9 = taMin9;
    entity.taMax9 = taMax9;
    entity.taMin10 = taMin10;
    entity.taMax10 = taMax10;
    entity.date = date;
    return entity;
  }
}

extension ToMidTa on MidTaEntity {
  MidTermTemperature toMidTa() {
    MidTermTemperature midTa = MidTermTemperature(
      regId: regId,
      taMin3: taMin3,
      taMax3: taMax3,
      taMin4: taMin4,
      taMax4: taMax4,
      taMin5: taMin5,
      taMax5: taMax5,
      taMin6: taMin6,
      taMax6: taMax6,
      taMin7: taMin7,
      taMax7: taMax7,
      taMin8: taMin8,
      taMax8: taMax8,
      taMin9: taMin9,
      taMax9: taMax9,
      taMin10: taMin10,
      taMax10: taMax10,
    );
    midTa.date = date;
    return midTa;
  }
}

extension ToMidLandFcstEntity on MidTermLand {
  MidLandFcstEntity toMidLandFcstEntity() {
    var entity = MidLandFcstEntity();
    entity.regId = regId;
    entity.rnSt3Am = rnSt3Am;
    entity.rnSt3Pm = rnSt3Pm;
    entity.rnSt4Am = rnSt4Am;
    entity.rnSt4Pm = rnSt4Pm;
    entity.rnSt5Am = rnSt5Am;
    entity.rnSt5Pm = rnSt5Pm;
    entity.rnSt6Am = rnSt6Am;
    entity.rnSt6Pm = rnSt6Pm;
    entity.rnSt7Am = rnSt7Am;
    entity.rnSt7Pm = rnSt7Pm;
    entity.rnSt8 = rnSt8;
    entity.rnSt9 = rnSt9;
    entity.rnSt10 = rnSt10;
    entity.wf3Am = wf3Am;
    entity.wf3Pm = wf3Pm;
    entity.wf4Am = wf4Am;
    entity.wf4Pm = wf4Pm;
    entity.wf5Am = wf5Am;
    entity.wf5Pm = wf5Pm;
    entity.wf6Am = wf6Am;
    entity.wf6Pm = wf6Pm;
    entity.wf7Am = wf7Am;
    entity.wf7Pm = wf7Pm;
    entity.wf8 = wf8;
    entity.wf9 = wf9;
    entity.wf10 = wf10;
    entity.date = date;
    return entity;
  }
}

extension ToMidLandFcst on MidLandFcstEntity {
  MidTermLand toMidLandFcst() {
    MidTermLand midLandFcst = MidTermLand(
      regId: regId,
      rnSt3Am: rnSt3Am,
      rnSt3Pm: rnSt3Pm,
      rnSt4Am: rnSt4Am,
      rnSt4Pm: rnSt4Pm,
      rnSt5Am: rnSt5Am,
      rnSt5Pm: rnSt5Pm,
      rnSt6Am: rnSt6Am,
      rnSt6Pm: rnSt6Pm,
      rnSt7Am: rnSt7Am,
      rnSt7Pm: rnSt7Pm,
      rnSt8: rnSt8,
      rnSt9: rnSt9,
      rnSt10: rnSt10,
      wf3Am: wf3Am,
      wf3Pm: wf3Pm,
      wf4Am: wf4Am,
      wf4Pm: wf4Pm,
      wf5Am: wf5Am,
      wf5Pm: wf5Pm,
      wf6Am: wf6Am,
      wf6Pm: wf6Pm,
      wf7Am: wf7Am,
      wf7Pm: wf7Pm,
      wf8: wf8,
      wf9: wf9,
      wf10: wf10,
    );
    midLandFcst.date = date;
    return midLandFcst;
  }
}
