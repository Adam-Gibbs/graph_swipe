import 'package:graph_swipe/graphs/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_pair.g.dart';

@JsonSerializable()
class DataPair extends Data {
  late List<double> pair;

  DataPair(List<double> pair) : super((pair[0] + pair[1]) / 2) {
    this.pair = pair;
  }

  factory DataPair.fromJson(Map<String, dynamic> json) =>
      _$DataPairFromJson(json);
  Map<String, dynamic> toJson() => _$DataPairToJson(this);

  List<double> getvalues() {
    return pair;
  }

  @override
  String toString() {
    return "[" + pair[0].toString() + ", " + pair[1].toString() + "]";
  }
}
