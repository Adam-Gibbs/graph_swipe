import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:graph_swipe/pages/data_page.dart';

class DataSetFieldBloc extends GroupFieldBloc {
  final TextFieldBloc dataSetName;
  final TextFieldBloc data;
  final BooleanFieldBloc chooseColour;
  Color colour;
  final DataPageState dataPage;

  DataSetFieldBloc(
      {required this.dataSetName,
      required this.data,
      required this.chooseColour,
      required this.colour,
      required this.dataPage})
      : super([dataSetName, data, chooseColour]) {
    this.chooseColour.onValueChanges(onData: (previous, current) async* {
      dataPage.changeColor(Colors.blue);
    });
  }
}
