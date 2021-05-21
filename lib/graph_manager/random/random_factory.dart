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
  late GraphFactory graphFactory;
  late Graph graph;

  RandomFactory(String? title) {
    // if title is null (??), generate one randomly
    graphFactory = new GraphFactory(title ?? RandomString.randTitle());
  }

  List<int> _randomColour() {
    return ([rand.nextInt(256), rand.nextInt(256), rand.nextInt(256)]);
  }

  RandomFactory setColumns({int? value}) {
    graphFactory.setColumns(value ?? rand.nextInt(7) + 3);
    return this;
  }

  RandomFactory addRandomDataSets() {
    int loops = rand.nextInt(4) + 1;
    for (int i = 0; i < loops; i++) {
      graphFactory.randomDataSet();
    }
    return this;
  }

  RandomFactory addDataSets(List<SavedDataSet> savedDataSets) {
    savedDataSets.forEach((element) {
      List<int> dataColour = element.colour ?? _randomColour();
      graphFactory.addDataSet(
          element.name ?? RandomString.randWord(), element.data ?? [0, 0, 0],
          colour:
              (element.chooseColour ?? false) ? dataColour : _randomColour(),
          transparency: element.tansparency ?? 0.8);
    });
    return this;
  }

  RandomFactory dataPairs() {
    if (rand.nextDouble() < 0.2) {
      graphFactory.removeDataSets().randomDataPairs().allRandomColours();
    }
    return this;
  }

  Graph _chooseGraph({bool canPairs = true}) {
    if (rand.nextBool()) {
      if (canPairs) {
        dataPairs();
      }
      BarGraph aBar = RandomBarHelper.barGraph(graphFactory);
      RandomBarHelper.randomBorderColour(rand, aBar);
      RandomBarHelper.roundedBars(rand, aBar);
      return aBar;
    } else {
      LineGraph aLine = RandomLineHelper.lineGraph(graphFactory);
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

  RandomFactory randomStart(Graph graph) {
    graph.options.scales.startNotZero();
    return this;
  }

  RandomFactory randomStacked() {
    if (rand.nextDouble() < 0.3) {
      graph.options.scales.setStacked(true);
    }
    return this;
  }

  RandomFactory randomLables() {
    if (rand.nextDouble() < 0.1) {
      graph.options.dataLabels = true;
    }
    return this;
  }

  RandomFactory randomAxesLables() {
    if (rand.nextDouble() < 0.2) {
      graph.options.scales.makeLabelsShow();
    }
    return this;
  }

  RandomFactory randTwoAxes() {
    if (rand.nextDouble() < 0.05) {
      graph.options.scales.createYScale("y2", "right");
      graph.addYAxisRelation("y2");
    }
    return this;
  }

  RandomFactory setLabels(SavedFormData savedFormData) {
    if (savedFormData.hasXAxes) {
      graphFactory.setLabels(savedFormData.savedXAxes);
    } else {
      graphFactory.randomLabels();
    }

    return this;
  }

  RandomFactory randomColours() {
    graphFactory.allRandomColours();

    return this;
  }

  RandomFactory defaultScales() {
    graphFactory.defaultScales();

    return this;
  }

  RandomFactory setGraph(SavedFormData savedFormData) {
    if (savedFormData.savedTypeData.type == "bar") {
      graph = _barGraph(savedFormData);
    } else if (savedFormData.savedTypeData.type == "line") {
      graph = _lineGraph(savedFormData);
    } else {
      graph = _chooseGraph();
    }
    return this;
  }

  Graph getGraph() {
    return graph;
  }

  Graph _lineGraph(SavedFormData savedFormData) {
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

    return aLine;
  }

  Graph _barGraph(SavedFormData savedFormData) {
    // if title is null (??), generate one randomly
    GraphFactory graphFactory =
        new GraphFactory(savedFormData.graphName ?? RandomString.randTitle());

    addDataSets(savedFormData.savedDataSets);
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

    return aBar;
  }
}
