import 'package:graph_swipe/graph_manager/random/random_string.dart';
import 'package:graph_swipe/graphs/options/scale.dart';
import 'package:graph_swipe/page_data/form/save_data/saved%20_x_axes.dart';

class ScaleGroups {
  List<Scale> xScales = [];
  List<Scale> yScales = [];

  void addDefaultXScale({bool display = true, bool stacked = false}) {
    xScales.add(Scale("x", "bottom", display: display, stacked: stacked));
  }

  void addDefaultYScale({bool display = true, bool stacked = false}) {
    yScales.add(Scale("y", "left", display: display, stacked: stacked));
  }

  void addXScale(Scale newScale) {
    xScales.add(newScale);
  }

  void addYScale(Scale newScale) {
    yScales.add(newScale);
  }

  void createXScale(String id, String position,
      {bool display = true,
      String label = "Axes Label",
      bool displayLabel = false,
      bool stacked = false}) {
    xScales.add(Scale(id, position,
        display: display,
        label: label,
        displayLabel: displayLabel,
        stacked: stacked));
  }

  void createYScale(String id, String position,
      {bool display = true,
      String label = "Axes Label",
      bool displayLabel = false,
      bool stacked = false}) {
    yScales.add(Scale(id, position,
        display: display,
        label: label,
        displayLabel: displayLabel,
        stacked: stacked));
  }

  void makeStacked() {
    xScales.forEach((element) => {element.stacked = true});
    yScales.forEach((element) => {element.stacked = true});
  }

  void setXAxis({required SavedXAxes savedXAxes}) {
    xScales.forEach((element) {
      element.label = savedXAxes.label ?? RandomString.randWord();
      element.displayLabel = savedXAxes.displayLabel ?? false;
      element.display = savedXAxes.display ?? true;
      element.position = savedXAxes.position ?? "bottom";
    });
  }

  void makeLabelsShow() {
    xScales.forEach((element) {
      element.displayLabel = true;
      element.randomLabel();
    });
    yScales.forEach((element) {
      element.displayLabel = true;
      element.randomLabel();
    });
  }

  String _showScaleList(List<Scale> scalesToShow) {
    String finString = "";
    scalesToShow.forEach((element) => {finString += element.showScale()});

    return finString;
  }

  String showScales() {
    return "scales: {xAxes: [" +
        _showScaleList(xScales) +
        "], yAxes: [" +
        _showScaleList(yScales) +
        "]},";
  }
}
