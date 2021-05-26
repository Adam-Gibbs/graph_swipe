import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/graph_manager/random/random_factory.dart';

import 'dart:math';

import 'package:graph_swipe/page_data/form/save_data/saved_form_data.dart';

class GraphManager {
  late Graph graph;
  late RandomFactory maker;
  Random rand = Random();

  GraphManager setGraph(Graph graph) {
    this.graph = graph;
    return this;
  }

  void createGraph({required SavedFormData savedFormData}) {
    maker = new RandomFactory(savedFormData.graphName);

    if (savedFormData.hasDataSets) {
      maker.addDataSets(savedFormData
          .savedDataSets); // Also adds random colours if none selected
    } else {
      maker.setColumns().addRandomDataSets().randomColours();
    }

    maker
        .setLabels(savedFormData)
        .defaultScales()
        .setGraph(savedFormData)
        .randomStacked()
        .randomLables()
        .randomAxesLables()
        .randTwoAxes();

    graph = maker.getGraph();

    if (savedFormData.hasXAxes) {
      setGraphXAxis(savedFormData: savedFormData);
    }
    if (savedFormData.hasYAxes) {
      setGraphYAxis(savedFormData: savedFormData);
    }
    if (savedFormData.hasOptions) {
      setGraphOptions(savedFormData: savedFormData);
    }
  }

  void setGraphXAxis({required SavedFormData savedFormData}) {
    graph.options.scales.setXAxis(savedXAxes: savedFormData.savedXAxes);
  }

  void setGraphYAxis({required SavedFormData savedFormData}) {
    graph.options.scales.setYAxis(savedYAxes: savedFormData.savedYAxes);
  }

  void setGraphOptions({required SavedFormData savedFormData}) {
    graph.options.displayTitle =
        savedFormData.savedOptionsData.showTitle ?? true;
    graph.options.legendDisplay =
        savedFormData.savedOptionsData.showLegend ?? true;
    graph.options.legendPosition =
        savedFormData.savedOptionsData.legendPosition ?? "bottom";
    graph.options.dataLabels =
        savedFormData.savedOptionsData.showDataLabels ?? false;
    graph.options.scales
        .setStacked(savedFormData.savedOptionsData.stacked ?? false);
  }

  String _getGraphString() {
    return graph.showGraph();
  }

  Graph getGraphData() {
    return graph;
  }

  String getGraphImage(double width, double height) {
    return "https://quickchart.io/chart?c=" +
        _getGraphString() +
        "&width=" +
        width.toString() +
        "&height=" +
        height.toString();
  }
}
