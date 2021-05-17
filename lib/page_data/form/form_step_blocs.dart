import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:graph_swipe/page_data/form/form_fields.dart';

class FormStepBlocs {
  static bool isLine() {
    return true;
  }

  static FormBlocStep generalStep(FormFields wizardFormBloc) {
    return FormBlocStep(
        title: Text('General'),
        content: Card(
            color: Colors.white,
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextFieldBlocBuilder(
                    textFieldBloc: wizardFormBloc.title,
                    keyboardType: TextInputType.text,
                    isEnabled: isLine(),
                    enableOnlyWhenFormBlocCanSubmit: true,
                    decoration: InputDecoration(
                      labelText: 'Graph Title',
                      prefixIcon: Icon(Icons.title),
                    ),
                  ),
                ],
              ),
            )));
  }
}
