import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sweater/repository/source/remote/model/address_response.dart';
import 'package:sweater/repository/source/remote/model/fine_dust.dart';
import 'package:sweater/repository/source/remote/model/short_term.dart';
import 'package:sweater/repository/source/remote/model/mid_code.dart';
import 'package:sweater/repository/source/remote/model/observatory.dart';
import 'package:sweater/repository/source/remote/model/sun_rise_set.dart';
import 'package:sweater/repository/source/remote/model/weather_response.dart';
import 'package:sweater/repository/source/remote/model/ultraviolet.dart';

part 'weather_main_state.freezed.dart';
part 'weather_main_state.g.dart';

@freezed
class WeatherMainState with _$WeatherMainState {
  const factory WeatherMainState({
    AddressResult? address,
    Observatory? observatory,
    MidCode? midCode,
    SunRiseSet? riseSet,
    UVRays? uvRays,
    @Default([]) List<WeatherItem> ultraShortTerm,
    @Default([]) List<ShortTerm> yesterdayTmpList,
    @Default([]) List<ShortTerm> yesterdayPopList,
    @Default([]) List<ShortTerm> yesterdaySkyList,
    @Default([]) List<ShortTerm> todayTmpList,
    @Default([]) List<ShortTerm> todayPopList,
    @Default([]) List<ShortTerm> todaySkyList,
    @Default([]) List<ShortTerm> tomorrowTmpList,
    @Default([]) List<ShortTerm> tomorrowPopList,
    @Default([]) List<ShortTerm> tomorrowSkyList,
    @Default([]) List<ShortTerm> tmnList,
    @Default([]) List<ShortTerm> tmxList,
    @Default([]) List<ShortTerm> popList,
    @Default([]) List<ShortTerm> skyList,
    @Default([]) List<FineDust> dnstyList,
    @Default(false) bool isLoading,
    @Default(false) bool isRefresh,
    @Default(0) int errorNum,
  }) = _WeatherMainState;

  factory WeatherMainState.fromJson(Map<String, Object?> json) =>
      _$WeatherMainStateFromJson(json);
}
