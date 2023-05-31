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
import 'package:sweater/repository/source/remote/weather_api.dart';
import 'package:sweater/repository/weather_repository.dart';
import 'package:sweater/utils/color_schemes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sweater/view/screen/weather_main_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sweater/viewmodel/weather_main_view_model.dart';

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
  final repository = WeatherRepository(WeatherApi(), WeatherDao());
  GetIt.instance.registerSingleton<WeatherRepository>(repository);

  // provider
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherMainViewModel(
            repository,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      home: const WeatherMainScreen(),
    );
  }
}
