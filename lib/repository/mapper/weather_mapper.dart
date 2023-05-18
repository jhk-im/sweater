import 'package:sweater/model/dnsty.dart';
import 'package:sweater/model/fcst.dart';
import 'package:sweater/model/ncst.dart';
import 'package:sweater/model/weather_category.dart';
import 'package:sweater/repository/source/local/dnsty_entity.dart';
import 'package:sweater/repository/source/local/fcst_entity.dart';
import 'package:sweater/repository/source/local/ncst_entity.dart';

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
    ncst.weatherCategory = WeatherCategory(name: name, unit: unit);
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
    return entity;
  }
}

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
    fcst.weatherCategory = WeatherCategory(name: name, unit: unit);
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
    entity.name = weatherCategory?.name ?? '';
    entity.unit = weatherCategory?.unit ?? '';
    return entity;
  }
}

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
