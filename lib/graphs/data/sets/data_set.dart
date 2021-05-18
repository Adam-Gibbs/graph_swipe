import 'package:graph_swipe/graphs/data/data_list.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_set.g.dart';

@JsonSerializable()
class DataSet {
  static const List<int> defaultColour = [0, 0, 0];
  DataList data = new DataList();
  late String label;
  late List<int> mainColour;
  late double transparency;

  DataSet(String label,
      {List<int> colour = defaultColour, double transparency = 0.8}) {
    this.mainColour = colour;
    this.label = label;
    this.transparency = transparency;
  }

  factory DataSet.fromJson(Map<String, dynamic> json) =>
      _$DataSetFromJson(json);
  Map<String, dynamic> toJson() => _$DataSetToJson(this);

  void setDataList(DataList dataList) {
    this.data = dataList;
  }

  void addData(double value) {
    this.data.add(value);
  }

  void addDataPair(List<double> valueList) {
    data.addPair(valueList);
  }

  DataSet setData(List<double> valueList) {
    valueList.forEach((element) => {this.data.add(element)});
    return this;
  }

  void setDataPairs(List<List<double>> valuePairList) {
    valuePairList.forEach((element) => {data.addPair(element)});
  }

  void alterSet(
      {String newLabel = "",
      List<int> newColour = defaultColour,
      double newTransparency = 0.8}) {
    if (newLabel != "") {
      this.label = newLabel;
    }
    if (newColour != defaultColour) {
      this.mainColour = newColour;
    }
    if (newTransparency != 0.8) {
      this.transparency = newTransparency;
    }
  }

  void setColour(List<int> colour) {
    this.mainColour = colour;
  }

  String showLabel() {
    return "label: '" + this.label + "',";
  }

  String showColour(String name, List<int> colours, double transparency) {
    return name +
        ": 'rgba(" +
        colours[0].toString() +
        ", " +
        colours[1].toString() +
        ", " +
        colours[2].toString() +
        ", " +
        transparency.toString() +
        ")',";
  }

  String showData() {
    return "data: " + this.data.toString() + ",";
  }

  String showDataSet() {
    return "{" +
        showLabel() +
        showColour("backgroundColor", mainColour, transparency) +
        showData() +
        "},";
  }
}
