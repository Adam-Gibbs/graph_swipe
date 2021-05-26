import 'package:graph_swipe/page_data/form/save_data/saved%20_axes.dart';
import 'package:graph_swipe/page_data/form/save_data/saved_data_sets.dart';
import 'package:graph_swipe/page_data/form/save_data/saved_options_data.dart';
import 'package:graph_swipe/page_data/form/save_data/saved_type_data.dart';

class SavedFormData {
  // General
  String? graphName;

  // X Axis
  bool hasXAxes = false;
  final SavedAxes savedXAxes = new SavedAxes();
  List<String>? xAxisValues;

  // DataSets
  bool hasDataSets = false;
  List<SavedDataSet>? savedDataSets;

  // Y Axis
  bool hasYAxes = false;
  final SavedAxes savedYAxes = new SavedAxes();

  // Type
  bool hasType = false;
  final SavedTypeData savedTypeData = new SavedTypeData();

  // Options
  bool hasOptions = false;
  final SavedOptionsData savedOptionsData = new SavedOptionsData();
}
