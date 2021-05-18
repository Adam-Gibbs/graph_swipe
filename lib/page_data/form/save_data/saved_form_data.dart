import 'package:graph_swipe/page_data/form/save_data/saved%20_x_axes.dart';

class SavedFormData {
  // General
  String? graphName;

  // XAxis
  bool hasXAxes = false;
  final SavedXAxes savedXAxes = new SavedXAxes();
  List<String>? xAxisValues;
}
