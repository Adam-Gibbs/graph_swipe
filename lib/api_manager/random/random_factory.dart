import 'package:graph_swipe/api_manager/random/random_string.dart';
import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/graphs/graph_factory.dart';

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

  GraphFactory _randomBarGraph(GraphFactory gf) {
    return gf.makeBar();
  }

  GraphFactory _randomLineGraph(GraphFactory gf) {
    return gf.makeLine();
  }

  GraphFactory _chooseGraph(GraphFactory gf) {
    if (rand.nextBool()) {
      return _randomBarGraph(gf);
    } else {
      return _randomLineGraph(gf);
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
    _chooseGraph(graphFactory).defaultOptions();
    return _randTwoAxes(graphFactory.getGraph());
  }
}
