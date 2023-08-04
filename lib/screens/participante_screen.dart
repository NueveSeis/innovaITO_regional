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

class ParticipanteScreen extends ConsumerWidget {
  static const String name = 'participantes';
  ParticipanteScreen({super.key});

  String matricula = '';
  List<DatosEstudiante> datosEstudiante = [];

  //Obtener matricula del
  Future<String> getMatricula(String idpersona) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/get_estudiante.php?Id_persona=$idpersona';
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      var datos = jsonDecode(response.body);
      matricula = datos[0]['Matricula'].toString();
      print('participante');
      print(matricula);
      await Future.delayed(Duration(seconds: 2));
      getDatosEstudiante(matricula);
      return matricula;
    } else {
      return '';
      print('Error al obtener datos de la API');
    }
  }

  //obtener datos del estudiante
  Future<void> getDatosEstudiante(String matricula) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/get_datosEstudiante.php?Matricula=$matricula';
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      //var datos = jsonDecode(response.body);
      print('object');
      datosEstudiante = datosEstudianteFromJson(response.body);
      await Future.delayed(const Duration(seconds: 3), () {
        print('Hola');
        print(datosEstudiante.length);
        print(datosEstudiante[0].nombrePersona);
        // print(datosEstudiante[1].nombrePersona);
      });
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
      print('object');
      var datos = jsonDecode(response.body);
      await Future.delayed(const Duration(seconds: 3), () {
        print(datos.length);
        print(datos[0]['Folio']);
        // print(datosEstudiante[1].nombrePersona);
      });
    } else {
      print('nisiquiera carga');
    }
  }

  Future<void> getMatriculaProyecto(String folio) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/get_MatriculasProyecto.php?Folio=$folio';
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      print('object');
      var datos = jsonDecode(response.body);
      await Future.delayed(const Duration(seconds: 3), () {
        print(datos.length);
        print(datos[0]['Matricula']);
        // print(datosEstudiante[1].nombrePersona);
      });
    } else {
      print('nisiquiera carga');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String matricula = ref.watch(matriculaProvider);

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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Agregar Particpante',
                          style:
                              TextStyle(color: AppTema.grey100, fontSize: 20),
                        ),
                      ],
                    ),
                    onPressed: () {
                      print(matricula);
                      getDatosEstudiante(matricula.toString());
                      getFolioProyecto(matricula);
                      getMatriculaProyecto('PRO2601');
                      //context.pushNamed('agregar_carrera');
                      // Navigator.pushNamed(context, 'agregar_carrera');
                    },
                  ),
                ),
                SingleChildScrollView(
                  child: Column(children: const [
                    TarjetaParticipante(),
                    TarjetaParticipante(),
                    TarjetaParticipante(),
                    TarjetaParticipante(),
                  ]),
                )
              ],
            ),
          )),
    );
  }
}
