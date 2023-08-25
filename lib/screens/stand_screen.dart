import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/widgets/widgets.dart';

import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class StandScreen extends ConsumerWidget {
  static const String name = 'stand';
  StandScreen({super.key});

  List<StandHs> stands = [];

  Future<void> getStandS() async {
    String url = 'https://evarafael.com/Aplicacion/rest/get_asignarHStand.php';
    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        stands = standHsFromJson(response.body);
        print(stands);
      } else {
        print('La solicitud no fue exitosa: ${response.statusCode}');
      }
    } catch (error) {
      print('Error al realizar la solicitud: $error');
    }
  }

  Future<bool> eliminarAsignarHST(String foliop, String idStand) async {
    var url =
        'https://evarafael.com/Aplicacion/rest/delete_asignarHStand.php?Id_stand=$idStand&Folio=$foliop'; // Reemplaza con la URL del archivo PHP en tu servidor
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      print('Modificado en la db');
      return true;
    } else {
      print('No modificado');
      return false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Stands Asignados',
          fontSize: 20,
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: ElevatedButton(
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Asignar Stand',
                          style:
                              TextStyle(color: AppTema.grey100, fontSize: 20),
                        ),
                      ],
                    ),
                    onPressed: () {
                      context.pushNamed('asignar_stand');
                    },
                  ),
                ),
                FutureBuilder(
                  future: getStandS(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                            child: Text('Error: ${snapshot.error.toString()}'));
                      } else {
                        return stands.isEmpty
                            ? const Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    'No hay proyectos asignados',
                                    style: TextStyle(
                                        color: AppTema.bluegrey700,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              )
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: stands.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    elevation: 10,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                        top: 10,
                                        left: 20,
                                        right: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppTema.grey100,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Container(
                                                    //isExpanded: true,
                                                    //width: double.infinity,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          'Nombre del proyecto: ',
                                                          style: TextStyle(
                                                              color: AppTema
                                                                  .bluegrey700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        Text(
                                                          stands[index]
                                                              .nombreCorto,
                                                          style: const TextStyle(
                                                              color: AppTema
                                                                  .bluegrey700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          'Fecha: ${stands[index].fecha}',
                                                          style: const TextStyle(
                                                              color: AppTema
                                                                  .bluegrey700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          'Hora inicio: ${stands[index].horaInicio}',
                                                          style: const TextStyle(
                                                              color: AppTema
                                                                  .bluegrey700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          'Hora fin: ${stands[index].horaFinal}',
                                                          style: const TextStyle(
                                                              color: AppTema
                                                                  .bluegrey700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          'Lugar: ${stands[index].lugar}',
                                                          style: const TextStyle(
                                                              color: AppTema
                                                                  .bluegrey700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Container(
                                                            //width: double.infinity,
                                                            //color: AppTema.grey100,
                                                            height: 200,

                                                            child: Column(
                                                              children: [
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                const Text(
                                                                  'Administrar',
                                                                  style: TextStyle(
                                                                      color: AppTema
                                                                          .bluegrey700,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          25),
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                ListTile(
                                                                  splashColor:
                                                                      AppTema
                                                                          .primario,
                                                                  title:
                                                                      const Text(
                                                                    'Eliminar',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                  leading:
                                                                      const Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: AppTema
                                                                        .redA400,
                                                                  ),
                                                                  onTap:
                                                                      () async {
                                                                    bool eliminado = await eliminarAsignarHST(
                                                                        stands[index]
                                                                            .folio,
                                                                        stands[index]
                                                                            .idStand);
                                                                    if (eliminado) {
                                                                      QuickAlert
                                                                          .show(
                                                                        context:
                                                                            context,
                                                                        type: QuickAlertType
                                                                            .success,
                                                                        title:
                                                                            'Registro eliminado',
                                                                        confirmBtnText:
                                                                            'Hecho',
                                                                        confirmBtnColor:
                                                                            AppTema.pizazz,
                                                                        onConfirmBtnTap:
                                                                            () {
                                                                          context
                                                                              .pushReplacementNamed('stand');
                                                                        },
                                                                      );
                                                                    } else {
                                                                      QuickAlert
                                                                          .show(
                                                                        context:
                                                                            context,
                                                                        type: QuickAlertType
                                                                            .error,
                                                                        title:
                                                                            'Ocurrió un error',
                                                                        confirmBtnText:
                                                                            'Hecho',
                                                                        confirmBtnColor:
                                                                            AppTema.pizazz,
                                                                        onConfirmBtnTap:
                                                                            () {
                                                                          context
                                                                              .pop();
                                                                        },
                                                                      );
                                                                    }
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  icon: const Icon(
                                                    Icons.more_vert_outlined,
                                                    color: AppTema.bluegrey700,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                      }
                    } else {
                      return const Center(child: Text('¡Algo salió mal!'));
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}
