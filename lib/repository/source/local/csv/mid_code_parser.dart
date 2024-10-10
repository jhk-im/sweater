import 'package:csv/csv.dart';
import 'package:sweater/repository/source/local/csv/csv_parser.dart';
import 'package:sweater/repository/source/mapper/weather_mapper.dart';
import 'package:sweater/repository/source/remote/dto/mid_code_dto.dart';
import 'package:sweater/repository/source/remote/model/mid_code.dart';

class MidCodeParser implements CsvParser<MidCode> {
  @override
  Future<List<MidCode>> parse(String csvString) async {
    List<List<dynamic>> csvValues =
        const CsvToListConverter().convert(csvString);
    csvValues.removeAt(0);
    return csvValues.map((e) {
      return MidCodeDto(
        city: e[0] ?? '',
        code: e[1] ?? 0,
      ).toMidCode();
    }).toList();
  }
}
