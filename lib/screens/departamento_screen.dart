import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:innova_ito/models/models.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:uuid/uuid.dart';

class DepartamentoScreen extends ConsumerWidget {
  static const String name = 'departamento';

  List<Departamento> departamentos = [];

  Future<void> obtenerDepartamento() async {
    var url =
        'https://evarafael.com/Aplicacion/rest/get_departamento.php?Clave_tecnologico=TEC01';
    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        departamentos = departamentoFromJson(response.body);
      } else {
        print('La solicitud no fue exitosa: ${response.statusCode}');
      }
    } catch (error) {
      print('Error al realizar la solicitud: $error');
    }
  }

  Future<bool> agregarDepartamento(
    String idDep,
    String nombreDep,
    String tec,
  ) async {
    var url = 'https://evarafael.com/Aplicacion/rest/agregar_departamento.php';
    // Reemplaza con la URL del archivo PHP en tu servidor
    try {
      var response = await http.post(Uri.parse(url), body: {
        'Id_departamento': 'DEP$idDep',
        'Nombre_departamento': nombreDep,
        'Clave_tecnologico': tec
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

  Future<bool> eliminarDepartamento(String idDep, String claveTec) async {
    var url =
        'https://evarafael.com/Aplicacion/rest/delete_proyecto.php?Id_departamento=$idDep&Clave_tecnologico=$claveTec'; // Reemplaza con la URL del archivo PHP en tu servidor
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
        tituloPantalla: 'Departamentos',
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
                      Icon(Icons.add_circle_outline_rounded),
                      Text(
                        '  Añadir departamento',
                        style: TextStyle(color: AppTema.grey100, fontSize: 25),
                      ),
                    ],
                  ),
                  onPressed: () {
                    _showDialogDepartamento(ref, context);
                  },
                ),
              ),
              Column(
                children: [
                  FutureBuilder(
                    future: obtenerDepartamento(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(
                              child:
                                  Text('Error: ${snapshot.error.toString()}'));
                        } else {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: departamentos.length,
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
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                      departamentos[index]
                                                          .nombreDepartamento,
                                                      style: const TextStyle(
                                                          color: AppTema
                                                              .bluegrey700,
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
                                                              splashColor:
                                                                  AppTema
                                                                      .primario,
                                                              title: const Text(
                                                                'Eliminar',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                              leading:
                                                                  const Icon(
                                                                Icons.delete,
                                                                color: AppTema
                                                                    .redA400,
                                                              ),
                                                              onTap: () async {
                                                                bool eliminado = await eliminarDepartamento(
                                                                    departamentos[
                                                                            index]
                                                                        .idDepartamento,
                                                                    departamentos[
                                                                            index]
                                                                        .claveTecnologico);
                                                                if (eliminado) {
                                                                  QuickAlert
                                                                      .show(
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
                                                                          'departamento');
                                                                    },
                                                                  );
                                                                } else {
                                                                  QuickAlert
                                                                      .show(
                                                                    context:
                                                                        context,
                                                                    type: QuickAlertType
                                                                        .error,
                                                                    title:
                                                                        'Ocurrio un error',
                                                                    confirmBtnText:
                                                                        'Hecho',
                                                                    confirmBtnColor:
                                                                        AppTema
                                                                            .pizazz,
                                                                    onConfirmBtnTap:
                                                                        () {
                                                                      context
                                                                          .pop();
                                                                    },
                                                                  );
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
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showDialogDepartamento(WidgetRef ref, BuildContext context) {
    String nombreDep = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Crear departamento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                maxLines: null,
                decoration:
                    const InputDecoration(labelText: 'Nombre del departamento'),
                onChanged: (value) => nombreDep = value,
              ),
              const SizedBox(height: 10),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                String idDep = Uuid().v4().substring(0, 8);
                bool agregado =
                    await agregarDepartamento(idDep, nombreDep, 'TEC01');
                if (agregado) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: 'Agregado correctamente',
                    confirmBtnText: 'Hecho',
                    confirmBtnColor: AppTema.pizazz,
                    onConfirmBtnTap: () {
                      context.pushReplacementNamed('departamento');
                    },
                  );
                } else {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Ocurrio un error',
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
