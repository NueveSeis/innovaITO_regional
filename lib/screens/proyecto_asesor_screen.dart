import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innova_ito/helpers/helpers.dart';

import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/widgets/widgets.dart';

import 'package:open_filex/open_filex.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProyectoAsesorScreen extends ConsumerWidget {
  static const String name = 'proyecto_asesor';
  ProyectoAsesorScreen({super.key});

  List<ProyectoAsesor> proyectos = [];

  Future<bool> getProyectosAsesor(String id) async {
    String url =
        '${dotenv.env['HOST_REST']}get_proyectoAsesor.php?Id_asesor=$id';
    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        proyectos = proyectoAsesorFromJson(response.body);
        return true;
      } else {
        return false;
        //print('La solicitud no fue exitosa: ${response.statusCode}');
      }
    } catch (error) {
      return false;
      //print('Error al realizar la solicitud: $error');
    }
  }

  Future<bool> putProyectosAsesor(
      String folio, String campo1, String valor1) async {
    String url = '${dotenv.env['HOST_REST']}update_proyectoAsesor.php';
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
        //print('La solicitud no fue exitosa: ${response.statusCode}');
      }
    } catch (error) {
      return false;
      //print('Error al realizar la solicitud: $error');
    }
  }

  Future<bool> agregarValidacionCoordinador(String coor, String foliop) async {
    var url =
        '${dotenv.env['HOST_REST']}agregar_validacionProyectoC.php'; // Reemplaza con la URL del archivo PHP en tu servidor
    try {
      var response = await http.post(Uri.parse(url), body: {
        'Id_coordinador': coor,
        'Folio': foliop,
      });
      if (response.statusCode == 200) {
        // print('Modificado en la db');
        return true;
      } else {
        //print('No modificado');
        return false;
      }
    } catch (e) {
      //print('Error al realizar la solicitud HTTP: $e');
      return false;
    }
  }

  Future<bool> eliminarValidacionC(String idcoor, String foliop) async {
    var url =
        '${dotenv.env['HOST_REST']}delete_validacionProyectoC.php?Id_coordinador=$idcoor&Folio=$foliop'; // Reemplaza con la URL del archivo PHP en tu servidor
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      //print('Modificado en la db');
      return true;
    } else {
      //print('No modificado');
      return false;
    }
  }

  // Future<String> createPDF(List<ProyectoAsesor> proyecto, int index) async {
  //   final pdf = pw.Document();
  //   final educacion = await networkImage(
  //       '${dotenv.env['HOST_REST']}logos/educacion.png');
  //   final tecnm = await networkImage(
  //       '${dotenv.env['HOST_REST']}logos/tecnm.png');
  //   pdf.addPage(
  //     pw.Page(
  //       build: (pw.Context context) {
  //         return pw.Column(
  //           children: [
  //             pw.Row(
  //               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //               children: [
  //                 pw.Image(tecnm, width: 100, height: 100),
  //                 pw.Image(educacion, width: 100, height: 100)
  //               ],
  //             ),
  //             pw.Center(
  //               child: pw.Text('InnovaITO 2023',
  //                   style: const pw.TextStyle(fontSize: 20)),
  //             ),
  //             pw.Center(
  //               child: pw.Text('Ficha Técnica',
  //                   style: const pw.TextStyle(fontSize: 18)),
  //             ),
  //             pw.Text('MEMORIA DEL PROYECTO',
  //                 style: pw.TextStyle(
  //                   fontSize: 18,
  //                   fontWeight: pw.FontWeight.bold,
  //                 )),
  //             pw.SizedBox(height: 20),
  //             pw.TableHelper.fromTextArray(
  //               //context: pw.Context()..style = pw.TextStyle(fontSize: 12),
  //               columnWidths: {
  //                 0: const pw.FixedColumnWidth(
  //                     150), // Ancho de la primera columna
  //                 1: const pw.FixedColumnWidth(
  //                     300), // Ancho de la segunda columna
  //               },
  //               data: <List<String>>[
  //                 ['Folio:', proyectos[index].folio],
  //                 ['Nombre corto:', proyectos[index].nombreCorto],
  //                 ['Nombre descriptivo:', proyectos[index].nombreProyecto],
  //                 ['Categoría:', proyectos[index].nombreCategoria],
  //                 ['Sector estratégico:', proyectos[index].nombreArea],
  //                 ['Naturaleza técnica:', proyectos[index].tipo],
  //               ],
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   );

  //   final output = await getTemporaryDirectory();
  //   final file = File('${output.path}/example2.pdf');

  //   await file.writeAsBytes(await pdf.save());

  //   print('PDF creado en: ${file.path}');
  //   return file.path;
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asesorID = ref.watch(asesorIDProvider);
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
                  future: getProyectosAsesor(asesorID),
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
                        return ListView.builder(
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
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Column(children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            Text(
                                              proyectos[index].nombreProyecto,
                                              style: const TextStyle(
                                                  color: AppTema.bluegrey700,
                                                  //fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              proyectos[index].nombreCorto,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: AppTema.bluegrey700,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Categoría: ${proyectos[index].nombreCategoria}',
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                  color: AppTema.bluegrey700,
                                                  fontSize: 12),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Área: ${proyectos[index].nombreArea}',
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                  color: AppTema.bluegrey700,
                                                  fontSize: 12),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Naturaleza Técnica: ${proyectos[index].tipo}',
                                              style: const TextStyle(
                                                  color: AppTema.bluegrey700,
                                                  fontSize: 12),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Observaciones realizadas: ${proyectos[index].observaciones ?? 'No tiene observaciones.'}',
                                              style: const TextStyle(
                                                  color: AppTema.bluegrey700,
                                                  fontSize: 12),
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
                                                    // String ruta =
                                                    //     await createPDF(
                                                    //         proyectos, index);
                                                    String ruta = await pdf.fichaTecnica(
                                                        proyectos[index].folio,
                                                        proyectos[index]
                                                            .nombreCorto,
                                                        proyectos[index]
                                                            .objetivo,
                                                        proyectos[index]
                                                            .descripcionGeneral,
                                                        proyectos[index]
                                                            .prospectoResultados,
                                                        proyectos[index]
                                                            .nombreArea,
                                                        proyectos[index]
                                                            .nombreCategoria,
                                                        proyectos[index]
                                                            .idMemoriaTecnica,
                                                        proyectos[index]
                                                            .descripcionProblematica,
                                                        proyectos[index]
                                                            .estadoArte,
                                                        proyectos[index]
                                                            .descripcionInnovacion,
                                                        proyectos[index]
                                                            .propuestaValor,
                                                        proyectos[index]
                                                            .mercadoPotencial,
                                                        proyectos[index]
                                                            .viabilidadTecnica,
                                                        proyectos[index]
                                                            .viabilidadFinanciera,
                                                        proyectos[index]
                                                            .estrategiaPropiedadIntelectual,
                                                        proyectos[index]
                                                            .interpretacionResultados,
                                                        proyectos[index]
                                                            .fuentesConsultadas,
                                                        proyectos[index]
                                                            .nombreProyecto,
                                                        proyectos[index].tipo);
                                                    OpenFilex.open(ruta);
                                                  },
                                                  color: AppTema.bluegrey700),
                                              const Text(
                                                'Descargar',
                                                style: TextStyle(
                                                  color: AppTema.bluegrey700,
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                    Icons.add_comment_rounded,
                                                    color: AppTema.bluegrey700,
                                                    size: 25),
                                                onPressed: () {
                                                  _showDialogComentarios(
                                                      proyectos[index].folio,
                                                      context);
                                                },
                                              ),
                                              //SizedBox(zi),
                                              const Text(
                                                'Observaciones',
                                                style: TextStyle(
                                                  color: AppTema.bluegrey700,
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Switch(
                                                value:
                                                    (proyectos[index].estado !=
                                                            '1')
                                                        ? false
                                                        : true,
                                                onChanged: (value) async {
                                                  bool add = false;
                                                  if (proyectos[index].estado ==
                                                      '1') {
                                                    add =
                                                        await eliminarValidacionC(
                                                            'COO01',
                                                            proyectos[index]
                                                                .folio);
                                                  } else {
                                                    add =
                                                        await agregarValidacionCoordinador(
                                                            'COO01',
                                                            proyectos[index]
                                                                .folio);
                                                  }

                                                  bool actua =
                                                      await putProyectosAsesor(
                                                          proyectos[index]
                                                              .folio,
                                                          'Estado',
                                                          (value) ? '1' : '2');
                                                  // print(proyectos[index].folio);
                                                  // print(value);
                                                  if (actua && add) {
                                                    QuickAlert.show(
                                                      context: context,
                                                      type: QuickAlertType
                                                          .success,
                                                      title:
                                                          'Estado modificado',
                                                      confirmBtnText: 'Hecho',
                                                      confirmBtnColor:
                                                          AppTema.pizazz,
                                                      onConfirmBtnTap: () {
                                                        context.pushReplacementNamed(
                                                            'proyecto_asesor');
                                                      },
                                                    );
                                                  } else {
                                                    QuickAlert.show(
                                                      context: context,
                                                      type:
                                                          QuickAlertType.error,
                                                      title: 'Ocurrió un error',
                                                      confirmBtnText: 'Hecho',
                                                      confirmBtnColor:
                                                          AppTema.pizazz,
                                                      onConfirmBtnTap: () {
                                                        context.pushReplacementNamed(
                                                            'proyecto_asesor');
                                                      },
                                                    );
                                                  }
                                                },
                                                activeColor: AppTema.pizazz,
                                              ),
                                              const Text(
                                                'Aceptar',
                                                style: TextStyle(
                                                  color: AppTema.bluegrey700,
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
                                        color: (proyectos[index].estado != '1')
                                            ? Colors.red
                                            : Colors.green,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Text(
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
                bool comEnviado = await putProyectosAsesor(
                    folio, 'Observaciones', comentario);
                if (comEnviado) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: 'Asesor asignado',
                    confirmBtnText: 'Hecho',
                    confirmBtnColor: AppTema.pizazz,
                    onConfirmBtnTap: () {
                      context.pushReplacementNamed('proyecto_asesor');
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
                      context.pushReplacementNamed('proyecto_asesor');
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
