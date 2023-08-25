import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:innova_ito/helpers/helpers.dart';

import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/widgets/widgets.dart';

import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:pdf/widgets.dart' as pw;

class ProyectoCoordinadorScreen extends ConsumerWidget {
  static const String name = 'proyecto_coordinador';
  ProyectoCoordinadorScreen({super.key});

  List<ProyectoCoord> proyectos = [];

  Future<bool> getProyectosCoordinador(String id) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/get_proyectoCoordinador.php?Id_coordinador=$id';
    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        proyectos = proyectoCoordFromJson(response.body);
        return true;
      } else {
        return false;
        print('La solicitud no fue exitosa: ${response.statusCode}');
      }
    } catch (error) {
      return false;
      print('Error al realizar la solicitud: $error');
    }
  }

  Future<bool> putProyectosCoordinador(
      String folio, String campo1, String valor1) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/update_proyectoCoordinador.php';
    try {
      var response = await http.put(Uri.parse(url),
          body: jsonEncode(<String, dynamic>{
            'folio': folio,
            campo1: valor1,
          }));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
        print('La solicitud no fue exitosa: ${response.statusCode}');
      }
    } catch (error) {
      return false;
      print('Error al realizar la solicitud: $error');
    }
  }

  Future<String> createPDF(List<ProyectoCoord> proyecto, int index) async {
    final pdf = pw.Document();
    final educacion = await networkImage(
        'https://evarafael.com/Aplicacion/rest/logos/educacion.png');
    final tecnm = await networkImage(
        'https://evarafael.com/Aplicacion/rest/logos/tecnm.png');
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image(tecnm, width: 100, height: 100),
                  pw.Image(educacion, width: 100, height: 100)
                ],
              ),
              pw.Center(
                child: pw.Text('InnovaITO 2023',
                    style: const pw.TextStyle(fontSize: 20)),
              ),
              pw.Center(
                child: pw.Text('Ficha Técnica',
                    style: const pw.TextStyle(fontSize: 18)),
              ),
              pw.Text('MEMORIA DEL PROYECTO',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  )),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                //context: pw.Context()..style = pw.TextStyle(fontSize: 12),
                columnWidths: {
                  0: const pw.FixedColumnWidth(
                      150), // Ancho de la primera columna
                  1: const pw.FixedColumnWidth(
                      300), // Ancho de la segunda columna
                },
                data: <List<String>>[
                  ['Folio:', proyectos[index].folio],
                  ['Nombre corto:', proyectos[index].nombreCorto],
                  ['Nombre descriptivo:', proyectos[index].nombreProyecto],
                  ['Categoría:', proyectos[index].nombreCategoria],
                  ['Sector estratégico:', proyectos[index].nombreArea],
                  ['Naturaleza técnica:', proyectos[index].tipo],
                ],
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/example2.pdf');

    await file.writeAsBytes(await pdf.save());

    print('PDF creado en: ${file.path}');
    return file.path;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final juradoID = ref.watch(juradoIDProvider);
    // print(juradoID);
    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Mis proyectos',
          fontSize: 20,
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Proyectos',
                  style: TextStyle(
                      color: AppTema.balticSea,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(height: 20),
                FutureBuilder(
                  future: getProyectosCoordinador('COO01'),
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
                        return proyectos.isEmpty
                            ? const Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    'No hay proyectos aprobados por los asesores',
                                    textAlign: TextAlign.center,
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
                                itemCount: proyectos.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    elevation: 10,
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 350,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: AppTema.grey100,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Column(children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 25,
                                                  ),
                                                  Text(
                                                    proyectos[index]
                                                        .nombreProyecto,
                                                    style: const TextStyle(
                                                        color:
                                                            AppTema.bluegrey700,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    proyectos[index]
                                                        .nombreCorto,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color:
                                                            AppTema.bluegrey700,
                                                        //fontWeight: FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Categoria: ${proyectos[index].nombreCategoria}',
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                        color:
                                                            AppTema.bluegrey700,
                                                        fontSize: 12),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Area: ${proyectos[index].nombreArea}',
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                        color:
                                                            AppTema.bluegrey700,
                                                        fontSize: 12),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Naturaleza Técnica: ${proyectos[index].tipo}',
                                                    style: const TextStyle(
                                                        color:
                                                            AppTema.bluegrey700,
                                                        fontSize: 12),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  // Text(
                                                  //   'Observaciones Asesora: ${proyectos[index].observaciones}',
                                                  //   style: const TextStyle(
                                                  //       color: AppTema.bluegrey700,
                                                  //       fontSize: 12),
                                                  // ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  children: [
                                                    IconButton(
                                                        icon: const Icon(
                                                            Icons
                                                                .cloud_download_rounded,
                                                            size: 25),
                                                        onPressed: () async {
                                                          String si = await pdf
                                                              .registro('Hola');
                                                          // String ruta =
                                                          //     await createPDF(
                                                          //         proyectos, index);
                                                          OpenFilex.open(si);
                                                        },
                                                        color: AppTema
                                                            .bluegrey700),
                                                    const Text(
                                                      'Descargar',
                                                      style: TextStyle(
                                                        color:
                                                            AppTema.bluegrey700,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Switch(
                                                      value: (proyectos[index]
                                                                  .estado !=
                                                              '1')
                                                          ? false
                                                          : true,
                                                      onChanged: (value) async {
                                                        bool actua =
                                                            await putProyectosCoordinador(
                                                                proyectos[index]
                                                                    .folio,
                                                                'Estado',
                                                                (value)
                                                                    ? '1'
                                                                    : '2');
                                                        if (actua) {
                                                          QuickAlert.show(
                                                            context: context,
                                                            type: QuickAlertType
                                                                .success,
                                                            title:
                                                                'Estado modificado',
                                                            confirmBtnText:
                                                                'Hecho',
                                                            confirmBtnColor:
                                                                AppTema.pizazz,
                                                            onConfirmBtnTap:
                                                                () {
                                                              context.pushReplacementNamed(
                                                                  'proyecto_coordinador');
                                                            },
                                                          );
                                                        } else {
                                                          QuickAlert.show(
                                                            context: context,
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
                                                              context.pushReplacementNamed(
                                                                  'proyecto_coordinador');
                                                            },
                                                          );
                                                        }
                                                      },
                                                      activeColor:
                                                          AppTema.pizazz,
                                                    ),
                                                    const Text(
                                                      'Aceptar',
                                                      style: TextStyle(
                                                        color:
                                                            AppTema.bluegrey700,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ]),
                                        ),
                                        Positioned(
                                          top: 10,
                                          right: 10,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            decoration: BoxDecoration(
                                              color: (proyectos[index].estado !=
                                                      '1')
                                                  ? Colors.red
                                                  : Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              'Estado',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
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

  void _showDialogComentarios(String folio, BuildContext context) {
    String comentario = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Añada retroalimentación'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                maxLines: null,
                decoration: const InputDecoration(
                    labelText: 'Ingrese retroalimentación'),
                onChanged: (value) => comentario = value,
              ),
              const SizedBox(height: 10),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                bool comEnviado = await putProyectosCoordinador(
                    folio, 'Observaciones', comentario);
                if (comEnviado) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: 'Retroalimentación enviada',
                    confirmBtnText: 'Hecho',
                    confirmBtnColor: AppTema.pizazz,
                    onConfirmBtnTap: () {
                      context.pushReplacementNamed('proyecto_coordinador');
                    },
                  );
                } else {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Ocurrió un error',
                    confirmBtnText: 'Hecho',
                    confirmBtnColor: AppTema.pizazz,
                    onConfirmBtnTap: () {
                      context.pushReplacementNamed('proyecto_coordinador');
                    },
                  );
                }
              },
              child: const Text('Enviar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
