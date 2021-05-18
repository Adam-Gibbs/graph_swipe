import 'package:graph_swipe/graphs/graph.dart';

class FavouriteGraphs {
  List<Graph> graphs = [];

  void favourite(Graph graph) {
    graphs.add(graph);
  }

  void clear() {
    graphs.clear();
  }
}
