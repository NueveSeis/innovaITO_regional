import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/models/models.dart';

import 'package:innova_ito/widgets/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:uuid/uuid.dart';

class SeleccionaProyectoJuradoScreen extends ConsumerWidget {
  static const String name = 'SeleccionaProyectoJuradoScreen';

  SeleccionaProyectoJuradoScreen({super.key});

  List<ProyectosSelecJuradoPsj> proyectos = [];
  Future<bool> getProyectos(String idCat) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/get_proyectosSelectJurado.php?Id_categoria=$idCat';

    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        proyectos = proyectosSelecJuradoPsjFromJson(response.body);
        return true;
      } else {
        //print('La solicitud no fue exitosa: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      return false;
      //print('Error al realizar la solicitud: $error');
    }
  }

  List<ProyectoAsesorWf> asesoWF = [];
  Future<bool> getAsesorWhere(String idfol) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/get_proyectoAsesorWhere.php?Folio=$idfol';

    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        asesoWF = proyectoAsesorWfFromJson(response.body);
        return true;
      } else {
        //print('La solicitud no fue exitosa: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      return false;
      //print('Error al realizar la solicitud: $error');
    }
  }

  Future<bool> agregarEvaluacionSala(
      String idEva, String foliop, String idSala, String idJur) async {
    var url =
        'https://evarafael.com/Aplicacion/rest/agregar_evaluacionSala.php'; // Reemplaza con la URL del archivo PHP en tu servidor
    var response = await http.post(Uri.parse(url), body: {
      'Id_evaluacionSala': 'EVA$idEva',
      'Folio': foliop,
      'Id_sala': idSala,
      'Id_jurado': idJur
    });
    if (response.statusCode == 200) {
      //print('Modificado en la db');
      return true;
    } else {
      //print('No modificado');
      return false;
    }
  }

  Future<bool> agregarEvaluacionStand(
      String idEva, String foliop, String idStand, String idJur) async {
    var url =
        'https://evarafael.com/Aplicacion/rest/agregar_evaluacionStand.php'; // Reemplaza con la URL del archivo PHP en tu servidor
    var response = await http.post(Uri.parse(url), body: {
      'Id_evaluacionStand': 'EVAST$idEva',
      'Folio': foliop,
      'Id_stand': idStand,
      'Id_jurado': idJur
    });
    if (response.statusCode == 200) {
      //print('Modificado en la db');
      return true;
    } else {
      //print('No modificado');
      return false;
    }
  }

  Future<bool> agregarProyectoJurado(String foliop, String idJur) async {
    var url =
        'https://evarafael.com/Aplicacion/rest/agregarProyectoJurado.php'; // Reemplaza con la URL del archivo PHP en tu servidor
    var response = await http
        .post(Uri.parse(url), body: {'Folio': foliop, 'Id_jurado': idJur});
    if (response.statusCode == 200) {
      //print('Modificado en la db');
      return true;
    } else {
      //print('No modificado');
      return false;
    }
  }

  final listoAsesor = StateProvider(
    (ref) => false,
  );
  TextEditingController cRFCLider = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final juradoID = ref.watch(juradoIDProvider);
    final datosJuradoSLVar = ref.watch(juradoDatosSL);
    // final idAreaSL = ref.watch(idAreaSLProv);
    // final idCatSL = ref.watch(idCatSLProv);
    return Scaffold(
        body: Fondo(
            tituloPantalla: 'Asignar proyecto',
            fontSize: 20,
            widget: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    const Text(
                      'Evaluador',
                      style: TextStyle(
                          color: AppTema.balticSea,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Text(
                      '${datosJuradoSLVar.first.nombrePersona} ${datosJuradoSLVar.first.apellido1} ${datosJuradoSLVar.first.apellido2}',
                      style: const TextStyle(
                          color: AppTema.balticSea,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const SizedBox(height: 30),
                    FutureBuilder(
                        future: getProyectos(
                            datosJuradoSLVar.first.idCategoria.toString()),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text(
                                      'Error: ${snapshot.error.toString()}'));
                            } else {
                              return proyectos.isEmpty
                                  ? const Column(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Text(
                                          'No hay proyectos del área de interés',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: AppTema.bluegrey700,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ],
                                    )
                                  : ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: proyectos.length,
                                      itemBuilder: (context, index) {
                                        int valor = index + 1;
                                        return Column(
                                          children: [
                                            Card(
                                              elevation: 15.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Text(
                                                      proyectos[index]
                                                          .nombreCorto,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        color:
                                                            AppTema.bluegrey700,
                                                        fontSize: 18.0,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        height: 10.0),
                                                    Text(
                                                      'Nombre descriptivo : ${proyectos[index].nombreProyecto}',
                                                      style: const TextStyle(
                                                        color:
                                                            AppTema.bluegrey700,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Text(
                                                      'Área: ${proyectos[index].nombreArea}',
                                                      style: const TextStyle(
                                                        color:
                                                            AppTema.bluegrey700,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Text(
                                                      'Categoría: ${proyectos[index].nombreCategoria}',
                                                      style: const TextStyle(
                                                        color:
                                                            AppTema.bluegrey700,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Evaluadores en sala: ',
                                                          style: TextStyle(
                                                            color: AppTema
                                                                .bluegrey700,
                                                            fontSize: 15.0,
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: (int.parse(proyectos[
                                                                            index]
                                                                        .cantidadSala) >=
                                                                    1)
                                                                ? AppTema
                                                                    .greenS400
                                                                : AppTema
                                                                    .redA400,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          child: Text(
                                                            proyectos[index]
                                                                .cantidadSala
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Evaluadores en stand: ',
                                                          style: TextStyle(
                                                            color: AppTema
                                                                .bluegrey700,
                                                            fontSize: 15.0,
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: (int.parse(proyectos[
                                                                            index]
                                                                        .cantidadStand) >=
                                                                    1)
                                                                ? AppTema
                                                                    .greenS400
                                                                : AppTema
                                                                    .redA400,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          child: Text(
                                                            proyectos[index]
                                                                .cantidadStand
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: AppTema
                                                                .primario,
                                                            onPrimary:
                                                                Colors.white,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                          ),
                                                          onPressed: () async {
                                                            // Lógica para "Asignar a Stand"
                                                            String idEvalua =
                                                                const Uuid()
                                                                    .v4()
                                                                    .substring(
                                                                        0, 8);

                                                            print(idEvalua);
                                                            print(
                                                                proyectos[index]
                                                                    .folio);

                                                            print(
                                                                proyectos[index]
                                                                    .idStand);

                                                            print(
                                                                datosJuradoSLVar
                                                                    .first
                                                                    .idJurado);

                                                            if (proyectos[index]
                                                                        .idStand ==
                                                                    null ||
                                                                proyectos[index]
                                                                        .idStand ==
                                                                    "null") {
                                                              QuickAlert.show(
                                                                context:
                                                                    context,
                                                                type:
                                                                    QuickAlertType
                                                                        .warning,
                                                                title:
                                                                    'Este proyecto aún no tiene stand asignado',
                                                                confirmBtnText:
                                                                    'Hecho',
                                                                confirmBtnColor:
                                                                    AppTema
                                                                        .pizazz,
                                                                onConfirmBtnTap:
                                                                    () {
                                                                  context.pop();
                                                                },
                                                              );
                                                            } else {
                                                              bool agregado = await agregarEvaluacionStand(
                                                                  idEvalua,
                                                                  proyectos[
                                                                          index]
                                                                      .folio,
                                                                  proyectos[
                                                                          index]
                                                                      .idStand,
                                                                  datosJuradoSLVar
                                                                      .first
                                                                      .idJurado);

                                                              bool agrega = await agregarProyectoJurado(
                                                                  proyectos[
                                                                          index]
                                                                      .folio,
                                                                  datosJuradoSLVar
                                                                      .first
                                                                      .idJurado);

                                                              if (agregado &&
                                                                  agrega) {
                                                                QuickAlert.show(
                                                                  context:
                                                                      context,
                                                                  type: QuickAlertType
                                                                      .success,
                                                                  title:
                                                                      'Proyecto asignado',
                                                                  confirmBtnText:
                                                                      'Hecho',
                                                                  confirmBtnColor:
                                                                      AppTema
                                                                          .pizazz,
                                                                  onConfirmBtnTap:
                                                                      () {
                                                                    context.pushReplacementNamed(
                                                                        'AsignarProyectoJuradoScreen');
                                                                  },
                                                                );
                                                              } else {
                                                                QuickAlert.show(
                                                                  context:
                                                                      context,
                                                                  type:
                                                                      QuickAlertType
                                                                          .error,
                                                                  title:
                                                                      'Ocurrió un error',
                                                                  confirmBtnText:
                                                                      'Hecho',
                                                                  confirmBtnColor:
                                                                      AppTema
                                                                          .pizazz,
                                                                  onConfirmBtnTap:
                                                                      () {
                                                                    context
                                                                        .pop();
                                                                  },
                                                                );
                                                              }
                                                            }
                                                          },
                                                          child: const Text(
                                                              'Asignar a Stand'),
                                                        ),
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: AppTema
                                                                .primario,
                                                            onPrimary:
                                                                Colors.white,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                          ),
                                                          onPressed: () async {
                                                            // Lógica para "Asignar a Sala"

                                                            String idEva =
                                                                const Uuid()
                                                                    .v4()
                                                                    .substring(
                                                                        0, 8);

                                                            print(idEva);
                                                            print(
                                                                proyectos[index]
                                                                    .folio);

                                                            print(
                                                                proyectos[index]
                                                                    .idSala);

                                                            print(
                                                                datosJuradoSLVar
                                                                    .first
                                                                    .idJurado);

                                                            if (proyectos[index]
                                                                        .idSala ==
                                                                    null ||
                                                                proyectos[index]
                                                                        .idSala ==
                                                                    "null") {
                                                              // Si idSala es nulo, hacer algo diferente
                                                              // Por ejemplo, mostrar un mensaje de "Sin sala asignada"
                                                              QuickAlert.show(
                                                                context:
                                                                    context,
                                                                type:
                                                                    QuickAlertType
                                                                        .warning,
                                                                title:
                                                                    'Este proyecto aún no tiene sala asignada',
                                                                confirmBtnText:
                                                                    'Hecho',
                                                                confirmBtnColor:
                                                                    AppTema
                                                                        .pizazz,
                                                                onConfirmBtnTap:
                                                                    () {
                                                                  context.pop();
                                                                },
                                                              );
                                                            } else {
                                                              // Si idSala tiene datos, hacer algo diferente
                                                              // Por ejemplo, mostrar el ID de la sala

                                                              bool agregado = await agregarEvaluacionSala(
                                                                  idEva,
                                                                  proyectos[
                                                                          index]
                                                                      .folio,
                                                                  proyectos[
                                                                          index]
                                                                      .idSala,
                                                                  datosJuradoSLVar
                                                                      .first
                                                                      .idJurado);

                                                              bool agrega = await agregarProyectoJurado(
                                                                  proyectos[
                                                                          index]
                                                                      .folio,
                                                                  datosJuradoSLVar
                                                                      .first
                                                                      .idJurado);

                                                              if (agregado &&
                                                                  agrega) {
                                                                QuickAlert.show(
                                                                  context:
                                                                      context,
                                                                  type: QuickAlertType
                                                                      .success,
                                                                  title:
                                                                      'Proyecto asignado',
                                                                  confirmBtnText:
                                                                      'Hecho',
                                                                  confirmBtnColor:
                                                                      AppTema
                                                                          .pizazz,
                                                                  onConfirmBtnTap:
                                                                      () {
                                                                    context.pushReplacementNamed(
                                                                        'AsignarProyectoJuradoScreen');
                                                                  },
                                                                );
                                                              } else {
                                                                QuickAlert.show(
                                                                  context:
                                                                      context,
                                                                  type:
                                                                      QuickAlertType
                                                                          .error,
                                                                  title:
                                                                      'Ocurrió un error',
                                                                  confirmBtnText:
                                                                      'Hecho',
                                                                  confirmBtnColor:
                                                                      AppTema
                                                                          .pizazz,
                                                                  onConfirmBtnTap:
                                                                      () {
                                                                    context
                                                                        .pop();
                                                                  },
                                                                );
                                                              }
                                                            }
                                                          },
                                                          child: const Text(
                                                              'Asignar a Sala'),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 30),
                                          ],
                                        );
                                      },
                                    );
                            }
                          } else {
                            return const Center(
                                child: Text('¡Algo salió mal!'));
                          }
                        }),
                  ],
                ))));
  }
}
