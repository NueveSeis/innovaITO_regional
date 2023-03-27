import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:innova_ito/providers/acceso_formulario_prov.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:innova_ito/ui/input_decorations.dart';

class AccesoScreen extends StatelessWidget {
  const AccesoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FondoAcceso(
      child: SingleChildScrollView(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(
              height: 250,
            ),
            ContenedorCarta(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Acceso',
                    style: TextStyle(
                        color: Color.fromRGBO(46, 45, 47, 0.8),
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ChangeNotifierProvider(
                    create: (_) => AccesoFormularioProv(),
                    child: _formularioAcceso(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                      child: const Text(
                        '¿Olvidó su contraseña?',
                        style: TextStyle(
                            color: Color.fromRGBO(46, 45, 47, 0.8),
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {}),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class _formularioAcceso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accesoFormulario = Provider.of<AccesoFormularioProv>(context);
    return Container(
      child: Form(
          key: accesoFormulario.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.accesoInputDecoration(
                  hintText: 'Correo electronico',
                  labelText: 'Correo electronico',
                  prefixIcon: Icons.person),
              onChanged: (value) => accesoFormulario.correo = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no es un correo.';
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.accesoInputDecoration(
                  hintText: '******',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.key),
              onChanged: (value) => accesoFormulario.contrasena = value,
              validator: (value) {
                if (value != null && value.length >= 8) return null;
                return 'Contraseña debe contener minimo 8 caracteres.';
              },
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                disabledColor: Colors.grey,
                elevation: 10,
                color: const Color.fromRGBO(250, 122, 30, 1),
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 15),
                    child: const Text(
                      'Ingresar',
                      style: TextStyle(color: Colors.white),
                    )),
                onPressed: () {
                  if (!accesoFormulario.esValidoFormulario()) return;
                  Navigator.pushReplacementNamed(context, 'menu_lateral');
                }),
          ])),
    );
  }
}
