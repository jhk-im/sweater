import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sweater/repository/source/remote/model/address_response.dart';

part 'address_api_service.g.dart';

@RestApi()
abstract class AddressApiService {
  factory AddressApiService(Dio dio, {required String baseUrl}) {
    return _AddressApiService(dio, baseUrl: baseUrl);
  }

  @GET("/v2/local/geo/coord2regioncode.json")
  Future<AddressResponse> getAddressWithCoordinate(
      @Query('x') double x,
      @Query('y') double y,);
}