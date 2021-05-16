import 'dart:async';

import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/graphs/graph_factory.dart';
import 'package:english_words/english_words.dart';

class GraphManager {
  late Graph graph;

  GraphManager() {
    createGraph("");
  }

  String randTitle() {
    return WordPair.random().join(" ").toUpperCase();
  }

  void createGraph(String title) {
    if (title.isEmpty) {
      title = randTitle();
    }
    graph = new GraphFactory(title)
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
