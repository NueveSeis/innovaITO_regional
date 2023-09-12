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
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NaturalezaAdminScreen extends ConsumerWidget {
  static const String name = 'naturaleza_admin';
  NaturalezaAdminScreen({super.key});

  List<Naturaleza> naturaleza = [];

  Future<void> getNaturaleza(WidgetRef ref) async {
    String url = '${dotenv.env['HOST_REST']}get_naturalezas.php';
    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        naturaleza = naturalezaFromJson(response.body);
      } else {
        // print('La solicitud no fue exitosa: ${response.statusCode}');
      }
    } catch (error) {
      //print('Error al realizar la solicitud: $error');
    }
  }

  Future<bool> agregarNaturaleza(
    String idNat,
    String tipo,
  ) async {
    var url = '${dotenv.env['HOST_REST']}agregar_naturaleza.php';
    try {
      var response = await http.post(Uri.parse(url),
          body: {'Id_naturalezaTecnica': 'NAT$idNat', 'Tipo': tipo});
      //print('Código de estado de la respuesta: ${response.statusCode}');
      //print('Cuerpo de la respuesta: ${response.body}');
      if (response.statusCode == 200) {
        //print('Modificado en la db');
        return true;
      } else {
        //print('No modificado');
        return false;
      }
    } catch (error) {
      //print('Error durante la solicitud HTTP: $error');
      return false;
    }
  }

  Future<bool> eliminarNaturaleza(String idNat) async {
    var url =
        '${dotenv.env['HOST_REST']}delete_naturaleza.php?Id_naturalezaTecnica=$idNat'; // Reemplaza con la URL del archivo PHP en tu servidor
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      //print('Modificado en la db');
      return true;
    } else {
      //print('No modificado');
      return false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Naturaleza Técnica',
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
                          'Agregar Naturaleza Técnica',
                          style:
                              TextStyle(color: AppTema.grey100, fontSize: 18),
                        ),
                      ],
                    ),
                    onPressed: () {
                      _showDialogNaturaleza(ref, context);
                    },
                  ),
                ),
                FutureBuilder(
                  future: getNaturaleza(ref),
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
                          itemCount: naturaleza.length,
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
                                          naturaleza[index].idNaturalezaTecnica,
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
                                                    naturaleza[index].tipo,
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
                                                                  await eliminarNaturaleza(
                                                                      naturaleza[
                                                                              index]
                                                                          .idNaturalezaTecnica);
                                                              if (eliminado) {
                                                                QuickAlert.show(
                                                                  context:
                                                                      context,
                                                                  type: QuickAlertType
                                                                      .success,
                                                                  title:
                                                                      'Naturaleza técnica eliminada',
                                                                  confirmBtnText:
                                                                      'Hecho',
                                                                  confirmBtnColor:
                                                                      AppTema
                                                                          .pizazz,
                                                                  onConfirmBtnTap:
                                                                      () {
                                                                    context.pushReplacementNamed(
                                                                        'naturaleza_admin');
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

  void _showDialogNaturaleza(WidgetRef ref, BuildContext context) {
    String nombreNaturaleza = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Crear Naturaleza Técnica'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                maxLines: null,
                decoration: const InputDecoration(
                    labelText: 'Nombre de la naturaleza técnica'),
                onChanged: (value) => nombreNaturaleza = value,
              ),
              const SizedBox(height: 10),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                String idNat = const Uuid().v4().substring(0, 8);
                bool agregado =
                    await agregarNaturaleza(idNat, nombreNaturaleza);
                if (agregado) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: 'Naturaleza técnica agregada',
                    confirmBtnText: 'Hecho',
                    confirmBtnColor: AppTema.pizazz,
                    onConfirmBtnTap: () {
                      context.pushReplacementNamed('naturaleza_admin');
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
