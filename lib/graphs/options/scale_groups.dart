import 'package:graph_swipe/graph_manager/random/random_string.dart';
import 'package:graph_swipe/graphs/options/scale.dart';
import 'package:graph_swipe/page_data/form/save_data/saved%20_axes.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scale_groups.g.dart';

@JsonSerializable()
class ScaleGroups {
  List<Scale> xScales = [];
  List<Scale> yScales = [];

  ScaleGroups();

  factory ScaleGroups.fromJson(Map<String, dynamic> json) =>
      _$ScaleGroupsFromJson(json);
  Map<String, dynamic> toJson() => _$ScaleGroupsToJson(this);

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

  void setStacked(bool value) {
    xScales.forEach((element) => {element.stacked = value});
    yScales.forEach((element) => {element.stacked = value});
  }

  void setXAxis({required SavedAxes savedXAxes}) {
    xScales.forEach((element) {
      element.label = savedXAxes.label ?? RandomString.randWord();
      element.displayLabel = savedXAxes.displayLabel ?? false;
      element.display = savedXAxes.display ?? true;
      element.position = savedXAxes.position ?? "bottom";
    });
  }

  void setYAxis({required SavedAxes savedYAxes}) {
    yScales.forEach((element) {
      element.label = savedYAxes.label ?? RandomString.randWord();
      element.displayLabel = savedYAxes.displayLabel ?? false;
      element.display = savedYAxes.display ?? true;
      element.position = savedYAxes.position ?? "bottom";
      element.startZero = savedYAxes.startZero ?? true;
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

  void startNotZero() {
    yScales.forEach((element) {
      element.startZero = false;
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
