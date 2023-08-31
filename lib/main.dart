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

import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';
import 'package:workmanager/workmanager.dart';

import 'dart:async';
import 'dart:math';



/// Called when Doing Background Work initiated from Widget
@pragma("vm:entry-point")
void backgroundCallback(Uri? data) async {
  print(data);

  if (data?.host == 'titleclicked') {
    final greetings = [
      'Hello',
      'Hallo',
      'Bonjour',
      'Hola',
      'Ciao',
      '哈洛',
      '안녕하세요',
      'xin chào'
    ];
    final selectedGreeting = greetings[Random().nextInt(greetings.length)];

    await HomeWidget.saveWidgetData<String>('title', selectedGreeting);
    await HomeWidget.updateWidget(
        name: 'HomeWidgetExampleProvider', iOSName: 'HomeWidgetExample');
  }
}

/// Used for Background Updates using Workmanager Plugin
@pragma("vm:entry-point")
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    final now = DateTime.now();
    return Future.wait<bool?>([
      HomeWidget.saveWidgetData(
        'title',
        'Updated from Background',
      ),
      HomeWidget.saveWidgetData(
        'message',
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}',
      ),
      HomeWidget.updateWidget(
        name: 'HomeWidgetExampleProvider',
        iOSName: 'HomeWidgetExample',
      ),
    ]).then((value) {
      return !value.contains(false);
    });
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(callbackDispatcher, isInDebugMode: kDebugMode);

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
