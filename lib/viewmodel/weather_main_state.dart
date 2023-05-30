import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sweater/repository/source/remote/model/address.dart';
import 'package:sweater/repository/source/remote/model/dnsty.dart';
import 'package:sweater/repository/source/remote/model/fcst.dart';
import 'package:sweater/repository/source/remote/model/mid_code.dart';
import 'package:sweater/repository/source/remote/model/ncst.dart';
import 'package:sweater/repository/source/remote/model/observatory.dart';
import 'package:sweater/repository/source/remote/model/rise_set.dart';
import 'package:sweater/repository/source/remote/model/uv_rays.dart';

part 'weather_main_state.freezed.dart';
part 'weather_main_state.g.dart';

@freezed
class WeatherMainState with _$WeatherMainState {
  const factory WeatherMainState({
    Address? address,
    Observatory? observatory,
    MidCode? midCode,
    RiseSet? riseSet,
    UVRays? uvRays,
    @Default([]) List<Ncst> ncstList,
    @Default([]) List<Fcst> tmnList,
    @Default([]) List<Fcst> tmxList,
    @Default([]) List<Fcst> popList,
    @Default([]) List<Fcst> skyList,
    @Default([]) List<Dnsty> dnstyList,
    @Default(false) bool isLoading,
    @Default(false) bool isRefresh,
    @Default(0) int errorNum,
  }) = _WeatherMainState;

  factory WeatherMainState.fromJson(Map<String, Object?> json) =>
      _$WeatherMainStateFromJson(json);
}
