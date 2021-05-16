import 'dart:math';

import 'package:graph_swipe/graphs/graph_factory.dart';
import 'package:graph_swipe/graphs/types/line_graph.dart';

class RandomLineHelper {
  static LineGraph randomLineGraph(GraphFactory gf) {
    return gf.makeLine();
  }

  static LineGraph randomLineColour(Random rand, LineGraph graph) {
    if (rand.nextDouble() < 0.1) {
      graph.randomLineColour();
    }
    return graph;
  }
}
