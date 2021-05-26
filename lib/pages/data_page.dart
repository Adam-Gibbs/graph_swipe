import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:graph_swipe/main.dart';
import 'package:graph_swipe/page_data/form/form_loading_dialog.dart';
import 'package:graph_swipe/page_data/form/form_fields.dart';
import 'package:graph_swipe/page_data/form/form_step_blocs.dart';
import 'package:graph_swipe/page_data/form/save_data/save_form_helper.dart';
import 'package:graph_swipe/page_data/form/save_data/saved_form_data.dart';

class DataPage extends StatefulWidget {
  final SavedFormData savedFormData;
  final MainAppState mainApp;
  DataPage(this.mainApp, this.savedFormData);

  @override
  DataPageState createState() => DataPageState(mainApp, savedFormData);
}

class DataPageState extends State<DataPage> {
  var _type = StepperType.vertical;
  Color currentColor = Colors.blue;
  final MainAppState mainApp;
  final SavedFormData savedFormData;
  late SaveFormHelper saveFormHelper;

  DataPageState(this.mainApp, this.savedFormData) {
    saveFormHelper = new SaveFormHelper(savedFormData);
  }

  // TODO: currently a bodge to redraw the form, should fix to just redraw individual Widget
  void changeColor(Color colour) => setState(() => currentColor = colour);
  void goToExplore() => mainApp.setState(() => mainApp.selectedPage = 1);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FormFields(this, saveFormHelper),
      child: Builder(
        builder: (context) {
          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: FormBlocListener<FormFields, String, String>(
                  onSubmitting: (context, state) =>
                      FormLoadingDialog.show(context),
                  onSuccess: (context, state) {
                    FormLoadingDialog.hide(context);

                    if (state.stepCompleted == state.lastStep) {
                      goToExplore();
                    }
                  },
                  onFailure: (context, state) {
                    FormLoadingDialog.hide(context);
                  },
                  child: StepperFormBlocBuilder<FormFields>(
                    formBloc: context.read<FormFields>(),
                    type: _type,
                    physics: ClampingScrollPhysics(),
                    stepsBuilder: (formBloc) {
                      return [
                        FormStepBlocs.generalStep(formBloc!),
                        FormStepBlocs.xAxesStep(formBloc),
                        FormStepBlocs.dataSetsStep(
                            formBloc, this, savedFormData.savedDataSets),
                        FormStepBlocs.yAxesStep(formBloc),
                        FormStepBlocs.typeStep(formBloc, context, this),
                        FormStepBlocs.optionsStep(formBloc)
                      ];
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
