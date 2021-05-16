import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/graphs/graph_factory.dart';
import 'package:english_words/english_words.dart';

import 'dart:math';

class GraphManager {
  late Graph graph;
  Random rand = Random();

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
    GraphFactory graphFactory = new GraphFactory(title);

    int loops = rand.nextInt(5);
    for (int i = 0; i < loops; i++) {
      graphFactory.randomDataSet();
    }

    graphFactory.randomColours().defaultLabels().defaultScales();

    if (rand.nextBool()) {
      graphFactory.makeLine();
    } else {
      graphFactory.makeBar();
    }

    graph = graphFactory.defaultOptions().getGraph();
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
