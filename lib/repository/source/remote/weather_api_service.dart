import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sweater/repository/source/remote/model/address_response.dart';
import 'package:sweater/repository/source/remote/model/ultra_short_term_response.dart';

part 'weather_api_service.g.dart';

@RestApi()
abstract class WeatherApiService {
  factory WeatherApiService(Dio dio, {required String baseUrl}) {
    return _WeatherApiService(dio, baseUrl: baseUrl);
  }

  @GET("/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst")
  Future<UltraShortTermResponse> getUltraShortTerm(
      @Query('numOfRows') String numOfRows,
      @Query('pageNo') String pageNo,
      @Query('base_date') String date,
      @Query('base_time') String time,
      @Query('nx') int x,
      @Query('ny') int y);

  @GET("/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst")
  Future<UltraShortTermResponse> getShortTerm(
      @Query('numOfRows') String numOfRows,
      @Query('pageNo') String pageNo,
      @Query('base_date') String date,
      @Query('base_time') String time,
      @Query('nx') int x,
      @Query('ny') int y);
}