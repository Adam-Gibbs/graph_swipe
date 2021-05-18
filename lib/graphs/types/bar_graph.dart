import 'package:graph_swipe/graphs/data/sets/data_set.dart';
import 'package:graph_swipe/graphs/data/sets/data_set_bar.dart';
import 'package:graph_swipe/graphs/data/sets/data_set_upgrader.dart';
import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/graphs/options/options.dart';

class BarGraph extends Graph {
  late List<DataSet> dataSets;
  late List<DataSetBar> _dataSets;
  late Options options;
  String type = "bar";
  late List<String> xLabels;

  BarGraph(List<String> xLabels) : super("bar", xLabels) {
    this.xLabels = xLabels;
  }

  void _saveDataSets() {
    this.dataSets = this._dataSets;
  }

  @override
  void setRandomOptions(title, scales) {
    this.options = new Options(title, scales);
  }

  @override
  void addDataSets(List<DataSet> dataSets) {
    var upgradedSets = DataSetUpgrader.groupToBar(dataSets);
    this._dataSets = upgradedSets;
    this.dataSets = upgradedSets;
  }

  @override
  BarGraph setDefaultOptions(title, scales) {
    this.options = new Options(title, scales);
    return this;
  }

  BarGraph randomBorderColour() {
    _dataSets.forEach((element) => {
          element.borderColour = [
            rand.nextInt(256),
            rand.nextInt(256),
            rand.nextInt(256)
          ]
        });
    _saveDataSets();
    return this;
  }

  BarGraph setAllBorderColour(List<int> colour, double transparency) {
    _dataSets.forEach((element) {
      element.borderColour = colour;
      element.transparency = transparency;
    });
    _saveDataSets();
    return this;
  }

  BarGraph setAllBorderThickness(int thickness) {
    _dataSets.forEach((element) {
      element.borderWidth = thickness;
    });
    _saveDataSets();
    return this;
  }

  BarGraph addBarDataSets(List<DataSetBar> dataSets) {
    this._dataSets = dataSets;
    this.dataSets = dataSets;

    return this;
  }

  void addYAxisRelation(String label) {
    Set<int> indexs = getHalfDataSets();
    indexs.forEach((element) => {_dataSets[element].alterSet(newYAxis: label)});
    _saveDataSets();
  }

  List<DataSetBar> getBarData() {
    return _dataSets;
  }
}
