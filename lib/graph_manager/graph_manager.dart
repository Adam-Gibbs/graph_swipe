import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/graph_manager/random/random_factory.dart';

import 'dart:math';

import 'package:graph_swipe/page_data/form/save_data/saved_form_data.dart';

class GraphManager {
  late Graph graph;
  RandomFactory maker = new RandomFactory();
  Random rand = Random();

  void setGraph(Graph graph) {
    this.graph = graph;
  }

  void createGraph({required SavedFormData savedFormData}) {
    graph = maker.randomGraph(savedFormData.graphName);
    if (savedFormData.hasXAxes) {
      createGraphWithXAxis(savedFormData: savedFormData);
    }
    if (savedFormData.hasYAxes) {
      createGraphWithYAxis(savedFormData: savedFormData);
    }
  }

  void createGraphWithXAxis(
      {String? title, required SavedFormData savedFormData}) {
    graph.options.scales.setXAxis(savedXAxes: savedFormData.savedXAxes);
    // If saved values null, keep random ones
    graph.xLabels = savedFormData.xAxisValues ?? graph.xLabels;
  }

  void createGraphWithYAxis(
      {String? title, required SavedFormData savedFormData}) {
    graph.options.scales.setYAxis(savedYAxes: savedFormData.savedYAxes);
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
