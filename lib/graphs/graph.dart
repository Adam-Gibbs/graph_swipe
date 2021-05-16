import 'package:graph_swipe/graphs/data/data_set.dart';
import 'package:graph_swipe/graphs/options/options.dart';

abstract class Graph {
  abstract List<DataSet> dataSets;
  abstract Options options;
  abstract String type;
  abstract List<String> xLabels;

  Graph(String type, List<String> xLabels, List<DataSet> dataSets) {
    this.type = type;
    this.xLabels = xLabels;
    this.dataSets = dataSets;
  }

  void setOptions(Options options) {
    this.options = options;
  }

  void setDefaultOptions(title, scales) {
    this.options = new Options(title, scales);
  }

  void setRandomOptions(title, scales) {
    this.options = new Options(title, scales);
  }

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
