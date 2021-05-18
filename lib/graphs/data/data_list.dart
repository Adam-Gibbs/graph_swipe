import 'package:graph_swipe/graphs/data/data.dart';
import 'package:graph_swipe/graphs/data/data_pair.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_list.g.dart';

@JsonSerializable()
class DataList {
  List<Data> data = [];

  List<Data> getData() {
    return data;
  }

  DataList();

  factory DataList.fromJson(Map<String, dynamic> json) =>
      _$DataListFromJson(json);
  Map<String, dynamic> toJson() => _$DataListToJson(this);

  void add(double value) {
    data.add(new Data(value));
  }

  void addPair(List<double> valuePair) {
    data.add(new DataPair(valuePair));
  }

  @override
  String toString() {
    return data.toString();
  }

  bool hasPairs() {
    return (data.first is DataPair);
  }
}
