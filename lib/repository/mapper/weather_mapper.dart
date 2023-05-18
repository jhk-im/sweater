import 'package:sweater/model/fcst.dart';
import 'package:sweater/model/ncst.dart';
import 'package:sweater/model/weather_category.dart';
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
