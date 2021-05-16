import 'package:graph_swipe/graphs/data/data_list.dart';

class DataSet {
  DataList data = new DataList();
  static const List<int> defaultColour = [0, 0, 0];
  late String label;
  late List<int> mainColour;
  late double transparency;

  DataSet(String label,
      {List<int> colour = defaultColour, double transparency = 0.8}) {
    this.label = label;
    this.mainColour = colour;
    this.transparency = transparency;
  }

  setData(List<double> valueList) {
    valueList.forEach((element) => {data.add(element)});
  }

  setDataPairs(List<List<double>> valuePairList) {
    valuePairList.forEach((element) => {data.addPair(element)});
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
