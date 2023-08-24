import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/widgets/tarjeta_participante.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/widgets/widgets.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';

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
    final String? folioProv = ref.watch(folioProyectoUsuarioLogin);

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
                    onPressed: nParticipantesProv >= 5
                        ? null
                        : () {
                            context.pushNamed('agregar_participantes');
                          },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Agregar Participante',
                          style:
                              TextStyle(color: AppTema.grey100, fontSize: 20),
                        ),
                      ],
                    ),
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
                        print('Error: ${snapshot.error.toString()}');
                        return const Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              'No se encontraron datos',
                              style: TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        );
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
                                      idParticipante:
                                          datosEstudiantes[index].id.toString(),
                                      numero: index + 1,
                                      nombre:
                                          '${datosEstudiantes[index].nombrePersona} ${datosEstudiantes[index].apellido1} ${datosEstudiantes[index].apellido2}',
                                      semestre: datosEstudiantes[index]
                                              .numeroSemestre ??
                                          'no asignado',
                                      control:
                                          datosEstudiantes[index].matricula,
                                      carrera: datosEstudiantes[index]
                                              .nombreCarrera ??
                                          'No tiene carrera asignada',
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
