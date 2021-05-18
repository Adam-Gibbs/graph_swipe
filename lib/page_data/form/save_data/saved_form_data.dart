import 'package:graph_swipe/page_data/form/save_data/saved%20_axes.dart';

class SavedFormData {
  // General
  String? graphName;

  // X Axis
  bool hasXAxes = false;
  final SavedAxes savedXAxes = new SavedAxes();
  List<String>? xAxisValues;

  // Y Axis
  bool hasYAxes = false;
  final SavedAxes savedYAxes = new SavedAxes();
}
