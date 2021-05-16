import 'package:graph_swipe/graphs/data/sets/data_set.dart';
import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/graphs/options/options.dart';

class BarGraph extends Graph {
  late List<DataSet> dataSets;
  late Options options;
  String type = "bar";
  late List<String> xLabels;

  BarGraph(List<String> xLabels, List<DataSet> dataSets)
      : super("bar", xLabels, dataSets) {
    this.dataSets = dataSets;
    this.xLabels = xLabels;
  }

  @override
  void setRandomOptions(title, scales) {
    this.options = new Options(title, scales);
  }
}
