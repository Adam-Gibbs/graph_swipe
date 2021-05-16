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

  static LineGraph randomLineStepped(Random rand, LineGraph graph) {
    Set<int> indexSet = graph.getRandomDataSets(0.1);
    indexSet.forEach((element) => {graph.makeStepped(element)});
    return graph;
  }

  static LineGraph randomLineDashed(Random rand, LineGraph graph) {
    Set<int> indexSet = graph.getRandomDataSets(0.15);
    indexSet.forEach((element) => {graph.makeDashed(element)});
    return graph;
  }

  static LineGraph randomLineCurved(Random rand, LineGraph graph) {
    Set<int> indexSet = graph.getRandomDataSets(0.6);
    indexSet.forEach((element) => {graph.makeCurved(element)});
    return graph;
  }

  static LineGraph randomLineFilled(Random rand, LineGraph graph) {
    Set<int> indexSet = graph.getRandomDataSets(0.4);
    indexSet.forEach((element) => {graph.makeFilled(element)});
    return graph;
  }

  static LineGraph randomLineNoLine(Random rand, LineGraph graph) {
    Set<int> indexSet = graph.getRandomDataSets(0.1);
    indexSet.forEach((element) => {graph.makeNoLine(element)});
    return graph;
  }

  static LineGraph randomLinePoints(Random rand, LineGraph graph) {
    Set<int> indexSet = graph.getRandomDataSets(0.4);
    indexSet.forEach((element) => {graph.changePoints(element, "triangle")});
    Set<int> indexSet2 = graph.getRandomDataSets(0.3);
    indexSet2.forEach((element) => {graph.changePoints(element, "star")});
    return graph;
  }
}
