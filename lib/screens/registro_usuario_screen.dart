import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/theme/app_tema.dart';

import 'package:innova_ito/widgets/widgets.dart';

class RegistroUsuarioScreen extends StatelessWidget {
  static const String name = 'registro_usuario';
  const RegistroUsuarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Fondo(
            tituloPantalla: 'Registro de usuarios',
            fontSize: 20,
            widget: Column(children: [
              const SizedBox(height: 50),
              const Text(
                'Selecciona tipo de usuario',
                style: TextStyle(
                    color: AppTema.balticSea,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SingleChildScrollView(
                //padding: EdgeInsets.only(top: 25, bottom: 25),
                //width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: MaterialButton(
                          splashColor: AppTema.pizazz,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 200,
                          elevation: 15.0,
                          color: AppTema.grey100,
                          child: Container(
                              child: const Text(
                            'Lider de proyecto',
                            style: TextStyle(
                                color: AppTema.bluegrey700, fontSize: 25),
                          )),
                          onPressed: () {
                            context.pushNamed('registro_usuario_lider');
                            // Navigator.pushNamed(
                            //   context, 'registro_usuario_lider');
                          }),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: MaterialButton(
                          splashColor: AppTema.pizazz,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 200,
                          elevation: 15.0,
                          color: AppTema.grey100,
                          child: Container(
                              child: const Text(
                            'Asesor',
                            style: TextStyle(
                                color: AppTema.bluegrey700, fontSize: 25),
                          )),
                          onPressed: () {
                            context.pushNamed('registro_usuario_asesor');
                            // Navigator.pushNamed(
                            //   context, 'registro_usuario_asesor');
                          }),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
