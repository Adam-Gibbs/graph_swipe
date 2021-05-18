import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:graph_swipe/page_data/form/data_form/data_form_blocs.dart';
import 'package:graph_swipe/page_data/form/data_form/data_form_fields.dart';
import 'package:graph_swipe/page_data/form/form_fields.dart';
import 'package:graph_swipe/page_data/page_size.dart';
import 'package:graph_swipe/pages/data_page.dart';

class FormStepBlocs {
  static const double CURVEDEDGE = 15;
  static bool isLine() {
    return true;
  }

  static FormBlocStep generalStep(FormFields wizardFormBloc) {
    return FormBlocStep(
        title: Text('General'),
        content: Card(
            color: Colors.white,
            margin: const EdgeInsets.all(CURVEDEDGE),
            child: Padding(
              padding: const EdgeInsets.all(CURVEDEDGE),
              child: Column(
                children: <Widget>[
                  TextFieldBlocBuilder(
                    textFieldBloc: wizardFormBloc.title,
                    keyboardType: TextInputType.text,
                    isEnabled: isLine(),
                    enableOnlyWhenFormBlocCanSubmit: true,
                    decoration: InputDecoration(
                      labelText: 'Graph Title (Blank for random)',
                      prefixIcon: Icon(Icons.title),
                    ),
                  ),
                ],
              ),
            )));
  }

  static FormBlocStep xAxesStep(FormFields wizardFormBloc) {
    return FormBlocStep(
        title: Text('X Axes'),
        content: Card(
            color: Colors.white,
            margin: const EdgeInsets.all(CURVEDEDGE),
            child: Padding(
              padding: const EdgeInsets.all(CURVEDEDGE),
              child: Column(
                children: <Widget>[
                  TextFieldBlocBuilder(
                    textFieldBloc: wizardFormBloc.xAxesLabel,
                    keyboardType: TextInputType.text,
                    enableOnlyWhenFormBlocCanSubmit: true,
                    decoration: InputDecoration(
                      labelText: 'Label',
                      prefixIcon: Icon(Icons.label),
                    ),
                  ),
                  SwitchFieldBlocBuilder(
                    booleanFieldBloc: wizardFormBloc.xAxesDisplayLabel,
                    body: Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Display Label'),
                    ),
                  ),
                  SwitchFieldBlocBuilder(
                    booleanFieldBloc: wizardFormBloc.xAxesDisplayAxes,
                    body: Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Display X Axes'),
                    ),
                  ),
                  DropdownFieldBlocBuilder<String>(
                    selectFieldBloc: wizardFormBloc.xAxesPosition,
                    itemBuilder: (context, value) => value,
                    decoration: InputDecoration(
                      labelText: 'Axes Position',
                      prefixIcon: Icon(Icons.swap_vert),
                    ),
                  ),
                  TextFieldBlocBuilder(
                    textFieldBloc: wizardFormBloc.xAxesValues,
                    keyboardType: TextInputType.text,
                    enableOnlyWhenFormBlocCanSubmit: true,
                    decoration: InputDecoration(
                      labelText: 'Values, comma separated',
                      prefixIcon: Icon(Icons.text_format),
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
                      dataSetField: state.fieldBlocs[0], dataPage: dataPage);
                } else {
                  state.fieldBlocs.add(wizardFormBloc.getDataSet());
                  return DefaultDataSetCard(
                      dataSetField: state.fieldBlocs[0], dataPage: dataPage);
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

  static FormBlocStep yAxesStep(FormFields wizardFormBloc) {
    return FormBlocStep(
        title: Text('Y Axes'),
        content: Card(
            color: Colors.white,
            margin: const EdgeInsets.all(CURVEDEDGE),
            child: Padding(
              padding: const EdgeInsets.all(CURVEDEDGE),
              child: Column(
                children: <Widget>[
                  TextFieldBlocBuilder(
                    textFieldBloc: wizardFormBloc.yAxesLabel,
                    keyboardType: TextInputType.text,
                    enableOnlyWhenFormBlocCanSubmit: true,
                    decoration: InputDecoration(
                      labelText: 'Label',
                      prefixIcon: Icon(Icons.label),
                    ),
                  ),
                  SwitchFieldBlocBuilder(
                    booleanFieldBloc: wizardFormBloc.yAxesDisplayLabel,
                    body: Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Display Label'),
                    ),
                  ),
                  SwitchFieldBlocBuilder(
                    booleanFieldBloc: wizardFormBloc.yAxesDisplayAxes,
                    body: Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Display Y Axes'),
                    ),
                  ),
                  DropdownFieldBlocBuilder<String>(
                    selectFieldBloc: wizardFormBloc.yAxesPosition,
                    itemBuilder: (context, value) => value,
                    decoration: InputDecoration(
                      labelText: 'Axes Position',
                      prefixIcon: Icon(Icons.swap_horiz),
                    ),
                  ),
                ],
              ),
            )));
  }

  static FormBlocStep typeStep(
      FormFields wizardFormBloc, BuildContext context, DataPageState dataPage) {
    void setBarColour(Color colour) {
      wizardFormBloc.borderColour = colour;
      dataPage.changeColor(colour);
    }

    Widget getColourButtons(BuildContext context, DataPageState dataPage) {
      if (wizardFormBloc.chooseBorderColour.value!) {
        return ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    titlePadding: const EdgeInsets.all(0.0),
                    contentPadding: const EdgeInsets.all(0.0),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: wizardFormBloc.borderColour,
                        onColorChanged: setBarColour,
                        colorPickerWidth: PageSize.getWidth(context) * 0.7,
                        pickerAreaHeightPercent: 0.8,
                        enableAlpha: true,
                        displayThumbColor: true,
                        showLabel: true,
                        paletteType: PaletteType.hsv,
                        pickerAreaBorderRadius: const BorderRadius.only(
                          topLeft: const Radius.circular(CURVEDEDGE),
                          topRight: const Radius.circular(CURVEDEDGE),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
                primary: wizardFormBloc.borderColour,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            child: const Text('Border Colour'));
      } else {
        return Container();
      }
    }

    List<Widget> getTypeForm(BuildContext context, DataPageState dataPage) {
      List<Widget> tempWidgetList = [
        RadioButtonGroupFieldBlocBuilder<String>(
          selectFieldBloc: wizardFormBloc.chartType,
          itemBuilder: (context, value) => value,
          decoration: InputDecoration(
            labelText: 'Chart Type',
          ),
        ),
        SwitchFieldBlocBuilder(
          booleanFieldBloc: wizardFormBloc.chooseBorderColour,
          body: Container(
            alignment: Alignment.centerLeft,
            child: Text('Choose Border Colour'),
          ),
        )
      ];

      tempWidgetList.add(getColourButtons(context, dataPage));

      tempWidgetList.addAll([
        SwitchFieldBlocBuilder(
          booleanFieldBloc: wizardFormBloc.boldBorder,
          body: Container(
            alignment: Alignment.centerLeft,
            child: Text('Bold Border'),
          ),
        ),
        SwitchFieldBlocBuilder(
          booleanFieldBloc: wizardFormBloc.roundedBars,
          body: Container(
            alignment: Alignment.centerLeft,
            child: Text('Rounded Bars'),
          ),
        ),
        SwitchFieldBlocBuilder(
          booleanFieldBloc: wizardFormBloc.displayLines,
          body: Container(
            alignment: Alignment.centerLeft,
            child: Text('Display Lines'),
          ),
        ),
        SwitchFieldBlocBuilder(
          booleanFieldBloc: wizardFormBloc.filledLine,
          body: Container(
            alignment: Alignment.centerLeft,
            child: Text('Fill Under Lines'),
          ),
        ),
        DropdownFieldBlocBuilder<String>(
          selectFieldBloc: wizardFormBloc.drawnLine,
          itemBuilder: (context, value) => value,
          decoration: InputDecoration(
            labelText: 'Line Style',
            prefixIcon: Icon(Icons.line_style),
          ),
        ),
        DropdownFieldBlocBuilder<String>(
          selectFieldBloc: wizardFormBloc.pointToPointLine,
          itemBuilder: (context, value) => value,
          decoration: InputDecoration(
            labelText: 'Point to Point Style',
            prefixIcon: Icon(Icons.linear_scale),
          ),
        ),
        DropdownFieldBlocBuilder<String>(
          selectFieldBloc: wizardFormBloc.pointShapes,
          itemBuilder: (context, value) => value,
          decoration: InputDecoration(
            labelText: 'Point Style',
            prefixIcon: Icon(Icons.circle),
          ),
        ),
      ]);

      return tempWidgetList;
    }

    return FormBlocStep(
        title: Text('Graph Type'),
        content: Card(
            color: Colors.white,
            margin: const EdgeInsets.all(CURVEDEDGE),
            child: Padding(
              padding: const EdgeInsets.all(CURVEDEDGE),
              child: Column(
                children: getTypeForm(context, dataPage),
              ),
            )));
  }

  static FormBlocStep optionsStep(FormFields wizardFormBloc) {
    return FormBlocStep(
        title: Text('Options'),
        content: Card(
            color: Colors.white,
            margin: const EdgeInsets.all(CURVEDEDGE),
            child: Padding(
              padding: const EdgeInsets.all(CURVEDEDGE),
              child: Column(
                children: <Widget>[
                  SwitchFieldBlocBuilder(
                    booleanFieldBloc: wizardFormBloc.displayTitle,
                    body: Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Display Graph Title'),
                    ),
                  ),
                  SwitchFieldBlocBuilder(
                    booleanFieldBloc: wizardFormBloc.displayLegend,
                    body: Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Display Legend'),
                    ),
                  ),
                  DropdownFieldBlocBuilder<String>(
                    selectFieldBloc: wizardFormBloc.legendPosition,
                    itemBuilder: (context, value) => value,
                    decoration: InputDecoration(
                      labelText: 'Legend Position',
                      prefixIcon: Icon(Icons.swap_calls),
                    ),
                  ),
                  SwitchFieldBlocBuilder(
                    booleanFieldBloc: wizardFormBloc.displayDataLabels,
                    body: Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Display Data Labels'),
                    ),
                  ),
                ],
              ),
            )));
  }
}
