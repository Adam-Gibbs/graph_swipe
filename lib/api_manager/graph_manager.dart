import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/graphs/graph_factory.dart';

class GraphManager {
  String getGraphString() {
    Graph graph = new GraphFactory("My First Bar")
        .defaultDataSetLine()
        .defaultLabels()
        .defaultScales()
        .makeLine()
        .defaultOptions()
        .getGraph();

    return graph.showGraph();
  }
}
