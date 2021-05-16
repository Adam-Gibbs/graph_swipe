import 'package:graph_swipe/graphs/data/sets/data_set.dart';

class DataSetBar extends DataSet {
  List<int> borderColour = [];
  late int borderWidth;
  late String yAxis;

  DataSetBar(String label,
      {List<int> colour = DataSet.defaultColour,
      double transparency = 0.8,
      List<int> borderColour = DataSet.defaultColour,
      int borderWidth = 2,
      String yAxis = "y"})
      : super(label, colour: colour, transparency: transparency) {
    if (borderColour == DataSet.defaultColour) {
      this.borderColour = colour;
    } else {
      this.borderColour = borderColour;
    }
    this.borderWidth = borderWidth;
    this.yAxis = yAxis;
  }

  @override
  void alterSet(
      {String newLabel = "",
      List<int> newColour = DataSet.defaultColour,
      double newTransparency = 0.8,
      List<int> newBorderColour = DataSet.defaultColour,
      int newBorderWidth = 2,
      String newYAxis = "y"}) {
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
  }

  String _showBorderWidth() {
    return "borderWidth: " + this.borderWidth.toString() + ",";
  }

  String _showYAxis() {
    return "yAxisID: '" + this.yAxis + "',";
  }

  @override
  String showDataSet() {
    return "{" +
        showLabel() +
        showColour("backgroundColor", this.mainColour, transparency) +
        showColour("borderColor", this.borderColour, 1) +
        _showBorderWidth() +
        _showYAxis() +
        showData() +
        "},";
  }
}
