import 'package:graph_swipe/page_data/form/save_data/saved_form_data.dart';

class SaveFormHelper {
  final SavedFormData savedFormData;

  SaveFormHelper(this.savedFormData);

  void saveName(String? name) {
    savedFormData.graphName = name;
  }

  void saveXAxes(String? label, bool? labelDisplay, bool? displayXAxes,
      String? axesPosition, String? values) {
    savedFormData.savedXAxes.label = label;
    savedFormData.savedXAxes.displayLabel = labelDisplay;
    savedFormData.savedXAxes.display = displayXAxes;
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
}
