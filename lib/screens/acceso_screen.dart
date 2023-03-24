import 'package:flutter/material.dart';
import 'package:innova_ito/widgets/widgets.dart';

import '../ui/input_decorations.dart';

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
                  _formularioAcceso(),
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
  const _formularioAcceso({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          //TODO: mantener la referencia al key
          child: Column(children: [
        TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.accesoInputDecoration(
                hintText: 'Correo electronico',
                labelText: 'Correo electronico',
                prefixIcon: Icons.person)),
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
                prefixIcon: Icons.key)),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: const Text(
                  'Ingresar',
                  style: TextStyle(color: Colors.white),
                )),
            onPressed: () {}),
      ])),
    );
  }
}
