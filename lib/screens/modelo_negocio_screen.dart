import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:open_filex/open_filex.dart';

class ModeloNegocioScreen extends ConsumerWidget {
  static const String name = 'modelo_negocio';
  ModeloNegocioScreen({super.key});

  Future<bool> uploadPDF(File pdf, String nombre) async {
    var url = Uri.parse(
        '${dotenv.env['HOST_REST']}upload_modeloNegocios.php'); // Reemplaza con la URL del archivo PHP en tu servidor

    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('file', pdf.path,
        filename: '$nombre'));

    var response = await request.send();

    if (response.statusCode == 200) {
      //print('PDF subido exitosamente');
      return true;
    } else {
      //print('Error al subir el PDF');
      return false;
    }
  }

  Future<bool> modificarModelo(String foliop, dynamic nombre) async {
    var url =
        '${dotenv.env['HOST_REST']}update_modeloNegocio.php'; // Reemplaza con la URL del archivo PHP en tu servidor
    var response = await http.post(Uri.parse(url), body: {
      'Folio': foliop,
      'Modelo': nombre,
    });
    if (response.statusCode == 200) {
      //print('Modificado en la db');
      return true;
    } else {
      //print('No modificado');
      return false;
    }
  }

  Future<bool> eliminarModelo(String foliop) async {
    var url =
        '${dotenv.env['HOST_REST']}delete_modeloNegocio.php'; // Reemplaza con la URL del archivo PHP en tu servidor
    var response = await http.post(Uri.parse(url), body: {
      'Folio': foliop,
    });
    if (response.statusCode == 200) {
      //print('Modificado en la db');
      return true;
    } else {
      //print('No modificado');
      return false;
    }
  }

  List<Proyecto> proyecto = [];

  Future<void> getProyecto(String? folio) async {
    String url = '${dotenv.env['HOST_REST']}get_proyectoWhere.php?Folio=$folio';
    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        proyecto = proyectoFromJson(response.body);
      } else {
        //print('La solicitud no fue exitosa: ${response.statusCode}');
      }
    } catch (error) {
      //print('Error al realizar la solicitud: $error');
    }
  }

  // URL del archivo que deseas descargar
  Future<String> downloadFile(String url, String fileName) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final appDir = await getApplicationDocumentsDirectory();
      final filePath = '${appDir.path}/$fileName';

      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      //print('Archivo descargado en: $filePath');
      return filePath;
    } else {
      throw Exception('Error al descargar el archivo');
    }
  }

  void eliminarArchivo(String nombreArchivo) async {
    final response = await http.post(
      Uri.parse('${dotenv.env['HOST_REST']}delete_archivoSModelo.php'),
      body: {'nombre_archivo': nombreArchivo},
    );

    if (response.statusCode == 200) {
      //print('Archivo eliminado correctamente.');
    } else {
      //print('Error al eliminar el archivo: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? folioProv = ref.watch(folioProyectoUsuarioLogin);
    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Modelo de negocio',
          fontSize: 20,
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                FutureBuilder(
                  future: getProyecto(folioProv),
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
                        if (proyecto.isEmpty) {
                          return const Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Text(
                                'Genere la ficha técnica',
                                style: TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          );
                        } else {
                          if (proyecto.first.modeloNegocio == null) {
                            return Column(
                              children: [
                                const SizedBox(height: 50),
                                const Text(
                                  'Selecciona el modelo de negocio',
                                  style: TextStyle(
                                      color: AppTema.balticSea,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  'El archivo debe ser en formato PDF.',
                                  style: TextStyle(
                                      color: AppTema.balticSea,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: ['pdf'],
                                    );

                                    if (result != null) {
                                      PlatformFile file = result.files.first;
                                      File archivo = File(file.path.toString());
                                      String nombre = file.name;
                                      print(file.name);
                                      print(file.bytes);
                                      print(file.size);
                                      print(file.extension);
                                      print(file.path);
                                      bool subido = await uploadPDF(
                                          archivo, 'ModeloNegocio_$nombre');
                                      if (subido) {
                                        bool modificado = await modificarModelo(
                                            folioProv.toString(),
                                            'ModeloNegocio_$nombre');
                                        if (modificado) {
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.success,
                                            title: 'Archivo subido',
                                            confirmBtnText: 'Hecho',
                                            confirmBtnColor: AppTema.pizazz,
                                            onConfirmBtnTap: () {
                                              context.pushReplacementNamed(
                                                  'modelo_negocio');
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
                                              context.pushReplacementNamed(
                                                  'modelo_negocio');
                                            },
                                          );
                                        }
                                      } else {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.error,
                                          title: 'Ocurrió un error',
                                          confirmBtnText: 'Hecho',
                                          confirmBtnColor: AppTema.pizazz,
                                          onConfirmBtnTap: () {
                                            context.pushReplacementNamed(
                                                'modelo_negocio');
                                          },
                                        );
                                      }
                                    } else {
                                      // User canceled the picker
                                    }
                                  },
                                  child: const Text("Seleccione el archivo"),
                                )
                              ],
                            );
                          } else {
                            return Column(children: [
                              const SizedBox(height: 50),
                              const Text(
                                  'Ya ha subido un archivo anteriormente.',
                                  style: TextStyle(
                                      color: AppTema.bluegrey700,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              const SizedBox(
                                height: 50,
                              ),
                              const Text('¿Qué desea hacer con el archivo?',
                                  style: TextStyle(
                                      color: AppTema.bluegrey700,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15)),
                              const SizedBox(
                                height: 50,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    child: const Center(
                                        child: Column(
                                      children: [
                                        Icon(Icons.cloud_download_rounded),
                                        Text(
                                          'Descargar archivo',
                                          style: TextStyle(
                                              color: AppTema.grey100,
                                              fontSize: 15),
                                        ),
                                      ],
                                    )),
                                    onPressed: () async {
                                      final String rutaArc =
                                          proyecto.first.modeloNegocio;
                                      //print(rutaArc);
                                      String url =
                                          '${dotenv.env['HOST_REST']}archivos/modelo/$rutaArc';
                                      //print(url);
                                      // Get the URL of the file to download.
                                      String rut =
                                          await downloadFile(url, rutaArc);
                                      OpenFilex.open(rut);
                                    },
                                  ),
                                  ElevatedButton(
                                    child: const Center(
                                        child: Column(
                                      children: [
                                        Icon(Icons.delete_rounded),
                                        Text(
                                          'Eliminar archivo',
                                          style: TextStyle(
                                              color: AppTema.grey100,
                                              fontSize: 15),
                                        ),
                                      ],
                                    )),
                                    onPressed: () async {
                                      final bool eliminado =
                                          await eliminarModelo(
                                              folioProv.toString());

                                      if (eliminado) {
                                        eliminarArchivo(
                                            proyecto.first.modeloNegocio);
                                        QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.success,
                                            title: 'Archivo eliminado',
                                            confirmBtnText: 'Hecho',
                                            confirmBtnColor: AppTema.pizazz,
                                            onConfirmBtnTap: () {
                                              context.pushReplacementNamed(
                                                  'modelo_negocio');
                                            });
                                      } else {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.error,
                                          title: 'Ocurrió un error',
                                          confirmBtnText: 'Hecho',
                                          confirmBtnColor: AppTema.pizazz,
                                          onConfirmBtnTap: () {
                                            context.pushReplacementNamed(
                                                'modelo_negocio');
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ],
                              )
                            ]);
                          }
                        }
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
