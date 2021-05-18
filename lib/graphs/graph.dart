import 'package:graph_swipe/graphs/data/sets/data_set.dart';
import 'package:graph_swipe/graphs/options/options.dart';
import 'dart:math';
import 'package:json_annotation/json_annotation.dart';

part 'graph.g.dart';

@JsonSerializable()
class Graph {
  Random rand = Random();
  late List<DataSet> dataSets;
  late Options options;
  late String type;
  late List<String> xLabels;

  Graph(String type, List<String> xLabels) {
    this.type = type;
    this.xLabels = xLabels;
  }

  factory Graph.fromJson(Map<String, dynamic> json) => _$GraphFromJson(json);
  Map<String, dynamic> toJson() => _$GraphToJson(this);

  Set<int> getHalfDataSets() {
    Set<int> uniqueIndexs = {};
    for (int i = 0; i < dataSets.length ~/ 2; i++) {
      int value = rand.nextInt(dataSets.length - 1);
      while (uniqueIndexs.contains(value)) {
        value = rand.nextInt(dataSets.length - 1);
      }
      uniqueIndexs.add(value);
    }
    return uniqueIndexs;
  }

  Set<int> getRandomDataSets(double chance) {
    Set<int> uniqueIndexs = {};
    for (int i = 0; i < dataSets.length; i++) {
      if (rand.nextDouble() < chance) {
        uniqueIndexs.add(i);
      }
    }
    return uniqueIndexs;
  }

  void setOptions(Options options) {
    this.options = options;
  }

  Graph setDefaultOptions(title, scales) {
    this.options = new Options(title, scales);
    return this;
  }

  void setRandomOptions(title, scales) {
    this.options = new Options(title, scales);
  }

  void addDataSets(List<DataSet> dataSets) {
    this.dataSets = dataSets;
  }

  void addYAxisRelation(String label) {}

  String showType() {
    return "type: '" + this.type + "',";
  }

  String _labelsToString() {
    String finString = "";
    this
        .xLabels
        .forEach((element) => {finString += ("'" + element.toString() + "',")});
    return finString;
  }

  String showLabels() {
    return "labels: [" + _labelsToString() + "],";
  }

  String _dataSetsToString() {
    String finString = "";
    this.dataSets.forEach((element) => {finString += element.showDataSet()});
    return finString;
  }

  String showDataSets() {
    return "datasets: [" + _dataSetsToString() + "],";
  }

  String showData() {
    return "data: {" + showLabels() + showDataSets() + "},";
  }

  String showGraph() {
    return "{" + showType() + showData() + options.showOptions() + "}";
  }
}
