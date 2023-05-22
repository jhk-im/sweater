import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sweater/model/fcst.dart';
import 'package:sweater/model/ncst.dart';
import 'package:sweater/repository/source/local/address_entity.dart';
import 'package:sweater/repository/source/local/dnsty_entity.dart';
import 'package:sweater/repository/source/local/fcst_entity.dart';
import 'package:sweater/repository/source/local/ncst_entity.dart';
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
  final repository = WeatherRepository(RemoteApi(), WeatherDao());
  runApp(const MyApp());

  // 현재 좌표 주소
  var address = await repository.getAddressWithCoordinate();
  address.when(success: (adr) async {
    print(adr);
  }, error: (e) {
    print(e);
  });

  // 초단기 실황
  var ultraNcst = await repository.getUltraStrNcst();
  ultraNcst.when(success: (info) {
    for (Ncst ncst in info) {
      print(ncst);
    }
  }, error: (e) {
    print(e);
  });

  // 예보 (6시간)
  var ultraFcst = await repository.getUltraStrFcst();
  ultraFcst.when(success: (info) {
    for (Fcst fcst in info) {
      print(fcst);
    }
  }, error: (e) {
    print(e);
  });

  // 예보 (4일  80시간)
  var vilageFcst = await repository.getVilageFast(1);
  vilageFcst.when(success: (info) {
    for (Fcst fcst in info) {
      print(fcst);
    }
  }, error: (e) {
    print(e);
  });


  // 미세먼지
  var dnsty = await repository.getMesureDnsty();
  dnsty.when(success: (info) {
    print(info);
  }, error: (e) {
    print(e);
  });

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
