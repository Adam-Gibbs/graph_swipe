import 'package:graph_swipe/graphs/data/data_set.dart';

class DataSetLine extends DataSet {
  List<int> lineColour = [];
  late bool fill;
  late bool stepped;
  late bool dashed;
  late bool curved;
  late bool showLine;
  late String pointStyle;
  late int pointRadius;
  late String yAxis;

  DataSetLine(String label,
      {List<int> colour = DataSet.defaultColour,
      double transparency = 0.8,
      List<int> lineColour = DataSet.defaultColour,
      bool fill = false,
      bool stepped = false,
      bool dashed = false,
      bool curved = false,
      bool showLine = true,
      String pointStyle = 'circle',
      int pointRadius = 3,
      String yAxis = "y"})
      : super(label, colour: colour, transparency: transparency) {
    this.lineColour = checkLineColour(lineColour, colour);
    this.fill = fill;
    this.stepped = stepped;
    this.dashed = dashed;
    this.curved = curved;
    this.showLine = showLine;
    this.pointStyle = pointStyle;
    this.pointRadius = pointRadius;
    this.yAxis = yAxis;
  }

  List<int> checkLineColour(List<int> line, List<int> main) {
    if (line == DataSet.defaultColour) {
      return main;
    } else {
      return line;
    }
  }

  String _showFill() {
    return "fill: " + this.fill.toString() + ",";
  }

  String _showStepped() {
    return "steppedLine: " + this.stepped.toString() + ",";
  }

  String _showDashed() {
    if (this.dashed) {
      return "borderDash: [5, 5]";
    } else {
      return "";
    }
  }

  String _showCurved() {
    if (this.curved) {
      return "lineTension: 0.4";
    } else {
      return "";
    }
  }

  String _showShowLine() {
    return "showLine: " + this.showLine.toString() + ",";
  }

  String _showPointStyle() {
    return "pointStyle: '" + this.pointStyle + "',";
  }

  String _showPointRadius() {
    return "pointRadius: " + this.pointRadius.toString() + ",";
  }

  String _showYAxis() {
    return "yAxisID: '" + this.yAxis + "',";
  }

  @override
  String showDataSet() {
    this.lineColour = checkLineColour(this.lineColour, this.mainColour);

    return "{" +
        showLabel() +
        showColour("backgroundColor", mainColour, transparency) +
        showColour("borderColor", lineColour, transparency + 0.2) +
        _showFill() +
        _showStepped() +
        _showDashed() +
        _showCurved() +
        _showShowLine() +
        _showPointStyle() +
        _showPointRadius() +
        _showYAxis() +
        showData() +
        "},";
  }
}
