import 'package:flutter/material.dart';

class RegistroLiderProv extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String matricula = '';
  String nombre = '';
  String apellidoP = '';
  String apellidoM = '';
  String correo = '';

  bool esValidoFormulario() {
    print(formKey.currentState?.validate());

    ///print()
    return formKey.currentState?.validate() ?? false;
  }
}
