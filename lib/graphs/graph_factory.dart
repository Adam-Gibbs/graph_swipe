import 'package:graph_swipe/api_manager/random/random_string.dart';
import 'package:graph_swipe/graphs/data/sets/data_set.dart';
import 'package:graph_swipe/graphs/data/sets/data_set_upgrader.dart';
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
  int columns = 5;
  late Graph graph;
  Random rand = Random();

  GraphFactory(String title) {
    this.title = title;
  }

  GraphFactory setColumns(int columns) {
    this.columns = columns;
    return this;
  }

  GraphFactory defaultDataSet() {
    DataSet newData = new DataSet("Data");
    newData.setData([10, 50, 30, 5, 20]);
    dataSets.add(newData);
    return this;
  }

  GraphFactory addDataSet(String title, List<double> valueList) {
    DataSet newData = new DataSet(title);
    newData.setData(valueList);
    dataSets.add(newData);
    return this;
  }

  GraphFactory randomDataSet() {
    DataSet newData = new DataSet(RandomString.randWord());
    for (int i = 0; i < columns; i++) {
      newData.addData(rand.nextDouble() * 200);
    }
    dataSets.add(newData);
    return this;
  }

  GraphFactory randomColours() {
    dataSets.forEach((element) => {
          element.setColour(
              [rand.nextInt(256), rand.nextInt(256), rand.nextInt(256)])
        });
    return this;
  }

  GraphFactory randomLabels() {
    for (int i = 0; i < columns; i++) {
      xLabels.add(RandomString.randWord());
    }
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
    graph = new BarGraph(this.xLabels)
        .addBarDataSets(DataSetUpgrader.groupToBar(dataSets));
    dataSets = graph.dataSets;
    return this;
  }

  GraphFactory makeLine() {
    graph = new LineGraph(this.xLabels)
        .addLineDataSets(DataSetUpgrader.groupToLine(dataSets));
    dataSets = graph.dataSets;
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
