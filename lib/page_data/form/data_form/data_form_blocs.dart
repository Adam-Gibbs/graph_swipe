import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:graph_swipe/page_data/form/data_form/data_form_fields.dart';
import 'package:graph_swipe/page_data/form/form_fields.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:graph_swipe/page_data/page_size.dart';
import 'package:graph_swipe/pages/data_page.dart';

Widget dataSetFormDefaultStart() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Data Set #1',
          style: TextStyle(fontSize: 20),
        ),
      ),
    ],
  );
}

Widget dataSetFormStart(int index, VoidCallback onRemoveDataSet) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Data Set #${index + 1}',
          style: TextStyle(fontSize: 20),
        ),
      ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: onRemoveDataSet,
      ),
    ],
  );
}

List<Widget> dataSetForm(DataSetFieldBloc dataSetField, BuildContext context,
    DataPageState dataPage) {
  void setColour(Color colour) {
    dataSetField.colour = colour;
    dataPage.changeColor(colour);
  }

  return [
    TextFieldBlocBuilder(
      textFieldBloc: dataSetField.dataSetName,
      decoration: InputDecoration(
        labelText: 'Data Set Name',
      ),
    ),
    TextFieldBlocBuilder(
      textFieldBloc: dataSetField.data,
      decoration: InputDecoration(
        labelText: 'Data, comma separated values',
      ),
    ),
    SwitchFieldBlocBuilder(
      booleanFieldBloc: dataSetField.chooseColour,
      body: Container(
        alignment: Alignment.centerLeft,
        child: Text('Specify Data Colour'),
      ),
    ),
    ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                titlePadding: const EdgeInsets.all(0.0),
                contentPadding: const EdgeInsets.all(0.0),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: dataSetField.colour,
                    onColorChanged: setColour,
                    colorPickerWidth: PageSize.getWidth(context) * 0.7,
                    pickerAreaHeightPercent: 0.8,
                    enableAlpha: true,
                    displayThumbColor: true,
                    showLabel: true,
                    paletteType: PaletteType.hsv,
                    pickerAreaBorderRadius: const BorderRadius.only(
                      topLeft: const Radius.circular(2.0),
                      topRight: const Radius.circular(2.0),
                    ),
                  ),
                ),
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
            primary: dataSetField.colour,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        child: const Text('Choose Colour')),
    // BlocBuilder<ListFieldBloc<TextFieldBloc>,
    //     ListFieldBlocState<TextFieldBloc>>(
    //   bloc: dataSetField.hobbies,
    //   builder: (context, state) {
    //     if (state.fieldBlocs.isNotEmpty) {
    //       return ListView.builder(
    //         shrinkWrap: true,
    //         physics: NeverScrollableScrollPhysics(),
    //         itemCount: state.fieldBlocs.length,
    //         itemBuilder: (context, i) {
    //           final hobbyFieldBloc = state.fieldBlocs[i];
    //           return Card(
    //             color: Colors.blue[100],
    //             child: Row(
    //               children: <Widget>[
    //                 Expanded(
    //                   child: TextFieldBlocBuilder(
    //                     textFieldBloc: hobbyFieldBloc,
    //                     decoration: InputDecoration(
    //                       labelText: 'Hobby #${i + 1}',
    //                     ),
    //                   ),
    //                 ),
    //                 IconButton(
    //                   icon: Icon(Icons.delete),
    //                   onPressed: () =>
    //                       dataSetField.hobbies.removeFieldBlocAt(i),
    //                 ),
    //               ],
    //             ),
    //           );
    //         },
    //       );
    //     }
    //     return Container();
    //   },
    // ),
    // TextButton(
    //   onPressed: onAddHobby,
    //   child: Text('ADD HOBBY'),
    // )
  ];
}

List<Widget> combineDataSetForm(Widget startForm, List<Widget> endForm) {
  List<Widget> tempForm = [startForm];
  tempForm.addAll(endForm);
  return tempForm;
}

class DefaultDataSetCard extends StatelessWidget {
  final DataSetFieldBloc dataSetField;
  final FormFields wizardFormBloc;
  final DataPageState dataPage;

  const DefaultDataSetCard(
      {required this.dataSetField,
      required this.wizardFormBloc,
      required this.dataPage});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            children: combineDataSetForm(dataSetFormDefaultStart(),
                dataSetForm(dataSetField, context, dataPage))),
      ),
    );
  }
}

class DataSetCard extends StatelessWidget {
  final int dataSetIndex;
  final DataSetFieldBloc dataSetField;
  final DataPageState dataPage;
  final VoidCallback onRemoveDataSet;

  const DataSetCard(
      {required this.dataSetIndex,
      required this.dataSetField,
      required this.onRemoveDataSet,
      required this.dataPage});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[100],
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            children: combineDataSetForm(
                dataSetFormStart(dataSetIndex, onRemoveDataSet),
                dataSetForm(dataSetField, context, dataPage))),
      ),
    );
  }
}