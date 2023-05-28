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

    List<Fcst> yesterdayTMN = [];
    List<Fcst> yesterdayTMX = [];

    List<Fcst> tomorrowTMN = [];
    List<Fcst> tomorrowTMX = [];

    // 어제 단기 예보
    // 어제 - 오늘 : 최저 최고
    // 0200
    var yesterdayVilageFcst = await repository.getVilageFast(false, longitude, latitude);
    yesterdayVilageFcst.when(success: (info) {
      print('Yesterday Fcst list length -> ${info.length}');

      yesterdayTMN = info.where((element) => element.category! == 'TMN').toList();
      yesterdayTMX = info.where((element) => element.category! == 'TMX').toList();

      print(yesterdayTMN);
      print(yesterdayTMX);

    }, error: (e) {
      print(e);
    });

    // 오늘 단기 예보
    // 오늘 - 내일 : 최저 최고 기온
    var tomorrowVilageFcst = await repository.getVilageFast(true, longitude, latitude);
    tomorrowVilageFcst.when(success: (info) {
      print('Tomorrow Fcst list length -> ${info.length}');
      tomorrowTMN = info.where((element) => element.category! == 'TMN').toList();
      tomorrowTMX = info.where((element) => element.category! == 'TMX').toList();
      print(tomorrowTMN);
      print(tomorrowTMX);
    }, error: (e) {
      print(e);
    });

    // 관측소 정보 -> 자외선 치수
    String depth1 = adr.region1depthName ?? '';
    String depth2 = adr.region2depthName ?? '';
    var observatory =
        await repository.getObservatoryWithAddress(depth1, depth2);
    observatory.when(success: (info) async {
      print(info);
      // 자외선 지수
      var uvRays = await repository.getUVRays('${info.code}');
      uvRays.when(success: (info) {
        print(info);
      }, error: (e) {
        print(e);
      });
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
        print(info);
      }, error: (e) {
        print(e);
      });

      // 중기 육상 예보
      var midLandFcst = await repository.getMidLandFcst(depth1, depth2);
      midLandFcst.when(success: (info) {
        print(info);
      }, error: (e) {
        print(e);
      });
    }, error: (e) {
      print(e);
    });

    // 미세먼지
    String query =
    adr.region2depthName != null ? adr.region2depthName! : '';
    var dnsty = await repository.getMesureDnsty(false, query);
    dnsty.when(success: (info) {
      print(info);
    }, error: (e) {
      print(e);
    });

    // 출몰
    var riseSet = await repository.getRiseSetWithCoordinate(longitude, latitude);
    riseSet.when(success: (info) {
      print(info);
    }, error: (e) {
      print(e);
    });
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
