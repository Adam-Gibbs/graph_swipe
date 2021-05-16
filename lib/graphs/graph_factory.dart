import 'package:graph_swipe/graphs/data/sets/data_set.dart';
import 'package:graph_swipe/graphs/data/sets/data_set_upgrader.dart';
import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/graphs/options/scale_groups.dart';
import 'package:graph_swipe/graphs/types/bar_graph.dart';
import 'package:graph_swipe/graphs/types/line_graph.dart';

import 'dart:math';
import 'package:english_words/english_words.dart';

class GraphFactory {
  late String title;
  List<String> xLabels = [];
  List<DataSet> dataSets = [];
  ScaleGroups scales = new ScaleGroups();
  late Graph graph;
  Random rand = Random();

  GraphFactory(String title) {
    this.title = title;
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

  GraphFactory randomDataSet({int amount = 5}) {
    DataSet newData = new DataSet(WordPair.random().first);
    for (int i = 0; i < amount; i++) {
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

  GraphFactory randomLabels({int amount = 5}) {
    for (int i = 0; i < amount; i++) {
      xLabels.add(WordPair.random().first);
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
    List<DataSet> tempDataSets = [];
    dataSets.forEach(
        (element) => {tempDataSets.add(DataSetUpgrader.toBar(element))});
    dataSets = tempDataSets;
    graph = new BarGraph(this.xLabels, this.dataSets);
    return this;
  }

  GraphFactory makeLine() {
    List<DataSet> tempDataSets = [];
    dataSets.forEach(
        (element) => {tempDataSets.add(DataSetUpgrader.toLine(element))});
    dataSets = tempDataSets;
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
