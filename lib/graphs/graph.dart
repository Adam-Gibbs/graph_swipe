import 'package:graph_swipe/graphs/data/sets/data_set.dart';
import 'package:graph_swipe/graphs/options/options.dart';
import 'dart:math';

abstract class Graph {
  Random rand = Random();
  abstract List<DataSet> dataSets;
  abstract Options options;
  abstract String type;
  abstract List<String> xLabels;

  Graph(String type, List<String> xLabels) {
    this.type = type;
    this.xLabels = xLabels;
  }

  Set<int> getHalfDataSets(List<DataSet> dataSets) {
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
