import 'package:graph_swipe/graphs/options/scale_groups.dart';

class Options {
  late String title;
  late bool displayTitle;
  late String legendPosition;
  late bool legendDisplay;
  late bool dataLabels;
  late bool roundedBars;
  late ScaleGroups scales;

  Options(String title, ScaleGroups scales,
      {bool displayTitle = true,
      String legendPosition = 'bottom',
      bool legendDisplay = true,
      bool dataLabels = false,
      bool roundedBars = false}) {
    // TODO: remove setters in constructors??
    this.title = title;
    this.displayTitle = displayTitle;
    this.legendPosition = legendPosition;
    this.legendDisplay = legendDisplay;
    this.dataLabels = dataLabels;
    this.roundedBars = roundedBars;
    this.scales = scales;
  }

  String _showTitle() {
    return "title: {display: " +
        this.displayTitle.toString() +
        ", text: '" +
        this.title +
        "'},";
  }

  String _showlegend() {
    return "legend: {position: '" +
        this.legendPosition +
        "'," +
        "display: " +
        this.legendDisplay.toString() +
        "},";
  }

  String _showPlugins() {
    return "plugins: {datalabels: " +
        this.dataLabels.toString() +
        ", roundedBars: " +
        this.roundedBars.toString() +
        "},";
  }

  String showOptions() {
    return "options: {" +
        _showTitle() +
        _showlegend() +
        _showPlugins() +
        scales.showScales() +
        "},";
  }
}
