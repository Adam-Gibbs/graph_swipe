import 'package:flutter/material.dart';
import 'package:graph_swipe/page_data/form/save_data/saved_data_sets.dart';
import 'package:graph_swipe/page_data/form/save_data/saved_form_data.dart';

class SaveFormHelper {
  final SavedFormData savedFormData;
  static const List<String> ACCEPTABLECHARS = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    ".",
    "-"
  ];

  SaveFormHelper(this.savedFormData);

  void saveName(String? name) {
    savedFormData.graphName = name;
  }

  void saveXAxes(String? label, bool? labelDisplay, bool? displayAxes,
      String? axesPosition, String? values) {
    savedFormData.savedXAxes.label = label;
    savedFormData.savedXAxes.displayLabel = labelDisplay;
    savedFormData.savedXAxes.display = displayAxes;
    savedFormData.savedXAxes.position = axesPosition?.toLowerCase();

    String tempString = values ?? "";
    // Remove chars
    // tempString.replaceAll(
    //     new RegExp(r'qwertyuiopasdfghjklzxcvbnm[#*)(@!^&%.$\s]+'), "");
    // Remove spaces after commas
    tempString.replaceAll(", ", ",");
    List<String> tempStringList = tempString.split(",");
    // If temp list empty, just make null and deal with later
    savedFormData.xAxisValues =
        tempStringList.length == 0 ? null : tempStringList;

    savedFormData.hasXAxes = true;
  }

  void saveDataSet(
      String? name, String? data, bool? chooseColour, Color? colour) {
    SavedDataSet savedDataSet = new SavedDataSet();
    savedDataSet.name = name;
    // if colour value is null, save black
    savedDataSet.colour = [
      colour?.red ?? 255,
      colour?.green ?? 255,
      colour?.blue ?? 255
    ];
    savedDataSet.tansparency = colour?.opacity;

    String tempString = data ?? "";
    List<double> tempDoubleList = [];
    List<String> tempStringList = tempString.split(",");
    // Remove all non digits from string
    // TODO: This is very inefficit and ugly, look into regex
    tempStringList.forEach((element) {
      String newElement = "";
      element.characters.forEach((char) {
        if (ACCEPTABLECHARS.contains(char)) {
          newElement += char;
        }
      });
      try {
        tempDoubleList.add(double.parse(newElement));
        print("Following was a number: " + element + " we got: " + newElement);
      } catch (FormatException) {
        print("Following is not a number: " +
            element +
            " best we got was: " +
            newElement);
      }
    });
    // If temp list empty, just make null and deal with later
    savedDataSet.data = tempDoubleList.length == 0 ? null : tempDoubleList;

    savedFormData.savedDataSets.add(savedDataSet);
    savedFormData.hasDataSets = true;
  }

  void saveYAxes(String? label, bool? labelDisplay, bool? displayAxes,
      String? axesPosition) {
    savedFormData.savedYAxes.label = label;
    savedFormData.savedYAxes.displayLabel = labelDisplay;
    savedFormData.savedYAxes.display = displayAxes;
    savedFormData.savedYAxes.position = axesPosition?.toLowerCase();

    savedFormData.hasYAxes = true;
  }

  void saveType(
      String? type,
      bool? chooseColour,
      Color? colour,
      bool? boldBorder,
      bool? roundedBars,
      bool? displayLines,
      bool? lineFill,
      String? lineStyle,
      String? pointToPoint,
      String? pointStyle) {
    if (type == "Random") {
      savedFormData.hasType = false;
      return;
    }
    savedFormData.savedTypeData.type = type?.toLowerCase();

    // Bar Graph Options
    savedFormData.savedTypeData.isBorderColour = chooseColour;
    savedFormData.savedTypeData.borderColour = [
      colour?.red ?? 255,
      colour?.green ?? 255,
      colour?.blue ?? 255
    ];
    savedFormData.savedTypeData.borderTransparency = colour?.opacity;
    savedFormData.savedTypeData.boldBorders = boldBorder;
    savedFormData.savedTypeData.roundBars = roundedBars;

    // Line Graph Options
    savedFormData.savedTypeData.displayLines = displayLines;
    savedFormData.savedTypeData.fill = lineFill;
    savedFormData.savedTypeData.lineStyle = lineStyle;
    savedFormData.savedTypeData.pointToPoint = pointToPoint;
    savedFormData.savedTypeData.pointStyle = pointStyle;

    savedFormData.hasType = true;
  }
}
