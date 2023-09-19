import 'package:flutter/material.dart';

import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/widgets/widgets.dart';

import 'package:go_router/go_router.dart';

class OpcionesLiderRegionalScreen extends StatelessWidget {
  static const String name = 'OpcionesLiderRegionalScreen';
  const OpcionesLiderRegionalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FondoGn(
            tituloPantalla: 'Opciones',
            fontSize: 20,
            widget: Column(children: [
              const SizedBox(height: 50),
              const Text(
                'Seleccione una opción',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppTema.bluegrey700,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SingleChildScrollView(
                //padding: EdgeInsets.only(top: 25, bottom: 25),
                //width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
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
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Agrega aquí el icono en el centro, arriba del texto
                            Icon(
                              Icons.add_link_rounded,
                              size: 48, // Tamaño del icono
                              color: AppTema.primario, // Color del icono
                            ),
                            SizedBox(
                                height:
                                    10), // Espacio entre el icono y el texto
                            Text(
                              'Agregar presentación',
                              style: TextStyle(
                                color: AppTema.bluegrey700,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          context.pushNamed('SubirPresentacionScreen');
                          // Navigator.pushNamed(
                          //   context, 'registro_usuario_lider');
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Agrega aquí el icono en el centro, arriba del texto
                            Icon(
                              Icons.manage_search_rounded,
                              size: 48, // Tamaño del icono
                              color: AppTema.primario, // Color del icono
                            ),
                            SizedBox(
                                height:
                                    10), // Espacio entre el icono y el texto
                            Text(
                              'Ver mi Sala - Stand',
                              style: TextStyle(
                                color: AppTema.bluegrey700,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          context.pushNamed('SalaLiderRegionalScreen');
                          // Navigator.pushNamed(
                          //   context, 'registro_usuario_asesor');
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ])));
  }
}
