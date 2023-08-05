import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:html_editor_enhanced/utils/utils.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/widgets/tarjeta_participante.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/models/models.dart';

import 'package:innova_ito/widgets/widgets.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

class ParticipanteScreen extends ConsumerWidget {
  static const String name = 'participantes';
  ParticipanteScreen({super.key});

  String matricula = '';
  List<DatosEstudiante> datosEstudiantes = [];
  List matriculasParticpantes = [];
  List folio = [];

  //obtener datos del estudiante
  Future<void> getDatosEstudiante(String folio, WidgetRef ref) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/get_participanteProyecto.php?Folio=$folio';
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      datosEstudiantes = datosEstudianteFromJson(response.body);
      ref
          .read(numParticipantes.notifier)
          .update((state) => datosEstudiantes.length);
    } else {
      print('nisiquiera carga');
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
          tituloPantalla: 'Participantes',
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
                          'Agregar Particpante',
                          style:
                              TextStyle(color: AppTema.grey100, fontSize: 20),
                        ),
                      ],
                    ),
                    onPressed: nParticipantesProv >= 5
                        ? null
                        : () {
                            context.pushNamed('agregar_participantes');
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
                                    return TarjetaParticipante(
                                      numero: index + 1,
                                      nombre: datosEstudiantes[index]
                                              .nombrePersona +
                                          ' ' +
                                          datosEstudiantes[index]
                                              .apellido1
                                              .toString() +
                                          ' ' +
                                          datosEstudiantes[index]
                                              .apellido2
                                              .toString(),
                                      semestre: datosEstudiantes[index]
                                          .numeroSemestre
                                          .toString(),
                                      control:
                                          datosEstudiantes[index].matricula,
                                      carrera:
                                          datosEstudiantes[index].nombreCarrera,
                                      folio: folioProv.toString(),
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
}
