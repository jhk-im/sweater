import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sweater/repository/source/remote/model/address_response.dart';
import 'package:sweater/repository/source/remote/model/fine_dust_response.dart';
import 'package:sweater/repository/source/remote/model/mid_code.dart';
import 'package:sweater/repository/source/remote/model/observatory.dart';
import 'package:sweater/repository/source/remote/model/sun_rise_response.dart';
import 'package:sweater/repository/source/remote/model/ultraviolet_response.dart';
import 'package:sweater/repository/source/remote/model/weather_response.dart';

part 'weather_main_state.freezed.dart';
part 'weather_main_state.g.dart';

@freezed
class WeatherMainState with _$WeatherMainState {
  const factory WeatherMainState({
    AddressResult? address,
    Observatory? observatory,
    MidCode? midCode,
    SunRise? riseSet,
    Ultraviolet? ultraviolet,
    @Default([]) List<WeatherItem> ultraShortTerm,
    @Default([]) List<WeatherItem> yesterdayTmpList,
    @Default([]) List<WeatherItem> yesterdayPopList,
    @Default([]) List<WeatherItem> yesterdaySkyList,
    @Default([]) List<WeatherItem> todayTmpList,
    @Default([]) List<WeatherItem> todayPopList,
    @Default([]) List<WeatherItem> todaySkyList,
    @Default([]) List<WeatherItem> tomorrowTmpList,
    @Default([]) List<WeatherItem> tomorrowPopList,
    @Default([]) List<WeatherItem> tomorrowSkyList,
    @Default([]) List<WeatherItem> tmnList,
    @Default([]) List<WeatherItem> tmxList,
    @Default([]) List<WeatherItem> popList,
    @Default([]) List<WeatherItem> skyList,
    @Default([]) List<FineDust> fineDustList,
    @Default(false) bool isLoading,
    @Default(false) bool isRefresh,
    @Default(0) int errorNum,
  }) = _WeatherMainState;

  factory WeatherMainState.fromJson(Map<String, Object?> json) =>
      _$WeatherMainStateFromJson(json);
}
