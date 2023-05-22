import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RemoteApi {
  static const baseUrl = "apis.data.go.kr";
  static final serviceKey = dotenv.env['SERVICE_KEY'];
  static const kakaoUrl = "dapi.kakao.com";
  static final apiKey = dotenv.env['API_KEY'];

  // 좌표로 주소 검색
  Future<http.Response> getAddressWithCoordinate(double x, double y) async {
    var url =
    Uri.https(kakaoUrl, '/v2/local/geo/coord2regioncode.json', {
      'x': '$x',
      'y': '$y',
    });
    var headers = <String, String> {
      'Authorization': 'KakaoAK $apiKey',
    };
    return await http.get(url, headers: headers);
  }

  // 초단기 실황
  Future<http.Response> getUltraStrNcst(String date, String time, int x, int y) async {
    var url =
    Uri.https(baseUrl, '/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst', {
      'dataType': 'JSON',
      'serviceKey': serviceKey ?? '',
      'numOfRows': '10',
      'pageNo': '1',
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
      'numOfRows': '100',
      'pageNo': '$pageNo',
      'base_date': date,
      'base_time': time,
      'nx': '$x',
      'ny': '$y',
    });
    return await http.get(url);
  }

  // 단기 예보
  Future<http.Response> getVilageFcst(String date, String time, int x, int y, int pageNo) async {
    var url =
    Uri.https(baseUrl, '/1360000/VilageFcstInfoService_2.0/getVilageFcst', {
      'dataType': 'JSON',
      'serviceKey': serviceKey ?? '',
      'numOfRows': '1000',
      'pageNo': '$pageNo',
      'base_date': date,
      'base_time': time,
      'nx': '$x',
      'ny': '$y',
    });
    return await http.get(url);
  }

  // 측정소별 실시간 대기오염 측정정보 조회
  Future<http.Response> getMsrstnAcctoRltmMesureDnsty(String sName) async {
    var url = Uri.https(baseUrl, '/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty', {
      'returnType': 'JSON',
      'serviceKey': serviceKey ?? '',
      'numOfRows': '1',
      'pageNo': '1',
      'dataTerm': 'DAILY',
      'stationName': sName,
    });
    return await http.get(url);
  }
}