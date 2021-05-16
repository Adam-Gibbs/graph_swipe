import 'package:graph_swipe/api_manager/random/random_string.dart';

class Scale {
  late String id; // id: 'y'
  late String position; // position: 'bottom'
  late bool display; // display: true
  late bool displayLabel; // scaleLabel: {display: true}
  late String label; // scaleLabel: {labelString: 'Month'}
  late bool stacked; // stacked: true

  Scale(String id, String position,
      {bool display = true,
      bool displayLabel = false,
      String label = "Axes Label",
      bool stacked = false}) {
    this.id = id;
    this.position = position;
    this.display = display;
    this.displayLabel = displayLabel;
    this.label = label;
    this.stacked = stacked;
  }

  void randomLabel() {
    this.label = RandomString.randWord();
  }

  String _showId() {
    return "id: '" + this.id + "',";
  }

  String _showPosition() {
    return "position: '" + this.position + "',";
  }

  String _showDisplay() {
    return "display: " + this.display.toString() + ",";
  }

  String _showLabel() {
    return "scaleLabel: { display: " +
        this.displayLabel.toString() +
        ", labelString: '" +
        this.label +
        "'},";
  }

  String _showStacked() {
    return "stacked: " + this.stacked.toString() + ",";
  }

  String showScale() {
    return "{" +
        _showId() +
        _showPosition() +
        _showDisplay() +
        _showLabel() +
        _showStacked() +
        "},";
  }
}
