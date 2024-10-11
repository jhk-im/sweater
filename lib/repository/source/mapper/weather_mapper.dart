import 'package:sweater/repository/source/local/entity/mid_code_entity.dart';
import 'package:sweater/repository/source/local/entity/mid_term_temperature_entity.dart';
import 'package:sweater/repository/source/local/entity/mid_term_land_entity.dart';
import 'package:sweater/repository/source/local/entity/observatory_entity.dart';
import 'package:sweater/repository/source/local/entity/sun_rise_entity.dart';
import 'package:sweater/repository/source/local/entity/ultraviolet_entity.dart';
import 'package:sweater/repository/source/remote/dto/mid_code_dto.dart';
import 'package:sweater/repository/source/remote/dto/observatory_dto.dart';
import 'package:sweater/repository/source/remote/model/address_response.dart';
import 'package:sweater/repository/source/remote/model/fine_dust_response.dart';
import 'package:sweater/repository/source/remote/model/mid_code.dart';
import 'package:sweater/repository/source/remote/model/mid_term_land_response.dart';
import 'package:sweater/repository/source/remote/model/mid_term_temperature_response.dart';
import 'package:sweater/repository/source/remote/model/observatory.dart';
import 'package:sweater/repository/source/remote/model/sun_rise_response.dart';
import 'package:sweater/repository/source/remote/model/ultraviolet_response.dart';
import 'package:sweater/repository/source/remote/model/weather_response.dart';
import 'package:sweater/repository/source/remote/model/weather_category.dart';
import 'package:sweater/repository/source/local/entity/address_entity.dart';
import 'package:sweater/repository/source/local/entity/fine_dust_entity.dart';
import 'package:sweater/repository/source/local/entity/weather_item_entity.dart';

extension ToWeatherItem on WeatherItemEntity {
  WeatherItem toUltraShortTermEntity() {
    var model = WeatherItem(
      baseDate: baseDate,
      baseTime: baseTime,
      category: category,
      nx: nx,
      ny: ny,
      obsrValue: obsrValue,
      fcstDate: fcstDate,
      fcstTime: fcstTime,
      fcstValue: fcstValue,
    );
    model.weatherCategory =
        WeatherCategory(name: name, unit: unit, codeValues: codeValues);
    return model;
  }
}

extension ToWeatherItemEntity on WeatherItem {
  WeatherItemEntity toWeatherItemEntity() {
    var entity =
        WeatherItemEntity(category: category ?? '', obsrValue: obsrValue ?? '');
    entity.baseTime = baseTime;
    entity.baseDate = baseDate;
    entity.nx = nx;
    entity.ny = ny;
    entity.name = weatherCategory?.name ?? '';
    entity.unit = weatherCategory?.unit ?? '';
    entity.codeValues = weatherCategory?.codeValues ?? [];
    entity.fcstDate = fcstDate;
    entity.fcstTime = fcstTime;
    entity.fcstValue = fcstValue;
    return entity;
  }
}

// 미세먼지
extension ToFineDust on FineDustEntity {
  FineDust toFineDust() {
    return FineDust(
      so2Grade: so2Grade,
      coFlag: coFlag,
      khaiValue: khaiValue,
      so2Value: so2Value,
      coValue: coValue,
      pm10Flag: pm10Flag,
      pm10Value: pm10Value,
      pm10Value24: pm10Value24,
      pm25Value: pm25Value,
      pm25Value24: pm25Value24,
      o3Grade: o3Grade,
      khaiGrade: khaiGrade,
      no2Flag: no2Flag,
      no2Grade: no2Grade,
      o3Flag: o3Flag,
      so2Flag: so2Flag,
      dataTime: dataTime,
      coGrade: coGrade,
      no2Value: no2Value,
      pm10Grade: pm10Grade,
      o3Value: o3Value,
    );
  }
}

extension ToFineDustEntity on FineDust {
  FineDustEntity toFineDustEntity() {
    var entity = FineDustEntity();
    entity.so2Grade = so2Grade;
    entity.coFlag = coFlag;
    entity.khaiValue = khaiValue;
    entity.so2Value = so2Value;
    entity.coValue = coValue;
    entity.pm10Flag = pm10Flag;
    entity.pm10Value = pm10Value;
    entity.pm10Value24 = pm10Value24;
    entity.pm25Value = pm25Value;
    entity.pm25Value24 = pm25Value24;
    entity.o3Grade = o3Grade;
    entity.khaiGrade = khaiGrade;
    entity.no2Flag = no2Flag;
    entity.no2Grade = no2Grade;
    entity.o3Flag = o3Flag;
    entity.so2Flag = so2Flag;
    entity.dataTime = dataTime;
    entity.coGrade = coGrade;
    entity.no2Value = no2Value;
    entity.pm10Grade = pm10Grade;
    entity.o3Value = o3Value;
    return entity;
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
extension ToSunRiseEntity on SunRise {
  SunRiseEntity toSunRiseEntity() {
    var entity = SunRiseEntity();
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

extension ToSunRise on SunRiseEntity {
  SunRise toSunRise() {
    return SunRise(
      locdate: locdate,
      location: location,
      sunrise: sunrise,
      sunset: sunset,
      moonrise: moonrise,
      moonset: moonset,
      longitudeNum: longitudeNum,
      latitudeNum: latitudeNum,
    );
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
extension ToUltravioletEntity on Ultraviolet {
  UltravioletEntity toUltravioletEntity() {
    var entity = UltravioletEntity();
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

extension ToUltraviolet on UltravioletEntity {
  Ultraviolet toUltraviolet() {
    var uvRays = Ultraviolet(
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

extension ToMidTermTemperatureEntity on MidTermTemperature {
  MidTermTemperatureEntity toMidTermTemperatureEntity() {
    var entity = MidTermTemperatureEntity();
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

extension ToMidTermTemperature on MidTermTemperatureEntity {
  MidTermTemperature toMidTermTemperature() {
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

extension ToMidTermLandEntity on MidTermLand {
  MidTermLandEntity toMidTermLandEntity() {
    var entity = MidTermLandEntity();
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

extension ToMidTermLand on MidTermLandEntity {
  MidTermLand toMidTermLand() {
    MidTermLand midTermLand = MidTermLand(
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
    midTermLand.date = date;
    return midTermLand;
  }
}
