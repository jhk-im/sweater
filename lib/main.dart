import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
  final repository = WeatherRepository(RemoteApi(), WeatherDao());
  runApp(const MyApp());

  var list = await repository.getUltraStrNcst(false);
  list.when(success: (info) {
    for (var e in info) {
      print(e.toString());
    }
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
