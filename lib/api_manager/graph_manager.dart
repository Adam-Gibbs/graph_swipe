import 'dart:async';

import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/graphs/graph_factory.dart';

class GraphManager {
  late Graph graph;

  GraphManager() {
    createGraph();
  }

  void createGraph() {
    graph = new GraphFactory("My First Bar")
        .defaultDataSetLine()
        .defaultLabels()
        .defaultScales()
        .makeLine()
        .defaultOptions()
        .getGraph();
  }

  String _getGraphString() {
    return graph.showGraph();
  }

  Graph getGraphData() {
    return graph;
  }

  String getGraphImage(String width, String height) {
    return "https://quickchart.io/chart?c=" +
        _getGraphString() +
        "&width=" +
        width +
        "&height=" +
        height;
  }
}
