import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:graph_swipe/page_data/form/form_loading_dialog.dart';
import 'package:graph_swipe/page_data/form/form_fields.dart';
import 'package:graph_swipe/page_data/form/form_step_blocs.dart';

class DataPage extends StatefulWidget {
  @override
  DataPageState createState() => DataPageState();
}

class DataPageState extends State<DataPage> {
  var _type = StepperType.vertical;
  Color currentColor = Colors.blue;

  // TODO: currently a bodge to redraw the form, should fix to just redraw individual Widget
  void changeColor(Color colour) => setState(() => currentColor = colour);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FormFields(this),
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
                      print("Done");
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
                        FormStepBlocs.dataSetsStep(formBloc, this),
                        FormStepBlocs.yAxesStep(formBloc),
                        FormStepBlocs.typeStep(formBloc, context, this),
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
