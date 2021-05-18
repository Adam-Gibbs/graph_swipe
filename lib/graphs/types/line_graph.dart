import 'package:graph_swipe/graphs/data/sets/data_set.dart';
import 'package:graph_swipe/graphs/data/sets/data_set_line.dart';
import 'package:graph_swipe/graphs/data/sets/data_set_upgrader.dart';
import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/graphs/options/options.dart';
import 'package:json_annotation/json_annotation.dart';

part 'line_graph.g.dart';

@JsonSerializable()
class LineGraph extends Graph {
  late List<DataSet> dataSets;
  late List<DataSetLine> _dataSets;
  late Options options;
  String type = "line";
  late List<String> xLabels;

  LineGraph(List<String> xLabels) : super("line", xLabels) {
    this.xLabels = xLabels;
  }

  factory LineGraph.fromJson(Map<String, dynamic> json) =>
      _$LineGraphFromJson(json);
  Map<String, dynamic> toJson() => _$LineGraphToJson(this);

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

  LineGraph randomLineColour() {
    _dataSets.forEach((element) => {
          element.lineColour = [
            rand.nextInt(256),
            rand.nextInt(256),
            rand.nextInt(256)
          ]
        });
    _saveDataSets();
    return this;
  }

  LineGraph addLineDataSets(List<DataSetLine> dataSets) {
    this._dataSets = dataSets;
    this.dataSets = dataSets;
    return this;
  }

  void addYAxisRelation(String label) {
    Set<int> indexs = getHalfDataSets();
    indexs.forEach((element) => {_dataSets[element].alterSet(newYAxis: label)});
    _saveDataSets();
  }

  void makeStepped(int index) {
    _dataSets[index].stepped = true;
    _saveDataSets();
  }

  void makeDashed(int index) {
    _dataSets[index].dashed = true;
    _saveDataSets();
  }

  void makeCurved(int index) {
    _dataSets[index].curved = true;
    _saveDataSets();
  }

  void makeFilled(int index) {
    _dataSets[index].fill = true;
    _saveDataSets();
  }

  void changePoints(int index, String newShape) {
    _dataSets[index].pointStyle = newShape;
    _saveDataSets();
  }

  void makeNoLine(int index) {
    _dataSets[index].showLine = false;
    _saveDataSets();
  }

  List<DataSet> getLineData() {
    return _dataSets;
  }
}
