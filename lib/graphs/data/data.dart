import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  late double value;

  Data(double value) {
    this.value = value;
  }

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);

  double getvalue() {
    return value;
  }

  void set(double inValue) {
    this.value = inValue;
  }

  @override
  String toString() {
    return value.toString();
  }
}
