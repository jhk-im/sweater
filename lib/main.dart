import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sweater/repository/source/local/entity/mid_code_entity.dart';
import 'package:sweater/repository/source/local/entity/mid_land_fcst_entity.dart';
import 'package:sweater/repository/source/local/entity/mid_ta_entity.dart';
import 'package:sweater/repository/source/local/entity/observatory_entity.dart';
import 'package:sweater/repository/source/local/entity/rise_set_entity.dart';
import 'package:sweater/repository/source/local/entity/uv_rays_entity.dart';
import 'package:sweater/repository/source/local/entity/address_entity.dart';
import 'package:sweater/repository/source/local/entity/dnsty_entity.dart';
import 'package:sweater/repository/source/local/entity/fcst_entity.dart';
import 'package:sweater/repository/source/local/entity/ncst_entity.dart';
import 'package:sweater/repository/source/local/weather_dao.dart';
import 'package:sweater/repository/source/remote/model/fcst.dart';
import 'package:sweater/repository/source/remote/remote_api.dart';
import 'package:sweater/repository/weather_repository.dart';
import 'package:sweater/utils/color_schemes.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // dotenv
  await dotenv.load(fileName: 'assets/.env');

  // hive
  await Hive.initFlutter();
  Hive.registerAdapter(NcstEntityAdapter());
  Hive.registerAdapter(FcstEntityAdapter());
  Hive.registerAdapter(DnstyEntityAdapter());
  Hive.registerAdapter(AddressEntityAdapter());
  Hive.registerAdapter(RiseSetEntityAdapter());
  Hive.registerAdapter(ObservatoryEntityAdapter());
  Hive.registerAdapter(UVRaysEntityAdapter());
  Hive.registerAdapter(MidCodeEntityAdapter());
  Hive.registerAdapter(MidTaEntityAdapter());
  Hive.registerAdapter(MidLandFcstEntityAdapter());

  // repository
  final repository = WeatherRepository(RemoteApi(), WeatherDao());
  runApp(const MyApp());

  // 현재 좌표 주소
  var address = await repository.getAddressWithCoordinate();
  address.when(success: (adr) async {
    print(adr);

    double longitude = adr.x ?? 0;
    double latitude = adr.y ?? 0;
    String depth1 = adr.region1depthName ?? '';
    String depth2 = adr.region2depthName ?? '';

    // 날씨 현재 실황
    // 강수형태, 습도, 강수량, 기온, 풍속, 풍속(동서), 풍속(남북), 풍향
    var ultraNcst = await repository.getUltraStrNcst(longitude, latitude);
    ultraNcst.when(success: (ncstList) {
      print('---날씨 실황---');
      print(ncstList);
    }, error: (e) {
      print(e);
    });

    // 어제 단기 예보
    // 어제 - 오늘 : 최저 최고
    // 0200
    var yesterdayVilageFcst =
        await repository.getVilageFast(false, longitude, latitude);
    yesterdayVilageFcst.when(success: (info) {
      //print('Yesterday Fcst list length -> ${info.length}');
      _tmnList
          .addAll(info.where((element) => element.category! == 'TMN').toList());
      _tmxList
          .addAll(info.where((element) => element.category! == 'TMX').toList());
    }, error: (e) {
      print(e);
    });

    // 오늘 단기 예보
    // 오늘 - 내일 : 최저 최고 기온
    var tomorrowVilageFcst =
        await repository.getVilageFast(true, longitude, latitude);
    tomorrowVilageFcst.when(success: (info) {
      //print('Tomorrow Fcst list length -> ${info.length}');
      _tmnList
          .addAll(info.where((element) => element.category! == 'TMN').toList());
      _tmxList
          .addAll(info.where((element) => element.category! == 'TMX').toList());
      updatePopList(
          info.where((element) => element.category! == 'POP').toList(),
          _popList);
      updateSkyList(
          info.where((element) => element.category! == 'SKY').toList(),
          _skyList);
    }, error: (e) {
      print(e);
    });

    // 중기 기상 정보를 위한 코드 가져오기
    // 중기 예보 * 3일후 - 10일 후 까지
    // 강수확률 평균, 하늘상태, 최고 최저 기온
    var midCode = await repository.getMidCode(depth1, depth2);
    midCode.when(success: (info) async {
      print(info);
      String regId = info.code ?? '';

      // 중기 기온 예보
      var midTa = await repository.getMidTa(regId);
      midTa.when(success: (info) {
        //print(info);
        _tmnList.add(_setFcst(_tmnList.last, info.taMin3 ?? 0));
        _tmnList.add(_setFcst(_tmnList.last, info.taMin4 ?? 0));
        _tmnList.add(_setFcst(_tmnList.last, info.taMin5 ?? 0));
        _tmnList.add(_setFcst(_tmnList.last, info.taMin6 ?? 0));
        _tmnList.add(_setFcst(_tmnList.last, info.taMin7 ?? 0));
        _tmnList.add(_setFcst(_tmnList.last, info.taMin8 ?? 0));
        _tmnList.add(_setFcst(_tmnList.last, info.taMin9 ?? 0));
        _tmnList.add(_setFcst(_tmnList.last, info.taMin10 ?? 0));

        _tmxList.add(_setFcst(_tmxList.last, info.taMax3 ?? 0));
        _tmxList.add(_setFcst(_tmxList.last, info.taMax4 ?? 0));
        _tmxList.add(_setFcst(_tmxList.last, info.taMax5 ?? 0));
        _tmxList.add(_setFcst(_tmxList.last, info.taMax6 ?? 0));
        _tmxList.add(_setFcst(_tmxList.last, info.taMax7 ?? 0));
        _tmxList.add(_setFcst(_tmxList.last, info.taMax8 ?? 0));
        _tmxList.add(_setFcst(_tmxList.last, info.taMax9 ?? 0));
        _tmxList.add(_setFcst(_tmxList.last, info.taMax10 ?? 0));
      }, error: (e) {
        print(e);
      });

      // 중기 육상 예보
      var midLandFcst = await repository.getMidLandFcst(depth1, depth2);
      midLandFcst.when(success: (info) {
        _popList.add(
            _setFcst(_popList.last, max(info.rnSt3Am ?? 0, info.rnSt3Pm ?? 0)));
        _popList.add(
            _setFcst(_popList.last, max(info.rnSt4Am ?? 0, info.rnSt4Pm ?? 0)));
        _popList.add(
            _setFcst(_popList.last, max(info.rnSt5Am ?? 0, info.rnSt5Pm ?? 0)));
        _popList.add(
            _setFcst(_popList.last, max(info.rnSt6Am ?? 0, info.rnSt6Pm ?? 0)));
        _popList.add(
            _setFcst(_popList.last, max(info.rnSt7Am ?? 0, info.rnSt7Pm ?? 0)));
        _popList.add(_setFcst(_popList.last, info.rnSt8 ?? 0));
        _popList.add(_setFcst(_popList.last, info.rnSt9 ?? 0));
        _popList.add(_setFcst(_popList.last, info.rnSt10 ?? 0));

        _skyList.add(_setFcst(_skyList.last, info.wf3Am ?? ''));
        _skyList.add(_setFcst(_skyList.last, info.wf4Am ?? ''));
        _skyList.add(_setFcst(_skyList.last, info.wf5Am ?? ''));
        _skyList.add(_setFcst(_skyList.last, info.wf6Am ?? ''));
        _skyList.add(_setFcst(_skyList.last, info.wf7Am ?? ''));
        _skyList.add(_setFcst(_skyList.last, info.wf8 ?? ''));
        _skyList.add(_setFcst(_skyList.last, info.wf9 ?? ''));
        _skyList.add(_setFcst(_skyList.last, info.wf10 ?? ''));
      }, error: (e) {
        print(e);
      });

      print('---최저기온---');
      print(_tmnList);
      print('---최고기온---');
      print(_tmxList);
      print('---강수량---');
      print(_popList);
      print('---하늘상태---');
      print(_skyList);
    }, error: (e) {
      print(e);
    });

    // 미세먼지
    String query = adr.region2depthName != null ? adr.region2depthName! : '';
    var dnsty = await repository.getMesureDnsty(false, query);
    dnsty.when(success: (info) {
      print('---미세먼지---');
      print(info);
    }, error: (e) {
      print(e);
    });

    // 출몰
    var riseSet =
        await repository.getRiseSetWithCoordinate(longitude, latitude);
    riseSet.when(success: (info) {
      print('---일출/일몰---');
      print(info);
    }, error: (e) {
      print(e);
    });

    // 관측소 정보 -> 자외선 치수
    var observatory =
        await repository.getObservatoryWithAddress(depth1, depth2);
    observatory.when(success: (info) async {
      //print(info);
      // 자외선 지수
      var uvRays = await repository.getUVRays('${info.code}');
      uvRays.when(success: (info) {
        print('---자외선 지수---');
        print(info);
      }, error: (e) {
        print(e);
      });
    }, error: (e) {
      print(e);
    });
  }, error: (e) {
    print(e);
  });
}

List<Fcst> _tmnList = []; // 최저기온
List<Fcst> _tmxList = []; // 최고기온
List<Fcst> _popList = []; // 강수확률
List<Fcst> _skyList = []; // 하늘상태
void updatePopList(List<Fcst> list, List<Fcst> updateList) {
  var startDate = '';
  for (Fcst fcst in list) {
    if (startDate == fcst.fcstDate) {
      if (updateList.isNotEmpty) {
        int value1 = int.parse(updateList.last.fcstValue ?? '0');
        int value2 = int.parse(fcst.fcstValue ?? '0');
        updateList.last.fcstValue = max(value1, value2).toString();
      }
    } else {
      updateList.add(fcst);
    }
    startDate = fcst.fcstDate ?? '';
  }
}

void updateSkyList(List<Fcst> list, List<Fcst> updateList) {
  var startDate = '';
  List<String> values = [];
  for (Fcst fcst in list) {
    if (startDate == fcst.fcstDate) {
      if (updateList.isNotEmpty) {
        values.add(fcst.fcstValue ?? '');
      }
    } else {
      if (updateList.isNotEmpty) {
        String value = '3';
        int value1 = values.where((element) => element == '1').length;
        int value3 = values.where((element) => element == '3').length;
        int value4 = values.where((element) => element == '4').length;
        //print('$value1, $value3, $value4');
        if (value1 > value3 && value1 > value4) {
          value = '1';
        }
        if (value4 > value3 && value4 > value1) {
          value = '4';
        }
        Fcst updateFcst = updateList[updateList.length - 1];
        updateFcst.fcstValue =
            fcst.weatherCategory?.codeValues?[int.parse(value)];
        values.clear();
      }
      updateList.add(fcst);
    }
    startDate = fcst.fcstDate ?? '';
  }
}

Fcst _setFcst(Fcst last, value) {
  Fcst fcst = Fcst();
  fcst.category = last.category;
  fcst.weatherCategory = last.weatherCategory;
  fcst.baseTime = last.baseTime;
  fcst.baseDate = last.baseDate;
  fcst.nx = last.nx;
  fcst.ny = last.ny;
  fcst.fcstTime = last.fcstTime;
  final date = DateTime.parse(last.fcstDate ?? '');
  final newDate = DateTime(date.year, date.month, date.day + 1)
      .toString()
      .replaceAll(RegExp("[^0-9\\s]"), "")
      .replaceAll(" ", "");
  fcst.fcstDate = newDate.substring(0, 8);
  fcst.fcstValue = '$value';
  return fcst;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sweater',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      themeMode: ThemeMode.system,
      home: const Scaffold(),
    );
  }
}
