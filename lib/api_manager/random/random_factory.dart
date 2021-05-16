import 'package:graph_swipe/api_manager/random/random_bar_helper.dart';
import 'package:graph_swipe/api_manager/random/random_line_helper.dart';
import 'package:graph_swipe/api_manager/random/random_string.dart';
import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/graphs/graph_factory.dart';
import 'package:graph_swipe/graphs/types/bar_graph.dart';
import 'package:graph_swipe/graphs/types/line_graph.dart';

import 'dart:math';

class RandomFactory {
  Random rand = Random();

  GraphFactory _setColumns(GraphFactory gf) {
    return gf.setColumns(rand.nextInt(7) + 3);
  }

  GraphFactory _addDataSets(GraphFactory gf) {
    int loops = rand.nextInt(4) + 1;
    for (int i = 0; i < loops; i++) {
      gf.randomDataSet();
    }

    return gf;
  }

  GraphFactory _dataPairs(GraphFactory gf) {
    if (rand.nextDouble() < 0.2) {
      gf.removeDataSets().randomDataPairs().randomColours();
    }
    return gf;
  }

  Graph _chooseGraph(GraphFactory gf) {
    if (rand.nextBool()) {
      _dataPairs(gf);
      BarGraph aBar = RandomBarHelper.randomBarGraph(rand, gf);
      RandomBarHelper.randomBorderColour(rand, aBar);
      RandomBarHelper.roundedBars(rand, aBar);
      return aBar;
    } else {
      LineGraph aLine = RandomLineHelper.randomLineGraph(gf);
      return aLine;
    }
  }

  Graph _randTwoAxes(Graph graph) {
    if (rand.nextDouble() < 0.05) {
      graph.options.scales.createYScale("y2", "right");
      graph.addYAxisRelation("y2");
    }
    return graph;
  }

  Graph randomGraph() {
    GraphFactory graphFactory = new GraphFactory(RandomString.randTitle());

    _setColumns(graphFactory);
    _addDataSets(graphFactory);
    graphFactory.randomColours().randomLabels().defaultScales();
    Graph newGraph = _chooseGraph(graphFactory);
    return _randTwoAxes(newGraph);
  }
}
