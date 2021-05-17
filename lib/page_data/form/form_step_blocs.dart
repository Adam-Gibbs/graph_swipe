import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:graph_swipe/page_data/form/data_form/data_form_blocs.dart';
import 'package:graph_swipe/page_data/form/data_form/data_form_fields.dart';
import 'package:graph_swipe/page_data/form/form_fields.dart';
import 'package:graph_swipe/pages/data_page.dart';

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

  static FormBlocStep dataSetsStep(
      FormFields wizardFormBloc, DataPageState dataPage) {
    return FormBlocStep(
      title: Text('Data'),
      content: Column(
        children: <Widget>[
          BlocBuilder<ListFieldBloc<DataSetFieldBloc>,
                  ListFieldBlocState<DataSetFieldBloc>>(
              bloc: wizardFormBloc.dataSets,
              builder: (context, state) {
                if (state.fieldBlocs.length > 0) {
                  return DefaultDataSetCard(
                      dataSetField: state.fieldBlocs[0],
                      wizardFormBloc: wizardFormBloc,
                      dataPage: dataPage);
                } else {
                  state.fieldBlocs.add(wizardFormBloc.getDataSet());
                  return DefaultDataSetCard(
                      dataSetField: state.fieldBlocs[0],
                      wizardFormBloc: wizardFormBloc,
                      dataPage: dataPage);
                }
              }),
          BlocBuilder<ListFieldBloc<DataSetFieldBloc>,
              ListFieldBlocState<DataSetFieldBloc>>(
            bloc: wizardFormBloc.dataSets,
            builder: (context, state) {
              if (state.fieldBlocs.length > 1) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.fieldBlocs.length - 1,
                    itemBuilder: (context, i) {
                      return DataSetCard(
                          dataSetIndex: i + 1,
                          dataSetField: state.fieldBlocs[i + 1],
                          onRemoveDataSet: () =>
                              wizardFormBloc.removeDataSet(i + 1),
                          dataPage: dataPage);
                    });
              }
              return Container();
            },
          ),
          ElevatedButton(
            onPressed: wizardFormBloc.addDataSet,
            child: Text('ADD DATA SET'),
          ),
        ],
      ),
    );
  }
}
