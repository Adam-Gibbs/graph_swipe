import 'package:graph_swipe/graphs/data/sets/data_set.dart';
import 'package:graph_swipe/graphs/data/sets/data_set_bar.dart';
import 'package:graph_swipe/graphs/data/sets/data_set_line.dart';

class DataSetUpgrader {
  static DataSet toBase(DataSet dataSet) {
    DataSet upgradeSet = new DataSet(dataSet.label,
        colour: dataSet.mainColour, transparency: dataSet.transparency);
    upgradeSet.setDataList(dataSet.data);
    return upgradeSet;
  }

  static DataSetBar toBar(DataSet dataSet,
      {List<int> borderColour = DataSet.defaultColour,
      double borderWidth = 1,
      String yAxis = "y"}) {
    DataSetBar upgradeSet = new DataSetBar(dataSet.label,
        colour: dataSet.mainColour,
        transparency: dataSet.transparency,
        borderColour: borderColour,
        borderWidth: borderWidth,
        yAxis: yAxis);
    upgradeSet.setDataList(dataSet.data);
    return upgradeSet;
  }

  static List<DataSetBar> groupToBar(List<DataSet> dataSetList) {
    List<DataSetBar> tempDataSets = [];
    dataSetList.forEach(
        (element) => {tempDataSets.add(DataSetUpgrader.toBar(element))});
    return tempDataSets;
  }

  static DataSetLine toLine(DataSet dataSet,
      {List<int> lineColour = DataSet.defaultColour,
      bool fill = false,
      bool stepped = false,
      bool dashed = false,
      bool curved = false,
      bool showLine = true,
      String pointStyle = 'circle',
      int pointRadius = 3,
      String yAxis = "y"}) {
    DataSetLine upgradeSet = new DataSetLine(dataSet.label,
        colour: dataSet.mainColour,
        transparency: dataSet.transparency,
        lineColour: lineColour,
        fill: fill,
        stepped: stepped,
        dashed: dashed,
        curved: curved,
        showLine: showLine,
        pointStyle: pointStyle,
        pointRadius: pointRadius,
        yAxis: yAxis);
    upgradeSet.setDataList(dataSet.data);
    return upgradeSet;
  }

  static List<DataSetLine> groupToLine(List<DataSet> dataSetList) {
    List<DataSetLine> tempDataSets = [];
    dataSetList.forEach(
        (element) => {tempDataSets.add(DataSetUpgrader.toLine(element))});
    return tempDataSets;
  }
}
