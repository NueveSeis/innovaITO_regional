import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innova_ito/providers/providers.dart';

import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/widgets/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class RequerimientosLiderScreen extends ConsumerWidget {
  static const String name = 'requerimientos_lider';
  RequerimientosLiderScreen({super.key});

  List<Requerimientos> requerimientos = [];

  Future<bool> fetchRequerimientos() async {
    String url = 'https://evarafael.com/Aplicacion/rest/get_requerimientos.php';

    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        requerimientos = requerimientosFromJson(response.body);
        return true;
      } else {
        // print('La solicitud no fue exitosa: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      return false;
      // print('Error al realizar la solicitud: $error');
    }
  }

  List<Requerimientos> misReq = [];
  Future<bool> misRequerimientos(String req) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/get_requerimientosWhere.php?Folio=$req';

    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        misReq = requerimientosFromJson(response.body);
        return true;
      } else {
        // print('La solicitud no fue exitosa: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      return false;
      //print('Error al realizar la solicitud: $error');
    }
  }

  Future<bool> agregarRequerimiento(String foliop, String idReq) async {
    var url =
        'https://evarafael.com/Aplicacion/rest/agregar_requerimientoProyecto.php'; // Reemplaza con la URL del archivo PHP en tu servidor
    var response = await http.post(Uri.parse(url), body: {
      'Folio': foliop,
      'Id_requerimientoEspecial': idReq,
    });
    if (response.statusCode == 200) {
      // print('Modificado en la db');
      return true;
    } else {
      //print('No modificado');
      return false;
    }
  }

  Future<bool> eliminarRequerimiento(String foliop, String idReq) async {
    var url =
        'https://evarafael.com/Aplicacion/rest/delete_requerimientoProyecto.php?Id_requerimientoEspecial=$idReq&folio=$foliop'; // Reemplaza con la URL del archivo PHP en tu servidor
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      // print('Modificado en la db');
      return true;
    } else {
      //print('No modificado');
      return false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folioPROV = ref.watch(folioProyectoUsuarioLogin);
    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Requerimientos especiales',
          fontSize: 20,
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Mis requerimientos:',
                  style: TextStyle(
                      color: AppTema.balticSea,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(height: 20),
                FutureBuilder(
                  future: misRequerimientos(folioPROV),
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
                          itemCount: misReq.length,
                          itemBuilder: (context, index) {
                            int valor = index + 1;
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
                                          valor.toString(),
                                          style: const TextStyle(
                                              color: AppTema.bluegrey700,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
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
                                                    misReq[index].tipo,
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
                                                                  await eliminarRequerimiento(
                                                                      folioPROV,
                                                                      requerimientos[
                                                                              index]
                                                                          .idRequerimientoEspecial);
                                                              if (eliminado) {
                                                                QuickAlert.show(
                                                                  context:
                                                                      context,
                                                                  type: QuickAlertType
                                                                      .success,
                                                                  title:
                                                                      'Requerimiento eliminado',
                                                                  confirmBtnText:
                                                                      'Hecho',
                                                                  confirmBtnColor:
                                                                      AppTema
                                                                          .pizazz,
                                                                  onConfirmBtnTap:
                                                                      () {
                                                                    context.pushReplacementNamed(
                                                                        'requerimientos_lider');
                                                                  },
                                                                );
                                                              } else {
                                                                QuickAlert.show(
                                                                  context:
                                                                      context,
                                                                  type:
                                                                      QuickAlertType
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
                                                                    context.pushReplacementNamed(
                                                                        'requerimientos_lider');
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
                const SizedBox(height: 50),
                const Text(
                  'Los únicos requerimientos especiales que podrán proporcionar la sede, cuando algún proyecto lo requiera, son los siguientes:',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: AppTema.balticSea,
                      fontWeight: FontWeight.normal,
                      fontSize: 18),
                ),
                FutureBuilder(
                  future: fetchRequerimientos(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: requerimientos.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: MaterialButton(
                                splashColor: AppTema.pizazz,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 35,
                                elevation: 15.0,
                                color: AppTema.grey100,
                                child: Container(
                                    child: Text(
                                  requerimientos[index].tipo,
                                  style: const TextStyle(
                                      color: AppTema.bluegrey700, fontSize: 18),
                                )),
                                onPressed: () async {
                                  bool agregado = await agregarRequerimiento(
                                      folioPROV,
                                      requerimientos[index]
                                          .idRequerimientoEspecial);

                                  if (agregado) {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.success,
                                      title: 'Requerimiento agregado',
                                      confirmBtnText: 'Hecho',
                                      confirmBtnColor: AppTema.pizazz,
                                      onConfirmBtnTap: () {
                                        context.pushReplacementNamed(
                                            'requerimientos_lider');
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
                                            'requerimientos_lider');
                                      },
                                    );
                                  }
                                }),
                          );
                        },
                      );
                    }
                  },
                ),
                const SizedBox(height: 30),
                const Text(
                  'Nota: Esto aplica para proyectos cuyo prototipo presenten exceso de dimensiones, como maquinarias o vehículos, o para proyectos que utilicen algún tipo de material peligroso o inflamable (gas, combustible).',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: AppTema.balticSea,
                      fontWeight: FontWeight.normal,
                      fontSize: 18),
                ),
                const SizedBox(height: 30),
                const Text(
                  'En el caso de los proyectos que para la operación del prototipo requieran de energía solar, únicamente se realizará de forma externa la demostración para la evaluación, el resto del tiempo los prototipos deberán permanecer en el stand asignado.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: AppTema.balticSea,
                      fontWeight: FontWeight.normal,
                      fontSize: 18),
                ),
              ],
            ),
          )),
    );
  }
}
