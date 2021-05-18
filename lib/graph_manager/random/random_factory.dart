import 'package:graph_swipe/graph_manager/random/random_bar_helper.dart';
import 'package:graph_swipe/graph_manager/random/random_line_helper.dart';
import 'package:graph_swipe/graph_manager/random/random_string.dart';
import 'package:graph_swipe/graphs/graph.dart';
import 'package:graph_swipe/graphs/graph_factory.dart';
import 'package:graph_swipe/graphs/types/bar_graph.dart';
import 'package:graph_swipe/graphs/types/line_graph.dart';

import 'dart:math';

import 'package:graph_swipe/page_data/form/save_data/saved_data_sets.dart';
import 'package:graph_swipe/page_data/form/save_data/saved_form_data.dart';

class RandomFactory {
  Random rand = Random();

  List<int> randomColour() {
    return ([rand.nextInt(256), rand.nextInt(256), rand.nextInt(256)]);
  }

  GraphFactory _setColumns(GraphFactory gf, {int? value}) {
    return gf.setColumns(value ?? rand.nextInt(7) + 3);
  }

  GraphFactory _addRandomDataSets(GraphFactory gf) {
    int loops = rand.nextInt(4) + 1;
    for (int i = 0; i < loops; i++) {
      gf.randomDataSet();
    }
    return gf;
  }

  GraphFactory _addDataSets(GraphFactory gf, List<SavedDataSet> savedDataSets) {
    savedDataSets.forEach((element) {
      List<int> dataColour = element.colour ?? randomColour();
      gf.addDataSet(
          element.name ?? RandomString.randWord(), element.data ?? [0, 0, 0],
          colour: (element.chooseColour ?? false) ? dataColour : randomColour(),
          transparency: element.tansparency ?? 0.8);
    });
    return gf;
  }

  GraphFactory _dataPairs(GraphFactory gf) {
    if (rand.nextDouble() < 0.2) {
      gf.removeDataSets().randomDataPairs().allRandomColours();
    }
    return gf;
  }

  Graph _chooseGraph(GraphFactory gf, {bool canPairs = true}) {
    if (rand.nextBool()) {
      if (canPairs) {
        _dataPairs(gf);
      }
      BarGraph aBar = RandomBarHelper.barGraph(gf);
      RandomBarHelper.randomBorderColour(rand, aBar);
      RandomBarHelper.roundedBars(rand, aBar);
      return aBar;
    } else {
      LineGraph aLine = RandomLineHelper.lineGraph(gf);
      RandomLineHelper.randomLineColour(rand, aLine);
      RandomLineHelper.randomLineStepped(rand, aLine);
      RandomLineHelper.randomLineDashed(rand, aLine);
      RandomLineHelper.randomLineCurved(rand, aLine);
      RandomLineHelper.randomLineFilled(rand, aLine);
      RandomLineHelper.randomLineNoLine(rand, aLine);
      RandomLineHelper.randomLinePoints(rand, aLine);
      return aLine;
    }
  }

  Graph _randomStacked(Graph graph) {
    if (rand.nextDouble() < 0.3) {
      graph.options.scales.makeStacked();
    }
    return graph;
  }

  Graph _randomLables(Graph graph) {
    if (rand.nextDouble() < 0.1) {
      graph.options.dataLabels = true;
    }
    return graph;
  }

  Graph _randomAxesLables(Graph graph) {
    if (rand.nextDouble() < 0.2) {
      graph.options.scales.makeLabelsShow();
    }
    return graph;
  }

  Graph _randTwoAxes(Graph graph) {
    if (rand.nextDouble() < 0.05) {
      graph.options.scales.createYScale("y2", "right");
      graph.addYAxisRelation("y2");
    }
    return graph;
  }

  Graph randomGraph(String? title) {
    // if title is null (??), generate one randomly
    GraphFactory graphFactory =
        new GraphFactory(title ?? RandomString.randTitle());

    _setColumns(graphFactory);
    _addRandomDataSets(graphFactory);
    graphFactory.allRandomColours().randomLabels().defaultScales();
    Graph newGraph = _chooseGraph(graphFactory);
    _randomStacked(newGraph);
    _randomLables(newGraph);
    _randomAxesLables(newGraph);
    return _randTwoAxes(newGraph);
  }

  Graph randomGraphWithDataSets(String? title,
      {required List<SavedDataSet> savedDataSets}) {
    // if title is null (??), generate one randomly
    GraphFactory graphFactory =
        new GraphFactory(title ?? RandomString.randTitle());

    _setColumns(graphFactory, value: savedDataSets.first.data?.length);
    _addDataSets(graphFactory, savedDataSets);
    graphFactory.randomLabels().defaultScales();
    Graph newGraph = _chooseGraph(graphFactory, canPairs: false);
    _randomStacked(newGraph);
    _randomLables(newGraph);
    _randomAxesLables(newGraph);
    return newGraph;
  }

  Graph barWithDataSets({required SavedFormData savedFormData}) {
    // if title is null (??), generate one randomly
    GraphFactory graphFactory =
        new GraphFactory(savedFormData.graphName ?? RandomString.randTitle());

    _addDataSets(graphFactory, savedFormData.savedDataSets);
    graphFactory.defaultScales();

    BarGraph aBar = RandomBarHelper.barGraph(graphFactory);
    if (savedFormData.savedTypeData.isBorderColour!) {
      aBar.setAllBorderColour(
          savedFormData.savedTypeData.borderColour ?? [255, 255, 255],
          savedFormData.savedTypeData.borderTransparency ?? 1.0);
    }
    if (savedFormData.savedTypeData.boldBorders!) {
      aBar.setAllBorderThickness(4);
    }
    aBar.options.roundedBars = savedFormData.savedTypeData.roundBars ?? false;

    _randomLables(aBar);
    return aBar;
  }

  Graph lineWithDataSets({required SavedFormData savedFormData}) {
    // if title is null (??), generate one randomly
    GraphFactory graphFactory =
        new GraphFactory(savedFormData.graphName ?? RandomString.randTitle());

    _addDataSets(graphFactory, savedFormData.savedDataSets);
    graphFactory.defaultScales();
    LineGraph aLine = RandomLineHelper.lineGraph(graphFactory);

    List<Function> toRunRandom = [];
    for (int i = 0; i < aLine.dataSets.length; i++) {
      if (!savedFormData.savedTypeData.displayLines!) {
        aLine.makeNoLine(i);
      } else {
        if (savedFormData.savedTypeData.fill!) {
          aLine.makeFilled(i);
        } else {
          toRunRandom.add(RandomLineHelper.randomLineFilled);
        }
        if (savedFormData.savedTypeData.lineStyle == "Random") {
          toRunRandom.add(RandomLineHelper.randomLineDashed);
        } else if (savedFormData.savedTypeData.lineStyle == "Dashed") {
          aLine.makeDashed(i);
        }
        if (savedFormData.savedTypeData.pointToPoint == "Random") {
          toRunRandom.add(RandomLineHelper.randomLineCurved);
          toRunRandom.add(RandomLineHelper.randomLineStepped);
        } else if (savedFormData.savedTypeData.pointToPoint == "Curved") {
          aLine.makeCurved(i);
        } else if (savedFormData.savedTypeData.pointToPoint == "Stepped") {
          aLine.makeStepped(i);
        }
      }

      if (savedFormData.savedTypeData.pointStyle == "Random") {
        toRunRandom.add(RandomLineHelper.randomLinePoints);
      } else {
        aLine.changePoints(i,
            savedFormData.savedTypeData.pointStyle?.toLowerCase() ?? "circle");
      }
    }

    toRunRandom.forEach((element) => {element(rand, aLine)});

    _randomLables(aLine);
    return aLine;
  }
}
