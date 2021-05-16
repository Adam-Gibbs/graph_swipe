import 'package:graph_swipe/graphs/data/data_set.dart';

class DataSetBar extends DataSet {
  List<int> borderColour = [];
  late double borderWidth;
  late String yAxis;

  DataSetBar(String label,
      {List<int> colour = DataSet.defaultColour,
      double transparency = 0.8,
      List<int> borderColour = DataSet.defaultColour,
      double borderWidth = 1,
      String yAxis = "y"})
      : super(label, colour: colour, transparency: transparency) {
    this.borderColour = borderColour;
    this.borderWidth = borderWidth;
    this.yAxis = yAxis;
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
        showColour("backgroundColor", mainColour, transparency) +
        showColour("borderColour", borderColour, 1) +
        _showBorderWidth() +
        _showYAxis() +
        showData() +
        "},";
  }
}
