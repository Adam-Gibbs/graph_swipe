import 'package:graph_swipe/graphs/data/sets/data_set.dart';
import 'package:graph_swipe/graphs/data/sets/data_set_line.dart';
import 'package:graph_swipe/graphs/data/sets/data_set_upgrader.dart';
import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/graphs/options/options.dart';

class LineGraph extends Graph {
  late List<DataSet> dataSets;
  late List<DataSetLine> _dataSets;
  late Options options;
  String type = "line";
  late List<String> xLabels;

  LineGraph(List<String> xLabels) : super("line", xLabels) {
    this.xLabels = xLabels;
  }

  void _saveDataSets() {
    this.dataSets = this._dataSets;
  }

  @override
  void addDataSets(List<DataSet> dataSets) {
    var upgradedSets = DataSetUpgrader.groupToLine(dataSets);
    this._dataSets = upgradedSets;
    this.dataSets = upgradedSets;
  }

  @override
  LineGraph setDefaultOptions(title, scales) {
    this.options = new Options(title, scales);
    return this;
  }

  LineGraph addLineDataSets(List<DataSetLine> dataSets) {
    this._dataSets = dataSets;
    this.dataSets = dataSets;
    return this;
  }

  void addYAxisRelation(String label) {
    Set<int> indexs = getHalfDataSets(dataSets);
    indexs.forEach((element) => {_dataSets[element].alterSet(newYAxis: label)});
    _saveDataSets();
  }

  List<DataSet> getLineData() {
    return _dataSets;
  }
}
