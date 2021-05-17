import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class DataSetFieldBloc extends GroupFieldBloc {
  final TextFieldBloc dataSetName;
  final TextFieldBloc data;
  final BooleanFieldBloc chooseColour;
  Color colour;

  DataSetFieldBloc(
      {required this.dataSetName,
      required this.data,
      required this.chooseColour,
      required this.colour})
      : super([dataSetName, data, chooseColour]);
}
