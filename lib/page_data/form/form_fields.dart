import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:graph_swipe/page_data/form/data_form/data_form_fields.dart';

// From https://github.com/GiancarloCode/form_bloc
class FormFields extends FormBloc<String, String> {
  final title = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  var dataSets = ListFieldBloc<DataSetFieldBloc>();

  final gender = SelectFieldBloc(
    items: ['Male', 'Female'],
  );

  FormFields() {
    addFieldBlocs(
      step: 0,
      fieldBlocs: [title],
    );
    addFieldBlocs(
      step: 1,
      fieldBlocs: [dataSets],
    );
  }

  DataSetFieldBloc getDataSet() {
    return DataSetFieldBloc(
        dataSetName: TextFieldBloc(validators: [FieldBlocValidators.required]),
        data: TextFieldBloc(validators: [FieldBlocValidators.required]),
        chooseColour: BooleanFieldBloc(),
        colour: Colors.blue);
  }

  void addDataSet() {
    dataSets.addFieldBloc(DataSetFieldBloc(
        dataSetName: TextFieldBloc(validators: [FieldBlocValidators.required]),
        data: TextFieldBloc(validators: [FieldBlocValidators.required]),
        chooseColour: BooleanFieldBloc(),
        colour: Colors.blue));
  }

  void removeDataSet(int index) {
    dataSets.removeFieldBlocAt(index);
  }

  @override
  void onSubmitting() async {
    // TODO: Save to Explore
    emitSuccess();
  }
}
