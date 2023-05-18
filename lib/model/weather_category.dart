class WeatherCategory {
  String? name;
  String? unit;
  List<String>? codeValues;

  WeatherCategory({this.name, this.unit, this.codeValues});

  WeatherCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    unit = json['unit'];
    codeValues = json['code_values'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['unit'] = unit;
    data['code_values'] = codeValues;
    return data;
  }

  @override
  String toString() {
    return 'WeatherCategory: name: $name, unit: $unit, codeValues: $codeValues';
  }
}