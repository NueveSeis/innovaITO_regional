import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:uuid/uuid.dart';

class NivelAdminScreen extends ConsumerWidget {
  static const String name = 'nivel_admin';
  NivelAdminScreen({super.key});

  List<NivelAcademico> nivelesAcademicos = [];

  Future<void> getNivelAdmin(WidgetRef ref) async {
    String url = 'https://evarafael.com/Aplicacion/rest/get_nivelAcademico.php';
    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        nivelesAcademicos = nivelAcademicoFromJson(response.body);
      } else {
        print('La solicitud no fue exitosa: ${response.statusCode}');
      }
    } catch (error) {
      print('Error al realizar la solicitud: $error');
    }
  }

  Future<bool> agregarNivel(
    String idNiv,
    String nombreNivel,
    String descripcionNivel,
  ) async {
    var url = 'https://evarafael.com/Aplicacion/rest/agregar_nivel.php';
    try {
      var response = await http.post(Uri.parse(url), body: {
        'Id_nivel': 'NIV$idNiv',
        'Nombre_nivel': nombreNivel,
        'Descripcion_nivel': descripcionNivel
      });
      print('Código de estado de la respuesta: ${response.statusCode}');
      print('Cuerpo de la respuesta: ${response.body}');
      if (response.statusCode == 200) {
        print('Modificado en la db');
        return true;
      } else {
        print('No modificado');
        return false;
      }
    } catch (error) {
      print('Error durante la solicitud HTTP: $error');
      return false;
    }
  }

  Future<bool> eliminarNivel(String idNiv) async {
    var url =
        'https://evarafael.com/Aplicacion/rest/delete_nivel.php?Id_nivel=$idNiv'; // Reemplaza con la URL del archivo PHP en tu servidor
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      print('Modificado en la db');
      return true;
    } else {
      print('No modificado');
      return false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Nivel Académico',
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
                          'Agregar nivel academico',
                          style:
                              TextStyle(color: AppTema.grey100, fontSize: 17),
                        ),
                      ],
                    ),
                    onPressed: () {
                      _showDialogNivel(ref, context);
                    },
                  ),
                ),
                FutureBuilder(
                  future: getNivelAdmin(ref),
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
                          itemCount: nivelesAcademicos.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
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
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          nivelesAcademicos[index].idNivel,
                                          style: const TextStyle(
                                              color: AppTema.bluegrey700,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                          overflow: TextOverflow.visible,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Container(
                                              //isExpanded: true,
                                              //width: double.infinity,
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    nivelesAcademicos[index]
                                                        .nombreNivel,
                                                    style: const TextStyle(
                                                        color:
                                                            AppTema.bluegrey700,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                    overflow:
                                                        TextOverflow.visible,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    nivelesAcademicos[index]
                                                        .descripcionNivel,
                                                    style: const TextStyle(
                                                        color:
                                                            AppTema.bluegrey700,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 15),
                                                    overflow:
                                                        TextOverflow.visible,
                                                    textAlign:
                                                        TextAlign.justify,
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
                                                  builder:
                                                      (BuildContext context) {
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
                                                                fontSize: 25),
                                                          ),
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                          ListTile(
                                                            splashColor: AppTema
                                                                .primario,
                                                            title: const Text(
                                                              'Eliminar',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20),
                                                            ),
                                                            leading: const Icon(
                                                              Icons.delete,
                                                              color: AppTema
                                                                  .redA400,
                                                            ),
                                                            onTap: () async {
                                                              bool eliminado =
                                                                  await eliminarNivel(
                                                                      nivelesAcademicos[
                                                                              index]
                                                                          .idNivel);
                                                              if (eliminado) {
                                                                QuickAlert.show(
                                                                  context:
                                                                      context,
                                                                  type: QuickAlertType
                                                                      .success,
                                                                  title:
                                                                      'Eliminado correctamente',
                                                                  confirmBtnText:
                                                                      'Hecho',
                                                                  confirmBtnColor:
                                                                      AppTema
                                                                          .pizazz,
                                                                  onConfirmBtnTap:
                                                                      () {
                                                                    context.pushReplacementNamed(
                                                                        'nivel_admin');
                                                                  },
                                                                );
                                                              } else {
                                                                QuickAlert.show(
                                                                    context:
                                                                        context,
                                                                    type: QuickAlertType
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
                                                                    });
                                                              }
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                            icon: const Icon(
                                              Icons.more_vert_outlined,
                                              color: AppTema.bluegrey700,
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
                      return const Center(child: Text('¡Algo salió mal!'));
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }

  void _showDialogNivel(WidgetRef ref, BuildContext context) {
    String nombreNivel = '';
    String descripcionNivel = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Crear Nivel Académico'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                maxLines: null,
                decoration: const InputDecoration(
                    labelText: 'Nombre del nivel académico'),
                onChanged: (value) => nombreNivel = value,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Descripcion del nivel académico'),
                keyboardType: TextInputType.text,
                maxLines: null,
                onChanged: (value) => descripcionNivel = value,
              ),
              const SizedBox(height: 10),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                String idEst = const Uuid().v4().substring(0, 8);
                bool agregado =
                    await agregarNivel(idEst, nombreNivel, descripcionNivel);
                if (agregado) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: 'Agregado correctamente',
                    confirmBtnText: 'Hecho',
                    confirmBtnColor: AppTema.pizazz,
                    onConfirmBtnTap: () {
                      context.pushReplacementNamed('nivel_admin');
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
                      context.pop();
                    },
                  );
                }
              },
              child: const Text('Crear'),
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
