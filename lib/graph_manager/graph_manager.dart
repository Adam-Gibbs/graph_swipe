import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/graph_manager/random/random_factory.dart';

import 'dart:math';

import 'package:graph_swipe/page_data/form/save_data/saved_form_data.dart';

class GraphManager {
  late Graph graph;
  RandomFactory maker = new RandomFactory();
  Random rand = Random();

  GraphManager setGraph(Graph graph) {
    this.graph = graph;
    return this;
  }

  void createGraph({required SavedFormData savedFormData}) {
    if (savedFormData.hasType) {
      if (savedFormData.savedTypeData.type == "bar") {
        graph = maker.barWithDataSets(savedFormData: savedFormData);
      } else if (savedFormData.savedTypeData.type == "line") {
        graph = maker.lineWithDataSets(savedFormData: savedFormData);
      }
    } else if (savedFormData.hasDataSets) {
      graph = maker.randomGraphWithDataSets(savedFormData.graphName,
          savedDataSets: savedFormData.savedDataSets);
    } else {
      graph = maker.randomGraph(savedFormData.graphName);
    }

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
    // If saved values null, keep random ones
    graph.xLabels = savedFormData.xAxisValues ?? graph.xLabels;
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
