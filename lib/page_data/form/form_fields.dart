import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:graph_swipe/page_data/form/data_form/data_form_fields.dart';
import 'package:graph_swipe/pages/data_page.dart';

// From https://github.com/GiancarloCode/form_bloc
class FormFields extends FormBloc<String, String> {
  final DataPageState dataPage;

  final title = TextFieldBloc(
      // validators: [FieldBlocValidators.required],
      );

  var dataSets = ListFieldBloc<DataSetFieldBloc>();

  final xAxesVales = TextFieldBloc(
      // validators: [FieldBlocValidators.required],
      );

  final xAxesLabel = TextFieldBloc(
      // validators: [FieldBlocValidators.required],
      );

  final xAxesDisplayLabel = BooleanFieldBloc();

  final xAxesDisplayAxes = BooleanFieldBloc();

  final xAxesPosition = SelectFieldBloc(
    items: ['Top', 'Bottom', 'Random'],
    initialValue: 'Random',
    // validators: [FieldBlocValidators.required],
  );

  final yAxesLabel = TextFieldBloc(
      // validators: [FieldBlocValidators.required],
      );

  final yAxesDisplayLabel = BooleanFieldBloc();

  final yAxesDisplayAxes = BooleanFieldBloc();

  final yAxesPosition = SelectFieldBloc(
    items: ['Left', 'Right', 'Random'],
    initialValue: 'Random',
    // validators: [FieldBlocValidators.required],
  );

  final chartType = SelectFieldBloc(
    items: ['Bar', 'Line', 'Random'],
    initialValue: 'Random',
    // validators: [FieldBlocValidators.required],
  );

  final chooseBorderColour = BooleanFieldBloc();
  Color borderColour = Colors.blue;

  final boldBorder = BooleanFieldBloc();

  final roundedBars = BooleanFieldBloc();

  final pointShapes = SelectFieldBloc(
    items: ['Circle', 'Star', 'Triangle', 'Random'],
    initialValue: 'Random',
    validators: [FieldBlocValidators.required],
  );

  final displayLines = BooleanFieldBloc(initialValue: true);

  final drawnLine = SelectFieldBloc(
    items: ['Dashed', 'Solid', 'Random'],
    initialValue: 'Random',
    validators: [FieldBlocValidators.required],
  );

  final pointToPointLine = SelectFieldBloc(
    items: ['Curved', 'Straight', 'Stepped', 'Random'],
    initialValue: 'Random',
    validators: [FieldBlocValidators.required],
  );

  final filledLine = BooleanFieldBloc();

  FormFields(this.dataPage) {
    addFieldBlocs(
      step: 0,
      fieldBlocs: [title],
    );
    addFieldBlocs(
      step: 1,
      fieldBlocs: [
        xAxesVales,
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
        yAxesPosition
      ],
    );
    addFieldBlocs(
      step: 4,
      fieldBlocs: [chartType],
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
          addFieldBlocs(step: 4, fieldBlocs: displayLineOptions);
        } else {
          removeFieldBlocs(fieldBlocs: displayLineOptions);
        }
      },
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
