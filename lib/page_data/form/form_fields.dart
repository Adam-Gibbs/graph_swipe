import 'package:flutter_form_bloc/flutter_form_bloc.dart';

// From https://github.com/GiancarloCode/form_bloc
class FormFields extends FormBloc<String, String> {
  final title = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  FormFields() {
    addFieldBlocs(
      step: 0,
      fieldBlocs: [title],
    );
  }

  @override
  void onSubmitting() async {
    // Save to Explore
    emitSuccess();
  }
}
