import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/graph_manager/random/random_factory.dart';

import 'dart:math';

class GraphManager {
  late Graph graph;
  RandomFactory maker = new RandomFactory();
  Random rand = Random();

  void setGraph(Graph graph) {
    this.graph = graph;
  }

  void createGraph({String? title = ""}) {
    graph = maker.randomGraph(title);
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
