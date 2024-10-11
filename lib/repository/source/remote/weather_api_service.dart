import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sweater/repository/source/remote/model/fine_dust_response.dart';
import 'package:sweater/repository/source/remote/model/mid_term_land_response.dart';
import 'package:sweater/repository/source/remote/model/mid_term_temperature_response.dart';
import 'package:sweater/repository/source/remote/model/ultraviolet_response.dart';
import 'package:sweater/repository/source/remote/model/weather_response.dart';

part 'weather_api_service.g.dart';

@RestApi()
abstract class WeatherApiService {
  factory WeatherApiService(Dio dio, {required String baseUrl}) {
    return _WeatherApiService(dio, baseUrl: baseUrl);
  }

  @GET("/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst")
  Future<WeatherResponse> getUltraShortTermLive(
      @Query('numOfRows') String numOfRows,
      @Query('pageNo') String pageNo,
      @Query('base_date') String date,
      @Query('base_time') String time,
      @Query('nx') int x,
      @Query('ny') int y);

  @GET("/1360000/VilageFcstInfoService_2.0/getVilageFcst")
  Future<WeatherResponse> getShortTerm(
      @Query('numOfRows') String numOfRows,
      @Query('pageNo') String pageNo,
      @Query('base_date') String date,
      @Query('base_time') String time,
      @Query('nx') int x,
      @Query('ny') int y);

  @GET("/1360000/MidFcstInfoService/getMidLandFcst")
  Future<MidTermLandResponse> getMidTermLand(
      @Query('numOfRows') String numOfRows,
      @Query('pageNo') String pageNo,
      @Query('tmFc') String tmFc,
      @Query('regId') String regId);

  @GET("/1360000/MidFcstInfoService/getMidTa")
  Future<MidTermTemperatureResponse> getMidTermTemperature(
      @Query('numOfRows') String numOfRows,
      @Query('pageNo') String pageNo,
      @Query('tmFc') String tmFc,
      @Query('regId') String regId);

  @GET("/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty")
  Future<FineDustResponse> getFineDust(
      @Query('returnType') String returnType,
      @Query('numOfRows') String numOfRows,
      @Query('pageNo') String pageNo,
      @Query('dataTerm') String dataTerm,
      @Query('stationName') String stationName,
      @Query('ver') String version);

  @GET("/B090041/openapi/service/RiseSetInfoService/getLCRiseSetInfo")
  Future<String> getSunRise(
      @Query('locdate') String locdate,
      @Query('longitude') double longitude,
      @Query('latitude') double latitude,
      @Query('dnYn') String stationName);

  @GET("/1360000/LivingWthrIdxServiceV4/getUVIdxV4")
  Future<UltravioletResponse> getUltraviolet(
      @Query('numOfRows') String numOfRows,
      @Query('pageNo') String pageNo,
      @Query('time') String time,
      @Query('areaNo') String areaNo);
}
