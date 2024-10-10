import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sweater/repository/source/local/entity/address_entity.dart';
import 'package:sweater/repository/source/local/entity/ultra_short_term_entity.dart';
import 'package:sweater/repository/source/local/weather_dao.dart';
import 'package:sweater/repository/source/remote/address_api_service.dart';
import 'package:sweater/repository/source/remote/weather_api_service.dart';
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
  final kakaoApiKey = dotenv.env['KAKAO_API_KEY'] ?? '';
  final weatherServiceKey = dotenv.env['WEATHER_SERVICE_KEY'];

  // hive
  await Hive.initFlutter();
  Hive.registerAdapter(AddressEntityAdapter());
  Hive.registerAdapter(UltraShortTermEntityAdapter());

  // repository
  final addressDio = Dio();
  addressDio.options.headers['Authorization'] = 'KakaoAK $kakaoApiKey';
  final addressApi =
  AddressApiService(addressDio, baseUrl: "https://dapi.kakao.com");
  final weatherDio = Dio();
  weatherDio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      options.queryParameters['serviceKey'] = weatherServiceKey ?? '';
      options.queryParameters['dataType'] = 'JSON';
      return handler.next(options);
    }
  ));
  weatherDio.interceptors.add(LogInterceptor(
    responseBody: true,       // 응답 바디 로그 출력
    error: true,              // 오류 로그 출력
    logPrint: (obj) => print(obj),  // 로그 출력 방식 설정 (콘솔 출력)
  ));
  final weatherApi =
  WeatherApiService(weatherDio, baseUrl: "https://apis.data.go.kr");
  final repository = WeatherRepository(addressApi, weatherApi, WeatherDao());
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
