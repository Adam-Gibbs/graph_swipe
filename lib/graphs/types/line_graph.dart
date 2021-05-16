import 'package:graph_swipe/graphs/data/data_set.dart';
import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/graphs/options/options.dart';

class LineGraph extends Graph {
  late List<DataSet> dataSets;
  late Options options;
  String type = "line";
  late List<String> xLabels;

  LineGraph(List<String> xLabels, List<DataSet> dataSets)
      : super("line", xLabels, dataSets) {
    this.dataSets = dataSets;
    this.xLabels = xLabels;
  }
}
