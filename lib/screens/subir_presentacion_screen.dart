import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/helpers/helpers.dart';
import 'package:innova_ito/models/criterioRubrica.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:http/http.dart' as http;
import 'package:innova_ito/ui/input_decorations.dart';

import 'package:innova_ito/widgets/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class SubirPresentacionScreen extends ConsumerWidget {
  static const String name = 'SubirPresentacionScreen';
  SubirPresentacionScreen({super.key});

  Future<bool> modificarPresentacion(String foliop, dynamic nombre) async {
    var url =
        '${dotenv.env['HOST_REST']}upload_presentacionProyecto.php'; // Reemplaza con la URL del archivo PHP en tu servidor
    var response = await http.post(Uri.parse(url), body: {
      'Folio': foliop,
      'Video': nombre,
    });
    if (response.statusCode == 200) {
      //print('Modificado en la db');
      return true;
    } else {
      //print('No modificado');
      return false;
    }
  }

  Future<bool> eliminarPresentacion(String foliop) async {
    var url =
        '${dotenv.env['HOST_REST']}delete_presentacionProyecto.php'; // Reemplaza con la URL del archivo PHP en tu servidor
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController linkPresentacion = TextEditingController();
    final String? folioProv = ref.watch(buscarProyectoRegionalProv);
    return Scaffold(
      body: FondoGn(
          tituloPantalla: 'Presentación',
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
                                'No se encontró su proyecto',
                                style: TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          );
                        } else {
                          if (proyecto.first.video == null) {
                            return Column(
                              children: [
                                const SizedBox(height: 50),
                                const Text(
                                  'Subir enlace de la presentación',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppTema.balticSea,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Form(
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: linkPresentacion,
                                        style: const TextStyle(
                                            color: AppTema.bluegrey700,
                                            fontWeight: FontWeight.bold),
                                        autocorrect: false,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecorations
                                            .registroLiderDecoration(
                                          hintText:
                                              'Ingrese el enlace de la presentación',
                                          labelText:
                                              'Enlace de la presentación',
                                        ),
                                        //onChanged: (value) => registroLider.nombre = value,
                                        validator: (value) {
                                          return RegexUtil.esLink
                                                  .hasMatch(value ?? '')
                                              ? null
                                              : 'Enlace no válido.';
                                        },
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      const Text(
                                        'Recuerde: El archivo debe ser en formato pptx.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: AppTema.bluegrey700,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Text(
                                        'NOTA: Revisar los permisos del archivo a compartir.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: AppTema.bluegrey700,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          String url = linkPresentacion.text;
                                          String fileId =
                                              extractGoogleDocsFileId(url);
                                          print(fileId);
                                          // String urlDownload =
                                          //     'https://drive.google.com/uc?id=' +
                                          //         fileId +
                                          //         '&export=download';
                                          // await downloadFile(
                                          //     urlDownload, 'simon');

                                          bool modificado =
                                              await modificarPresentacion(
                                                  folioProv.toString(), url);
                                          if (modificado) {
                                            QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.success,
                                                title:
                                                    'Enlace subido con exito',
                                                confirmBtnText: 'Aceptar',
                                                confirmBtnColor: AppTema.pizazz,
                                                onConfirmBtnTap: () {
                                                  context.pushReplacementNamed(
                                                      'SubirPresentacionScreen');
                                                });
                                          } else {
                                            QuickAlert.show(
                                              context: context,
                                              type: QuickAlertType.error,
                                              title: 'Ocurrió un error',
                                              confirmBtnText: 'Aceptar',
                                              confirmBtnColor: AppTema.pizazz,
                                              onConfirmBtnTap: () {
                                                context.pushReplacementNamed(
                                                    'SubirPresentacionScreen');
                                              },
                                            );
                                          }
                                        },
                                        child: const Text(
                                          "Enviar Enlace",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Column(children: [
                              const SizedBox(height: 50),
                              const Text('Has subido un enlace anteriormente.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppTema.bluegrey700,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              const SizedBox(
                                height: 50,
                              ),
                              const Text(
                                  'NOTA: Si realiza modificaciones en su presentación, recuerde subir nuevamente el enlace de su archivo.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: AppTema.bluegrey700,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              const SizedBox(
                                height: 40,
                              ),
                              const Text(
                                  '¿Desea eliminar el enlace y volverlo a subir?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppTema.bluegrey700,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18)),
                              const SizedBox(
                                height: 50,
                              ),
                              ElevatedButton(
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Eliminar enlace',
                                        style: TextStyle(
                                          color: AppTema.grey100,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onPressed: () async {
                                  final bool eliminado =
                                      await eliminarPresentacion(
                                          folioProv.toString());

                                  if (eliminado) {
                                    QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.success,
                                        title: 'Enlace eliminado',
                                        confirmBtnText: 'Aceptar',
                                        confirmBtnColor: AppTema.pizazz,
                                        onConfirmBtnTap: () {
                                          context.pushReplacementNamed(
                                              'SubirPresentacionScreen');
                                        });
                                  } else {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      title: 'Ocurrió un error',
                                      confirmBtnText: 'Aceptar',
                                      confirmBtnColor: AppTema.pizazz,
                                      onConfirmBtnTap: () {
                                        context.pushReplacementNamed(
                                            'SubirPresentacionScreen');
                                      },
                                    );
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 50,
                              ),
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

  String extractGoogleDocsFileId(String url) {
    Match? match = RegexUtil.idDoc.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!;
    } else {
      return 'ID no encontrado';
    }
  }
}
