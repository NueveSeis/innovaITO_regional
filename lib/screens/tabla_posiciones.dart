import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:innova_ito/models/models.dart';

import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/widgets/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:innova_ito/helpers/helpers.dart';

class TablaPosicionesScreen extends StatelessWidget {
  static const String name = 'tabla_posiciones';
  TablaPosicionesScreen({super.key});

  List<Tablero> tablero = [];

  Future obtenerPosiciones() async {
    var url = 'https://evarafael.com/Aplicacion/rest/get_proyectos.php';
    var response = await http.get(Uri.parse(url));
    tablero = tableroFromJson(response.body);
    tablero.sort((a, b) => double.parse(b.calificacionGlobal)
        .compareTo(double.parse(a.calificacionGlobal)));
    print('hola');
    print(tablero[0].nombreArea);
  }

  List<AsignarCalificacionFinal> calificaciones = [];

  Future<bool> obtenerCalificaciones() async {
    var url =
        'https://evarafael.com/Aplicacion/rest/get_ObtenerCalificacionFinal.php';

    try {
      var response = await http.get(Uri.parse(url));
      calificaciones = asignarCalificacionFinalFromJson(response.body);
      return true;
    } catch (e) {
      print('Error al obtener las calificaciones: $e');
      return false;
    }
  }

  Future<bool> asignarCalificacionProyecto(String folio, String califica,
      String eAcreditacion, String eEvaluacion, String posicion) async {
    String url = 'https://evarafael.com/Aplicacion/rest/update_proyecto.php';
    try {
      var response = await http.post(Uri.parse(url), body: {
        'Folio': folio,
        'Calificacion_global': califica,
        'Estado_acreditacion': eAcreditacion,
        'Estado_evaluacion': eEvaluacion,
        'Posicion_actual': posicion
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        print('La solicitud no fue exitosa: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error al realizar la solicitud: $error');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Fondo(
        tituloPantalla: 'Tablero de posiciones',
        fontSize: 20,
        widget: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: obtenerPosiciones(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      // return Center(
                      //     child: Text('Error: ${snapshot.error.toString()}'));
                      return Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            'Calificaciones no asignadas',
                            style: TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Container(
                            height: 90,
                            width: size.width / 2,
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: ElevatedButton(
                              child: const Center(
                                  child: Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Icon(Icons.gavel_rounded),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Asignar calificaciones finales',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: AppTema.grey100, fontSize: 15),
                                  ),
                                ],
                              )),
                              onPressed: () async {
                                bool obt = await obtenerCalificaciones();
                                int pos = 0;
                                if (obt) {
                                  for (var calificacion in calificaciones) {
                                    print(
                                        'Calif: ${calificacion.calificacionGlobal}');
                                    print('Nombre: ${calificacion.folio}');
                                    pos = pos + 1;
                                    String estadoA = double.parse(calificacion
                                                .calificacionGlobal) >=
                                            70.0
                                        ? '1'
                                        : '2';
                                    await asignarCalificacionProyecto(
                                        calificacion.folio,
                                        calificacion.calificacionGlobal,
                                        estadoA,
                                        '1',
                                        pos.toString());
                                    // Imprime los demás datos que necesites
                                  }
                                } else {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.error,
                                    title: 'Error',
                                    text:
                                        'No se puedieron obtener las calificaciones.',
                                    confirmBtnText: 'Hecho',
                                    confirmBtnColor: AppTema.pizazz,
                                    onConfirmBtnTap: () {
                                      context.pushReplacementNamed(
                                          'tabla_posiciones');
                                    },
                                  );
                                }
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.success,
                                  title: 'Calificaciones asignadas',
                                  confirmBtnText: 'Hecho',
                                  confirmBtnColor: AppTema.pizazz,
                                  onConfirmBtnTap: () {
                                    context.pushReplacementNamed(
                                        'tabla_posiciones');
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          Container(
                            height: 50,
                            width: size.width / 2,
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: ElevatedButton(
                              child: const Center(
                                  child: Column(
                                children: [
                                  Icon(Icons.cloud_download_rounded),
                                  Text(
                                    'Descargar tablero',
                                    style: TextStyle(
                                        color: AppTema.grey100, fontSize: 15),
                                  ),
                                ],
                              )),
                              onPressed: () async {
                                String ruta = await pdf.posiciones(tablero);
                                OpenFilex.open(ruta);
                              },
                            ),
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: tablero.length,
                            itemBuilder: (context, index) {
                              return CardPosiciones(
                                posicion: index + 1,
                                nombreCategoria: tablero[index].nombreCategoria,
                                nombreProyecto: tablero[index].nombreCorto,
                                nombreTecnologico: tablero[index].nombreArea,
                                calificacion: tablero[index].calificacionGlobal,
                              );
                            },
                          ),
                        ],
                      );
                    }
                  } else {
                    return const Center(child: Text('Something went wrong!'));
                  }
                },
              ),
            ],
          ),
        ));
  }
}
