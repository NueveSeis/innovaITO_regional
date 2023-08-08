import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/widgets/tarjeta_participante.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/models/models.dart';

import 'package:innova_ito/widgets/widgets.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

class EstadoAdminScreen extends ConsumerWidget {
  static const String name = 'estado_admin';
  EstadoAdminScreen({super.key});

  String matricula = '';
  List<DatosEstudiante> datosEstudiantes = [];
  List matriculasParticpantes = [];
  List folio = [];

  //obtener datos del estudiante
  Future<void> getDatosEstudiante(String folio, WidgetRef ref) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/get_participanteProyecto.php?Folio=$folio';
    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        datosEstudiantes = datosEstudianteFromJson(response.body);
        ref
            .read(numParticipantes.notifier)
            .update((state) => datosEstudiantes.length);
      } else {
        print('La solicitud no fue exitosa: ${response.statusCode}');
      }
    } catch (error) {
      print('Error al realizar la solicitud: $error');
    }
  }

  //obtener forlio del proyecto del lider
  Future<void> getFolioProyecto(String matricula) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/get_Folio.php?Matricula=$matricula';
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      folio = jsonDecode(response.body);
    } else {
      print('nisiquiera carga');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String matriculaProv = ref.watch(matriculaProvider);
    final int nParticipantesProv = ref.watch(numParticipantes);
    final String folioProv = ref.watch(folioProyectoUsuarioLogin);

    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Estados',
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
                          'Agregar Estado',
                          style:
                              TextStyle(color: AppTema.grey100, fontSize: 20),
                        ),
                      ],
                    ),
                    onPressed: () {
                      _showDialogEstado(ref, context);
                    },
                  ),
                ),
                FutureBuilder(
                  future: getFolioProyecto(matriculaProv),
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
                        return FutureBuilder(
                          future: getDatosEstudiante(folio[0]['Folio'], ref),
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
                                return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: datosEstudiantes.length,
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
                                                Text(
                                                  index.toString(),
                                                  style: const TextStyle(
                                                      color:
                                                          AppTema.bluegrey700,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5),
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
                                                          Text(
                                                            'Cama King size ndjgddh dkwjdwdgw dkwjdkwdh',
                                                            style: const TextStyle(
                                                                color: AppTema
                                                                    .bluegrey700,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18),
                                                            overflow:
                                                                TextOverflow
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
                                                                          fontWeight: FontWeight
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
                                                                        () {},
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          });
                                                    },
                                                    icon: const Icon(
                                                      Icons.more_vert_outlined,
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
                                );
                              }
                            } else {
                              return const Center(
                                  child: Text('¡Algo salió mal!'));
                            }
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

  void _showDialogEstado(WidgetRef ref, BuildContext context) {
    String nombreEstado = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Crear Estado'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                maxLines: null,
                decoration: InputDecoration(labelText: 'Nombre del estado'),
                onChanged: (value) => nombreEstado = value,
              ),
              SizedBox(height: 10),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {},
              child: Text('Crear'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
