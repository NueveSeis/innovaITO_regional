import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innova_ito/models/informacionProyectoER.dart';
import 'package:innova_ito/providers/providers.dart';

import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/models/models.dart';

import 'package:innova_ito/widgets/widgets.dart';
import 'package:innova_ito/helpers/helpers.dart';

import 'package:go_router/go_router.dart';

import 'package:open_filex/open_filex.dart';

class GeneraPdfRegionalScreen extends ConsumerWidget {
  static const String name = 'GeneraPdfRegionalScreen';
  GeneraPdfRegionalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proyectos = ref.watch(futureinfoProyectosRegionalProv);
    return Scaffold(
      body: Fondo(
          tituloPantalla: 'PDF',
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
                          'Descargar presentaciones',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppTema.bluegrey700, fontSize: 25),
                        )),
                        onPressed: () async {
                          final infoProyectosRegionalAsyncValue =
                              ref.watch(futureinfoProyectosRegionalProv);
                          if (infoProyectosRegionalAsyncValue
                              is AsyncData<List<InformacionProyectoEr>>) {
                            List<InformacionProyectoEr>
                                infoProyectosRegionalData =
                                infoProyectosRegionalAsyncValue
                                    .value; // Acceder a los datos correctamente
                            String ruta = await pdf
                                .presentaciones(infoProyectosRegionalData);
                            OpenFilex.open(ruta);
                          } else if (infoProyectosRegionalAsyncValue
                              is AsyncLoading) {
                            // Manejar caso de carga
                          } else if (infoProyectosRegionalAsyncValue
                              is AsyncError) {
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
                        'X',
                        style:
                            TextStyle(color: AppTema.bluegrey700, fontSize: 25),
                      )),
                      onPressed: null,
                      // onPressed: () async {
                      //   final standsAsyncValue = ref.watch(futureStandProvGC);
                      //   if (standsAsyncValue is AsyncData<List<StandHs>>) {
                      //     List<StandHs> standData = standsAsyncValue
                      //         .value; // Acceder a los datos correctamente
                      //     String ruta = await pdf.stands(standData);
                      //     OpenFilex.open(ruta);
                      //   } else if (standsAsyncValue is AsyncLoading) {
                      //     // Manejar caso de carga
                      //   } else if (standsAsyncValue is AsyncError) {
                      //     // Manejar caso de error
                      //   }
                      // }
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
