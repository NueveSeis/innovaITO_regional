import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innova_ito/providers/providers.dart';

import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:innova_ito/helpers/helpers.dart';

import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class GeneraPdfScreen extends ConsumerWidget {
  static const String name = 'GeneraPdfScreen';
  GeneraPdfScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final salas = ref.watch(futureSalasProvGC);
    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Constancias',
          fontSize: 20,
          widget: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: [
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
                        height: 150,
                        elevation: 15.0,
                        color: AppTema.grey100,
                        child: Container(
                            child: const Text(
                          'Salas - Proyectos',
                          style: TextStyle(
                              color: AppTema.bluegrey700, fontSize: 25),
                        )),
                        onPressed: () async {
                          final salasAsyncValue = ref.watch(futureSalasProvGC);
                          if (salasAsyncValue is AsyncData<List<SalaHs>>) {
                            List<SalaHs> salasData = salasAsyncValue
                                .value; // Acceder a los datos correctamente
                            String ruta = await pdf.salas(salasData);
                            OpenFilex.open(ruta);
                          } else if (salasAsyncValue is AsyncLoading) {
                            // Manejar caso de carga
                          } else if (salasAsyncValue is AsyncError) {
                            // Manejar caso de error
                          }
                        }),
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
                        height: 150,
                        elevation: 15.0,
                        color: AppTema.grey100,
                        child: Container(
                            child: const Text(
                          'Stands - Proyectos',
                          style: TextStyle(
                              color: AppTema.bluegrey700, fontSize: 25),
                        )),
                        onPressed: () async {
                          final standsAsyncValue = ref.watch(futureStandProvGC);
                          if (standsAsyncValue is AsyncData<List<StandHs>>) {
                            List<StandHs> standData = standsAsyncValue
                                .value; // Acceder a los datos correctamente
                            String ruta = await pdf.stands(standData);
                            OpenFilex.open(ruta);
                          } else if (standsAsyncValue is AsyncLoading) {
                            // Manejar caso de carga
                          } else if (standsAsyncValue is AsyncError) {
                            // Manejar caso de error
                          }
                        }),
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
                        height: 150,
                        elevation: 15.0,
                        color: AppTema.grey100,
                        child: Container(
                            child: const Text(
                          'Constancias',
                          style: TextStyle(
                              color: AppTema.bluegrey700, fontSize: 25),
                        )),
                        onPressed: () async {
                          context.pushNamed('GeneracionConstanciaScreen');
                        }),
                  ),
                ],
              ))),
    );
  }
}
