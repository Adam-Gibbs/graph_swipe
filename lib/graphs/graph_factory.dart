import 'package:graph_swipe/graphs/data/data_set.dart';
import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/graphs/options/scale_groups.dart';
import 'package:graph_swipe/graphs/types/bar_graph.dart';

class GraphFactory {
  late String title;
  List<String> xLabels = [];
  List<DataSet> dataSets = [];
  ScaleGroups scales = new ScaleGroups();
  late Graph graph;

  GraphFactory(String title) {
    this.title = title;
  }

  GraphFactory defaultDataSet() {
    DataSet newData = new DataSet("Data");
    newData.setData([10, 50, 30, 5, 20]);
    dataSets.add(newData);
    return this;
  }

  GraphFactory defaultLabels() {
    xLabels.addAll(["Point1", "Point2", "Point3", "Point4", "Point5"]);
    return this;
  }

  GraphFactory defaultScales() {
    scales.addDefaultXScale();
    scales.addDefaultYScale();
    return this;
  }

  GraphFactory makeBar() {
    graph = new BarGraph(this.xLabels, this.dataSets);
    return this;
  }

  GraphFactory defaultOptions() {
    graph.setDefaultOptions(this.title, this.scales);
    return this;
  }

  Graph getGraph() {
    return graph;
  }
}
