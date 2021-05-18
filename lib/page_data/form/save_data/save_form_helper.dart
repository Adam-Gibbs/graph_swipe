import 'package:graph_swipe/page_data/form/save_data/saved_form_data.dart';

class SaveFormHelper {
  final SavedFormData savedFormData;

  SaveFormHelper(this.savedFormData);

  saveName(String name) {
    savedFormData.graphName = name;
  }
}
