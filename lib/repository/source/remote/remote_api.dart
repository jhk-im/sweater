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

  // 측정소별 실시간 대기오염 측정정보 조회
  Future<http.Response> getMsrstnAcctoRltmMesureDnsty(String sName) async {
    var url = Uri.https(baseUrl, '/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty', {
      'returnType': 'JSON',
      'serviceKey': serviceKey ?? '',
      'numOfRows': '1',
      'pageNo': '1',
      'dataTerm': 'DAILY',
      'stationName': sName,
      'ver': '1.1',
    });
    return await http.get(url);
  }

  // 좌표로 출몰시간 조회 (XML)
  Future<http.Response> getRiseSetInfoWithCoordinate(String locdate,double longitude, double latitude) async {
    var url =
    Uri.https(baseUrl, '/B090041/openapi/service/RiseSetInfoService/getLCRiseSetInfo', {
      'serviceKey': serviceKey ?? '',
      'locdate': locdate,
      'longitude': '$longitude',
      'latitude': '$latitude',
      'dnYn': 'Y',
    });
    return await http.get(url);
  }

  // 자외선 지수 조회
  Future<http.Response> getUVRays(String time, String areaNo) async {
    var url =
    Uri.https(baseUrl, '/1360000/LivingWthrIdxServiceV4/getUVIdxV4', {
      'serviceKey': serviceKey ?? '',
      'dataType': 'JSON',
      'numOfRows': '10',
      'pageNo': '1',
      'time': time,
      'areaNo': areaNo,
    });
    return await http.get(url);
  }

  // 중기 기온 예보
  Future<http.Response> getMidTa(String tmFc, String regId) async {
    var url =
    Uri.https(baseUrl, '/1360000/MidFcstInfoService/getMidTa', {
      'serviceKey': serviceKey ?? '',
      'dataType': 'JSON',
      'numOfRows': '10',
      'pageNo': '1',
      'tmFc': tmFc,
      'regId': regId,
    });
    return await http.get(url);
  }

  // 중기 육상 예보
  Future<http.Response> getMidLandFcst(String tmFc, String regId) async {
    var url =
    Uri.https(baseUrl, '1360000/MidFcstInfoService/getMidLandFcst', {
      'serviceKey': serviceKey ?? '',
      'dataType': 'JSON',
      'numOfRows': '10',
      'pageNo': '1',
      'tmFc': tmFc,
      'regId': regId,
    });
    return await http.get(url);
  }

  // 단기 예보
  Future<http.Response> getVilageFcst(String date, String time, int x, int y) async {
    var url =
    Uri.https(baseUrl, '/1360000/VilageFcstInfoService_2.0/getVilageFcst', {
      'dataType': 'JSON',
      'serviceKey': serviceKey ?? '',
      'numOfRows': '60',
      'pageNo': '1',
      'base_date': date,
      'base_time': time,
      'nx': '$x',
      'ny': '$y',
    });
    return await http.get(url);
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
  Future<http.Response> getUltraStrFcst(String date, String time, int x, int y) async {
    var url =
    Uri.https(baseUrl, '/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst', {
      'dataType': 'JSON',
      'serviceKey': serviceKey ?? '',
      'numOfRows': '100',
      'pageNo': '1',
      'base_date': date,
      'base_time': time,
      'nx': '$x',
      'ny': '$y',
    });
    return await http.get(url);
  }
}