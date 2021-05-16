import 'package:graph_swipe/graphs/data/data_set.dart';
import 'package:graph_swipe/graphs/data/data_set_bar.dart';
import 'package:graph_swipe/graphs/data/data_set_line.dart';
import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/graphs/options/scale_groups.dart';
import 'package:graph_swipe/graphs/types/bar_graph.dart';
import 'package:graph_swipe/graphs/types/line_graph.dart';

import 'dart:math';

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

  GraphFactory defaultDataSetLine() {
    DataSetLine newData = new DataSetLine("Data");
    newData.setData([10, 50, 30, 5, 20]);
    dataSets.add(newData);
    return this;
  }

  GraphFactory defaultDataSetBar() {
    DataSetBar newData = new DataSetBar("Data");
    newData.setData([10, 50, 30, 5, 20]);
    dataSets.add(newData);
    return this;
  }

  int _randRGB() {
    Random random = Random();
    // Pick a random number in the range [0.0, 1.0)
    return random.nextInt(256);
  }

  GraphFactory randomColours() {
    dataSets.forEach((element) => {
          element.setColour([_randRGB(), _randRGB(), _randRGB()])
        });
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

  GraphFactory makeLine() {
    graph = new LineGraph(this.xLabels, this.dataSets);
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
