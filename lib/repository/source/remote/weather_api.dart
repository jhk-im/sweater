import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherApi {
  static const baseUrl = "apis.data.go.kr";
  static final serviceKey = dotenv.env['SERVICE_KEY'];

  // 초단기 실황
  Future<http.Response> getUltraStrNcst(String date, String time, int x, int y) async {
    var url =
    Uri.https(baseUrl, '/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst', {
      'dataType': 'JSON',
      'serviceKey': serviceKey ?? '',
      'numOfRows': '${10}',
      'pageNo': '${1}',
      'base_date': date,
      'base_time': time,
      'nx': '$x',
      'ny': '$y',
    });
    return await http.get(url);
  }

  // 초단기 예보
  Future<http.Response> getUltraStrFcst(String date, String time, int x, int y, int pageNo) async {
    var url =
    Uri.https(baseUrl, '/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst', {
      'dataType': 'JSON',
      'serviceKey': serviceKey ?? '',
      'numOfRows': 10,
      'pageNo': pageNo,
      'base_date': date,
      'base_time': time,
      'nx': x,
      'ny': y,
    });
    return await http.get(url);
  }

  // 단기 예보
  Future<http.Response> getVilageFcst(String date, String time, int x, int y, int pageNo) async {
    var url =
    Uri.https(baseUrl, '/1360000/VilageFcstInfoService_2.0/getVilageFcst', {
      'dataType': 'JSON',
      'serviceKey': serviceKey ?? '',
      'numOfRows': 10,
      'pageNo': pageNo,
      'base_date': date,
      'base_time': time,
      'nx': x,
      'ny': y,
    });
    return await http.get(url);
  }
}