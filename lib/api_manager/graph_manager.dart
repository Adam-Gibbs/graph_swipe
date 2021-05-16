import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/api_manager/random/random_factory.dart';

import 'dart:math';

class GraphManager {
  late Graph graph;
  RandomFactory maker = new RandomFactory();
  Random rand = Random();

  GraphManager() {
    createGraph("");
  }

  void createGraph(String title) {
    graph = maker.randomGraph();
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
