import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AirPollutionApi {
  static const baseUrl = "apis.data.go.kr/B552584/ArpltnInforInqireSvc/";
  static final serviceKey = dotenv.env['SERVICE_KEY'];

  // 측정소별 실시간 대기오염 측정정보 조회
  Future<http.Response> getMsrstnAcctoRltmMesureDnsty(String sName) async {
    var url = Uri.https(baseUrl, 'getMsrstnAcctoRltmMesureDnsty', {
      'returnType': 'JSON',
      'serviceKey': serviceKey ?? '',
      'numOfRows': 1,
      'pageNo': 1,
      'dataTerm': 'DAILY',
      'stationName': sName,
    });
    return await http.get(url);
  }
}