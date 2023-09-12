import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/widgets/widgets.dart';

import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RubricaScreen extends ConsumerWidget {
  static const String name = 'RubricaScreen';
  RubricaScreen({super.key});

  List<CriterioRubrica> rubrica = [];
  Future<void> getRubrica(String medio) async {
    String url =
        '${dotenv.env['HOST_REST']}get_criterioRubrica.php?Medio_evaluacion=$medio';
    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        rubrica = criterioRubricaFromJson(response.body);
      } else {
        //print('La solicitud no fue exitosa: ${response.statusCode}');
      }
    } catch (error) {
      print('Error al realizar la solicitud: $error');
    }
  }

  List<CriterioRubrica> rubricaSala = [];

  Future<void> getRubricaSala(String medio) async {
    String url =
        '${dotenv.env['HOST_REST']}get_criterioRubrica.php?Medio_evaluacion=$medio';
    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        rubricaSala = criterioRubricaFromJson(response.body);
      } else {
        //print('La solicitud no fue exitosa: ${response.statusCode}');
      }
    } catch (error) {
      //print('Error al realizar la solicitud: $error');
    }
  }

  Future<bool> eliminarRubrica(String idrub) async {
    var url =
        '${dotenv.env['HOST_REST']}delete_rubrica.php?Id_rubrica=$idrub'; // Reemplaza con la URL del archivo PHP en tu servidor
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      // print('Modificado en la db');
      return true;
    } else {
      // print('No modificado');
      return false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Rúbricas',
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
                          'Crear rúbrica',
                          style:
                              TextStyle(color: AppTema.grey100, fontSize: 20),
                        ),
                      ],
                    ),
                    onPressed: () {
                      context.pushNamed('agregar_rubrica');
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                FutureBuilder(
                  future: getRubrica('STAND'),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Center(child: Text('no'));
                      } else {
                        return rubrica.isEmpty
                            ? Text(
                                'No existe rubrica de stand',
                                style: const TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                                overflow: TextOverflow.visible,
                              )
                            : Column(
                                children: [
                                  Text(
                                    'CRITERIOS DE RUBRICA ${rubrica.first.medioEvaluacion}',
                                    style: const TextStyle(
                                        color: AppTema.bluegrey700,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    overflow: TextOverflow.visible,
                                  ),
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: rubrica.length,
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
                                            borderRadius:
                                                BorderRadius.circular(15),
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
                                                              .symmetric(
                                                          horizontal: 5),
                                                      child: Container(
                                                        //isExpanded: true,
                                                        //width: double.infinity,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Criterio: ${rubrica[index].nombreCriterio}',
                                                              style: const TextStyle(
                                                                  color: AppTema
                                                                      .bluegrey700,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize: 15),
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              'Porcentaje mínimo: ${rubrica[index].valorMin}',
                                                              style: const TextStyle(
                                                                  color: AppTema
                                                                      .bluegrey700,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize: 15),
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              'Porcentaje máximo: ${rubrica[index].valorMax}',
                                                              style: const TextStyle(
                                                                  color: AppTema
                                                                      .bluegrey700,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize: 15),
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
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
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return Container(
                                                                //width: double.infinity,
                                                                //color: AppTema.grey100,
                                                                height: 200,

                                                                child: Column(
                                                                  children: [
                                                                    const SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                    const Text(
                                                                      'Administrar',
                                                                      style: TextStyle(
                                                                          color: AppTema
                                                                              .bluegrey700,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              25),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                    ListTile(
                                                                      splashColor:
                                                                          AppTema
                                                                              .primario,
                                                                      title:
                                                                          const Text(
                                                                        'Eliminar rúbrica',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 20),
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
                                                                        bool
                                                                            eliminado =
                                                                            await eliminarRubrica(rubrica[index].idRubrica);
                                                                        if (eliminado) {
                                                                          QuickAlert
                                                                              .show(
                                                                            context:
                                                                                context,
                                                                            type:
                                                                                QuickAlertType.success,
                                                                            title:
                                                                                'Rúbrica eliminada',
                                                                            confirmBtnText:
                                                                                'Hecho',
                                                                            confirmBtnColor:
                                                                                AppTema.pizazz,
                                                                            onConfirmBtnTap:
                                                                                () {
                                                                              context.pushReplacementNamed('RubricaScreen');
                                                                            },
                                                                          );
                                                                        } else {
                                                                          QuickAlert
                                                                              .show(
                                                                            context:
                                                                                context,
                                                                            type:
                                                                                QuickAlertType.error,
                                                                            title:
                                                                                'Ocurrió un error',
                                                                            confirmBtnText:
                                                                                'Hecho',
                                                                            confirmBtnColor:
                                                                                AppTema.pizazz,
                                                                            onConfirmBtnTap:
                                                                                () {
                                                                              context.pop();
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
                                                        Icons
                                                            .more_vert_outlined,
                                                        color:
                                                            AppTema.bluegrey700,
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                      }
                    } else {
                      return const Center(child: Text('¡Algo salió mal!'));
                    }
                  },
                ),
                const SizedBox(
                  height: 60,
                ),
                FutureBuilder(
                  future: getRubricaSala('SALA'),
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
                        return rubricaSala.isEmpty
                            ? const Text(
                                'No existe rúbrica de sala',
                                style: TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                                overflow: TextOverflow.visible,
                              )
                            : Column(
                                children: [
                                  Text(
                                    'CRITERIOS DE RÚBRICA ${rubricaSala.first.medioEvaluacion}',
                                    style: const TextStyle(
                                        color: AppTema.bluegrey700,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    overflow: TextOverflow.visible,
                                  ),
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: rubricaSala.length,
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
                                            borderRadius:
                                                BorderRadius.circular(15),
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
                                                              .symmetric(
                                                          horizontal: 5),
                                                      child: Container(
                                                        //isExpanded: true,
                                                        //width: double.infinity,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Criterio: ${rubricaSala[index].nombreCriterio}',
                                                              style: const TextStyle(
                                                                  color: AppTema
                                                                      .bluegrey700,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize: 15),
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              'Porcentaje mínimo: ${rubricaSala[index].valorMin}',
                                                              style: const TextStyle(
                                                                  color: AppTema
                                                                      .bluegrey700,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize: 15),
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              'Porcentaje máximo: ${rubricaSala[index].valorMax}',
                                                              style: const TextStyle(
                                                                  color: AppTema
                                                                      .bluegrey700,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize: 15),
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
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
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return Container(
                                                                //width: double.infinity,
                                                                //color: AppTema.grey100,
                                                                height: 200,

                                                                child: Column(
                                                                  children: [
                                                                    const SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                    const Text(
                                                                      'Administrar',
                                                                      style: TextStyle(
                                                                          color: AppTema
                                                                              .bluegrey700,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              25),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                    ListTile(
                                                                      splashColor:
                                                                          AppTema
                                                                              .primario,
                                                                      title:
                                                                          const Text(
                                                                        'Eliminar rúbrica',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 20),
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
                                                                        bool
                                                                            eliminado =
                                                                            await eliminarRubrica(rubricaSala[index].idRubrica);
                                                                        if (eliminado) {
                                                                          QuickAlert
                                                                              .show(
                                                                            context:
                                                                                context,
                                                                            type:
                                                                                QuickAlertType.success,
                                                                            title:
                                                                                'Rúbrica eliminada',
                                                                            confirmBtnText:
                                                                                'Hecho',
                                                                            confirmBtnColor:
                                                                                AppTema.pizazz,
                                                                            onConfirmBtnTap:
                                                                                () {
                                                                              context.pushReplacementNamed('RubricaScreen');
                                                                            },
                                                                          );
                                                                        } else {
                                                                          QuickAlert
                                                                              .show(
                                                                            context:
                                                                                context,
                                                                            type:
                                                                                QuickAlertType.error,
                                                                            title:
                                                                                'Ocurrió un error',
                                                                            confirmBtnText:
                                                                                'Hecho',
                                                                            confirmBtnColor:
                                                                                AppTema.pizazz,
                                                                            onConfirmBtnTap:
                                                                                () {
                                                                              context.pop();
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
                                                        Icons
                                                            .more_vert_outlined,
                                                        color:
                                                            AppTema.bluegrey700,
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
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
