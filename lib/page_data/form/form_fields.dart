import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:graph_swipe/page_data/form/data_form/data_form_fields.dart';
import 'package:graph_swipe/page_data/form/save_data/save_form_helper.dart';
import 'package:graph_swipe/pages/data_page.dart';

// From https://github.com/GiancarloCode/form_bloc
class FormFields extends FormBloc<String, String> {
  final DataPageState dataPage;
  final SaveFormHelper saveFormHelper;
  late TextFieldBloc title;
  late ListFieldBloc<DataSetFieldBloc> dataSets;
  late TextFieldBloc xAxesValues;
  late TextFieldBloc xAxesLabel;
  late BooleanFieldBloc xAxesDisplayLabel;
  late BooleanFieldBloc xAxesDisplayAxes;
  late SelectFieldBloc<String, dynamic> xAxesPosition;
  late TextFieldBloc yAxesLabel;
  late BooleanFieldBloc yAxesDisplayLabel;
  late BooleanFieldBloc yAxesDisplayAxes;
  late SelectFieldBloc<String, dynamic> yAxesPosition;
  late BooleanFieldBloc yStartZero;
  late SelectFieldBloc<String, dynamic> chartType;
  late BooleanFieldBloc chooseBorderColour;
  late BooleanFieldBloc boldBorder;
  late BooleanFieldBloc roundedBars;
  late SelectFieldBloc<String, dynamic> pointShapes;
  late BooleanFieldBloc displayLines;
  late SelectFieldBloc<String, dynamic> drawnLine;
  late SelectFieldBloc<String, dynamic> pointToPointLine;
  late BooleanFieldBloc filledLine;
  late BooleanFieldBloc displayTitle;
  late BooleanFieldBloc displayLegend;
  late SelectFieldBloc<String, dynamic> legendPosition;
  late BooleanFieldBloc displayDataLabels;
  late BooleanFieldBloc stacked;

  Color borderColour = Colors.blue;

  FormFields(this.dataPage, this.saveFormHelper) {
    title = TextFieldBloc(
        initialValue: saveFormHelper.savedFormData.graphName ?? "");

    dataSets = ListFieldBloc<DataSetFieldBloc>();

    xAxesValues = TextFieldBloc(
      validators: [FieldBlocValidators.required],
    );

    xAxesLabel = TextFieldBloc(
      validators: [FieldBlocValidators.required],
    );

    xAxesDisplayLabel = BooleanFieldBloc();

    xAxesDisplayAxes = BooleanFieldBloc(initialValue: true);

    xAxesPosition = SelectFieldBloc(
      items: ['Top', 'Bottom'],
      initialValue: 'Bottom',
      validators: [FieldBlocValidators.required],
    );

    yAxesLabel = TextFieldBloc(
      validators: [FieldBlocValidators.required],
    );

    yAxesDisplayLabel = BooleanFieldBloc();

    yAxesDisplayAxes = BooleanFieldBloc(initialValue: true);

    yAxesPosition = SelectFieldBloc(
      items: ['Left', 'Right'],
      initialValue: 'Left',
      validators: [FieldBlocValidators.required],
    );

    yStartZero = BooleanFieldBloc(initialValue: true);

    chartType = SelectFieldBloc(
      items: ['Bar', 'Line', 'Random'],
      initialValue: 'Random',
      validators: [FieldBlocValidators.required],
    );

    chooseBorderColour = BooleanFieldBloc();

    boldBorder = BooleanFieldBloc();

    roundedBars = BooleanFieldBloc();

    pointShapes = SelectFieldBloc(
      items: ['Circle', 'Star', 'Triangle', 'Random'],
      initialValue: 'Random',
      validators: [FieldBlocValidators.required],
    );

    displayLines = BooleanFieldBloc(initialValue: true);

    drawnLine = SelectFieldBloc(
      items: ['Dashed', 'Solid', 'Random'],
      initialValue: 'Random',
      validators: [FieldBlocValidators.required],
    );

    pointToPointLine = SelectFieldBloc(
      items: ['Curved', 'Straight', 'Stepped', 'Random'],
      initialValue: 'Random',
      validators: [FieldBlocValidators.required],
    );

    filledLine = BooleanFieldBloc();

    displayTitle = BooleanFieldBloc(initialValue: true);
    displayLegend = BooleanFieldBloc(initialValue: true);

    legendPosition = SelectFieldBloc(
      items: ['Top', 'Bottom', 'Left', 'Right'],
      initialValue: 'Bottom',
      validators: [FieldBlocValidators.required],
    );
    displayDataLabels = BooleanFieldBloc();

    stacked = BooleanFieldBloc();

    addFieldBlocs(
      step: 0,
      fieldBlocs: [title],
    );
    addFieldBlocs(
      step: 1,
      fieldBlocs: [
        xAxesValues,
        xAxesLabel,
        xAxesDisplayLabel,
        xAxesDisplayAxes,
        xAxesPosition
      ],
    );
    addFieldBlocs(
      step: 2,
      fieldBlocs: [dataSets],
    );
    addFieldBlocs(
      step: 3,
      fieldBlocs: [
        yAxesLabel,
        yAxesDisplayLabel,
        yAxesDisplayAxes,
        yAxesPosition,
        yStartZero
      ],
    );
    addFieldBlocs(
      step: 4,
      fieldBlocs: [chartType],
    );
    addFieldBlocs(
      step: 5,
      fieldBlocs: [
        displayTitle,
        displayLegend,
        legendPosition,
        displayDataLabels,
        stacked
      ],
    );

    List<FieldBloc> barOptions = [chooseBorderColour, boldBorder, roundedBars];
    List<FieldBloc> lineOptions = [displayLines, pointShapes];
    List<FieldBloc> displayLineOptions = [
      drawnLine,
      pointToPointLine,
      filledLine
    ];

    chartType.onValueChanges(
      onData: (previous, current) async* {
        if (current.value == 'Bar') {
          addFieldBlocs(step: 4, fieldBlocs: barOptions);
          removeFieldBlocs(fieldBlocs: lineOptions);
          removeFieldBlocs(fieldBlocs: displayLineOptions);
        } else if (current.value == 'Line') {
          addFieldBlocs(step: 4, fieldBlocs: lineOptions);
          removeFieldBlocs(fieldBlocs: barOptions);
          if (displayLines.value!) {
            addFieldBlocs(step: 4, fieldBlocs: displayLineOptions);
          }
          chooseBorderColour.clear();
        } else {
          // Adds both options and flattens both to single list
          // from https://stackoverflow.com/a/15413493
          removeFieldBlocs(fieldBlocs: barOptions);
          removeFieldBlocs(fieldBlocs: lineOptions);
          removeFieldBlocs(fieldBlocs: displayLineOptions);
          chooseBorderColour.clear();
        }
      },
    );

    chooseBorderColour.onValueChanges(onData: (previous, current) async* {
      dataPage.changeColor(Colors.blue);
    });

    displayLines.onValueChanges(
      onData: (previous, current) async* {
        if (current.value!) {
          addFieldBlocs(step: 5, fieldBlocs: displayLineOptions);
        } else {
          removeFieldBlocs(fieldBlocs: displayLineOptions);
        }
      },
    );

    displayLegend.onValueChanges(
      onData: (previous, current) async* {
        if (current.value!) {
          addFieldBlocs(step: 5, fieldBlocs: [legendPosition]);
        } else {
          removeFieldBlocs(fieldBlocs: [legendPosition]);
        }
      },
    );
  }

  DataSetFieldBloc getDataSet(int index) {
    return DataSetFieldBloc(
        dataSetName: TextFieldBloc(
            validators: [FieldBlocValidators.required],
            initialValue:
                saveFormHelper.savedFormData.savedDataSets?[index].name),
        data: TextFieldBloc(
            validators: [FieldBlocValidators.required],
            initialValue: saveFormHelper
                .savedFormData.savedDataSets?[index].data
                .toString()),
        chooseColour: BooleanFieldBloc(
            initialValue: saveFormHelper
                .savedFormData.savedDataSets?[index].chooseColour),
        colour: Color.fromARGB(
            (saveFormHelper.savedFormData.savedDataSets?[index].tansparency ??
                        0.8)
                    .toInt() *
                255,
            saveFormHelper.savedFormData.savedDataSets?[index].colour?[0] ?? 33,
            saveFormHelper.savedFormData.savedDataSets?[index].colour?[1] ??
                150,
            saveFormHelper.savedFormData.savedDataSets?[index].colour?[2] ??
                243),
        dataPage: dataPage);
  }

  void addDataSet(int index) {
    dataSets.addFieldBloc(DataSetFieldBloc(
        dataSetName: TextFieldBloc(
            validators: [FieldBlocValidators.required],
            initialValue:
                saveFormHelper.savedFormData.savedDataSets?[index].name),
        data: TextFieldBloc(
            validators: [FieldBlocValidators.required],
            initialValue: saveFormHelper
                .savedFormData.savedDataSets?[index].data
                .toString()),
        chooseColour: BooleanFieldBloc(),
        colour: Color.fromARGB(
            (saveFormHelper.savedFormData.savedDataSets?[index].tansparency ??
                        0.8)
                    .toInt() *
                255,
            saveFormHelper.savedFormData.savedDataSets?[index].colour?[0] ?? 33,
            saveFormHelper.savedFormData.savedDataSets?[index].colour?[1] ??
                150,
            saveFormHelper.savedFormData.savedDataSets?[index].colour?[2] ??
                243),
        dataPage: dataPage));
  }

  void removeDataSet(int index) {
    dataSets.removeFieldBlocAt(index);
  }

  @override
  void onSubmitting() async {
    if (state.currentStep == 0) {
      saveFormHelper.reset();
      saveFormHelper.saveName(title.value);
    } else if (state.currentStep == 1) {
      saveFormHelper.saveXAxes(xAxesLabel.value, xAxesDisplayLabel.value,
          xAxesDisplayAxes.value, xAxesPosition.value, xAxesValues.value);
    } else if (state.currentStep == 2) {
      dataSets.value.forEach((element) => {
            saveFormHelper.saveDataSet(element.dataSetName.value,
                element.data.value, element.chooseColour.value, element.colour)
          });
    } else if (state.currentStep == 3) {
      saveFormHelper.saveYAxes(yAxesLabel.value, yAxesDisplayLabel.value,
          yAxesDisplayAxes.value, yAxesPosition.value);
    } else if (state.currentStep == 4) {
      saveFormHelper.saveType(
          chartType.value,
          chooseBorderColour.value,
          borderColour,
          boldBorder.value,
          roundedBars.value,
          displayLines.value,
          filledLine.value,
          drawnLine.value,
          pointToPointLine.value,
          pointShapes.value);
    } else if (state.currentStep == 5) {
      saveFormHelper.saveOptions(displayTitle.value, displayLegend.value,
          legendPosition.value, displayDataLabels.value);
    }
    emitSuccess();
  }
}
