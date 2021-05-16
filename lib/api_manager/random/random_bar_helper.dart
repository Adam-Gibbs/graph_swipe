import 'dart:math';

import 'package:graph_swipe/graphs/graph_factory.dart';
import 'package:graph_swipe/graphs/types/bar_graph.dart';

class RandomBarHelper {
  static BarGraph randomBarGraph(Random rand, GraphFactory gf) {
    return gf.makeBar();
  }

  static BarGraph randomBorderColour(Random rand, BarGraph graph) {
    if (rand.nextDouble() < 0.1) {
      graph.randomBorderColour();
    }
    return graph;
  }

  static BarGraph roundedBars(Random rand, BarGraph graph) {
    if (rand.nextDouble() < 0.3) {
      graph.options.roundedBars = true;
    }
    return graph;
  }
}
