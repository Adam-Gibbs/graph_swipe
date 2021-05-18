import 'package:flutter/material.dart';
import 'package:graph_swipe/page_data/form/save_data/saved_data_sets.dart';
import 'package:graph_swipe/page_data/form/save_data/saved_form_data.dart';

class SaveFormHelper {
  final SavedFormData savedFormData;

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
    // Remove chars
    tempString.replaceAll(
        new RegExp(r'qwertyuiopasdfghjklzxcvbnm[#*_)(@!^&%.$\s]+'), "");
    // Remove spaces
    tempString.replaceAll(" ", "");
    List<double> tempDoubleList = [];
    tempString
        .split(",")
        .forEach((element) => {tempDoubleList.add(double.parse(element))});
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
}
