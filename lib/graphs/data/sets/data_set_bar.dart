import 'package:graph_swipe/graphs/data/data_list.dart';
import 'package:graph_swipe/graphs/data/sets/data_set.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_set_bar.g.dart';

@JsonSerializable()
class DataSetBar extends DataSet {
  List<int> borderColour = [];
  double borderTransparency = 1.0;
  late int borderWidth;
  late String yAxis;
  late String xAxis;

  DataSetBar(String label,
      {List<int> colour = DataSet.defaultColour,
      double transparency = 0.8,
      List<int> borderColour = DataSet.defaultColour,
      int borderWidth = 2,
      String yAxis = "y",
      String xAxis = "x"})
      : super(label, colour: colour, transparency: transparency) {
    if (borderColour == DataSet.defaultColour) {
      this.borderColour = colour;
    } else {
      this.borderColour = borderColour;
    }
    this.borderWidth = borderWidth;
    this.yAxis = yAxis;
    this.xAxis = xAxis;
  }

  factory DataSetBar.fromJson(Map<String, dynamic> json) =>
      _$DataSetBarFromJson(json);
  Map<String, dynamic> toJson() => _$DataSetBarToJson(this);

  @override
  void alterSet(
      {String newLabel = "",
      List<int> newColour = DataSet.defaultColour,
      double newTransparency = 0.8,
      List<int> newBorderColour = DataSet.defaultColour,
      int newBorderWidth = 2,
      String newYAxis = "y",
      String newXAxis = "x"}) {
    if (newLabel != "") {
      this.label = newLabel;
    }
    if (newColour != DataSet.defaultColour) {
      this.mainColour = newColour;
    }
    if (newTransparency != 0.8) {
      this.transparency = newTransparency;
    }
    if (newBorderColour != DataSet.defaultColour) {
      this.borderColour = newBorderColour;
    }
    if (newBorderWidth != 1) {
      this.borderWidth = newBorderWidth;
    }
    if (newYAxis != "y") {
      this.yAxis = newYAxis;
    }
    if (newXAxis != "x") {
      this.xAxis = newXAxis;
    }
  }

  String _showBorderWidth() {
    return "borderWidth: " + this.borderWidth.toString() + ",";
  }

  String _showYAxis() {
    return "yAxisID: '" + this.yAxis + "',";
  }

  String _showXAxis() {
    return "xAxisID: '" + this.xAxis + "',";
  }

  @override
  String showDataSet() {
    return "{" +
        showLabel() +
        showColour("backgroundColor", this.mainColour, this.transparency) +
        showColour("borderColor", this.borderColour, this.borderTransparency) +
        _showBorderWidth() +
        _showYAxis() +
        _showXAxis() +
        showData() +
        "},";
  }
}
