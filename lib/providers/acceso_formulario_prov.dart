import 'package:flutter/material.dart';

class AccesoFormularioProv extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String correo = '';
  String contrasena = '';

  bool esValidoFormulario() {
    print(formKey.currentState?.validate());

    ///print()
    return formKey.currentState?.validate() ?? false;
  }
}
