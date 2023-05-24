import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sweater/repository/source/local/entity/rise_set_entity.dart';
import 'package:sweater/repository/source/remote/model/fcst.dart';
import 'package:sweater/repository/source/remote/model/ncst.dart';
import 'package:sweater/repository/source/local/entity/address_entity.dart';
import 'package:sweater/repository/source/local/entity/dnsty_entity.dart';
import 'package:sweater/repository/source/local/entity/fcst_entity.dart';
import 'package:sweater/repository/source/local/entity/ncst_entity.dart';
import 'package:sweater/repository/source/local/weather_dao.dart';
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
  final repository = WeatherRepository(RemoteApi(), WeatherDao());
  runApp(const MyApp());

  // 현재 좌표 주소
  var address = await repository.getAddressWithCoordinate();
  address.when(success: (adr) async {
    print(adr);
  }, error: (e) {
    print(e);
  });

  // 출몰
  var riseSet = await repository.getRiseSetWithCoordinate();
  riseSet.when(success: (info) {
    print(info);
  }, error: (e) {
    print(e);
  });

  // 미세먼지
  var dnsty = await repository.getMesureDnsty(false);
  dnsty.when(success: (info) {
    print(info);
  }, error: (e) {
    print(e);
  });

  // 초단기 실황 * 오늘 정보 업데이트
  /*var ultraNcst = await repository.getUltraStrNcst(false);
  ultraNcst.when(success: (info) {
    for (Ncst ncst in info) {
      print(ncst);
    }
  }, error: (e) {
    print(e);
  });*/

  // 예보 (6시간) * 제거
  /*var ultraFcst = await repository.getUltraStrFcst(false);
  ultraFcst.when(success: (info) {
    for (Fcst fcst in info) {
      print(fcst);
    }
  }, error: (e) {
    print(e);
  });*/

  // 예보 (4일  80시간) * 오늘 내일정보
  // 3시간 단위 업데이트
  // 강수확률 평균, 하늘상태, 최고 최저 기온
  /*var vilageFcst = await repository.getVilageFast(false);
  vilageFcst.when(success: (info) {
    for (Fcst fcst in info) {
      print(fcst);
    }
  }, error: (e) {
    print(e);
  });*/

  // 중기 예보 * 3일후 - 10일 후 까지
  // 강수확률 평균, 하늘상태, 최고 최저 기온

  // 생활지수
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
