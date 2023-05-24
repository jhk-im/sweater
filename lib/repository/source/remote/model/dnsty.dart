class Dnsty {
  String? so2Grade;
  String? coFlag;
  String? khaiValue;
  String? so2Value;
  String? coValue;
  String? pm10Flag;
  String? pm10Value;
  String? pm10Value24;
  String? pm25Value;
  String? pm25Value24;
  String? o3Grade;
  String? khaiGrade;
  String? no2Flag;
  String? no2Grade;
  String? o3Flag;
  String? so2Flag;
  String? dataTime;
  String? coGrade;
  String? no2Value;
  String? pm10Grade;
  String? o3Value;

  Dnsty(
      {this.so2Grade,
        this.coFlag,
        this.khaiValue,
        this.so2Value,
        this.coValue,
        this.pm10Flag,
        this.pm10Value,
        this.pm10Value24,
        this.pm25Value,
        this.pm25Value24,
        this.o3Grade,
        this.khaiGrade,
        this.no2Flag,
        this.no2Grade,
        this.o3Flag,
        this.so2Flag,
        this.dataTime,
        this.coGrade,
        this.no2Value,
        this.pm10Grade,
        this.o3Value});

  Dnsty.fromJson(Map<String, dynamic> json) {
    so2Grade = json['so2Grade'];
    coFlag = json['coFlag'];
    khaiValue = json['khaiValue'];
    so2Value = json['so2Value'];
    coValue = json['coValue'];
    pm10Flag = json['pm10Flag'];
    pm10Value = json['pm10Value'];
    pm10Value24 = json['pm10Value24'];
    pm25Value = json['pm25Value'];
    pm25Value24 = json['pm25Value24'];
    o3Grade = json['o3Grade'];
    khaiGrade = json['khaiGrade'];
    no2Flag = json['no2Flag'];
    no2Grade = json['no2Grade'];
    o3Flag = json['o3Flag'];
    so2Flag = json['so2Flag'];
    dataTime = json['dataTime'];
    coGrade = json['coGrade'];
    no2Value = json['no2Value'];
    pm10Grade = json['pm10Grade'];
    o3Value = json['o3Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['so2Grade'] = so2Grade;
    data['coFlag'] = coFlag;
    data['khaiValue'] = khaiValue;
    data['so2Value'] = so2Value;
    data['coValue'] = coValue;
    data['pm10Flag'] = pm10Flag;
    data['pm10Value'] = pm10Value;
    data['pm10Value24'] = pm10Value24;
    data['pm25Value'] = pm25Value;
    data['pm25Value24'] = pm25Value24;
    data['o3Grade'] = o3Grade;
    data['khaiGrade'] = khaiGrade;
    data['no2Flag'] = no2Flag;
    data['no2Grade'] = no2Grade;
    data['o3Flag'] = o3Flag;
    data['so2Flag'] = so2Flag;
    data['dataTime'] = dataTime;
    data['coGrade'] = coGrade;
    data['no2Value'] = no2Value;
    data['pm10Grade'] = pm10Grade;
    data['o3Value'] = o3Value;
    return data;
  }

  @override
  String toString() {
    return 'Dnsty: { 미세먼지: $pm10Value, 미세먼지24시간: $pm10Value24, 초미세먼지: $pm25Value, 초미세먼지24시간: $pm25Value24, dateTime: $dataTime }';
  }
}