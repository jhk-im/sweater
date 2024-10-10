import 'package:csv/csv.dart';
import 'package:sweater/repository/source/csv/csv_parser.dart';
import 'package:sweater/repository/source/mapper/weather_mapper.dart';
import 'package:sweater/repository/source/remote/dto/observatory_dto.dart';
import 'package:sweater/repository/source/remote/model/observatory.dart';

class ObservatoryParser implements CsvParser<Observatory> {
  @override
  Future<List<Observatory>> parse(String csvString) async {
    List<List<dynamic>> csvValues = const CsvToListConverter().convert(csvString);
    csvValues.removeAt(0);
    return csvValues.map((e) {
      return ObservatoryDto(
      code: e[1] ?? 0,
      depth1: e[2] ?? '',
      depth2: e[3] ?? '',
      depth3: e[4] ?? '',
      gridX: e[5] ?? 0,
      gridY: e[6] ?? 0,
      lonHour: e[7] ?? 0,
      lonMin: e[8] ?? 0,
      lonSec: e[9] ?? 0.0,
      latHour: e[10] ?? 0,
      latMin: e[11] ?? 0,
      latSec: e[12] ?? 0.0,
      longitude: e[13] ?? 0.0,
      latitude: e[14] ?? 0.0,
      ).toObservatory();
    }).toList();
  }
}
