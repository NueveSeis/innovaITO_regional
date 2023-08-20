import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/widgets/widgets.dart';

import 'package:http/http.dart' as http;

class ProyectoEvaluarSreen extends ConsumerWidget {
  static const String name = 'proyectoEvaluarSreen';
  ProyectoEvaluarSreen({super.key});

  List<ProyectosEvaluar> proyectos = [];

  Future<void> getProyectosEvaluar(String idjur) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/get_proyectoJurado.php?Id_jurado=$idjur';
    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        proyectos = proyectosEvaluarFromJson(response.body);
      } else {
        print('La solicitud no fue exitosa: ${response.statusCode}');
      }
    } catch (error) {
      print('Error al realizar la solicitud: $error');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Evaluaciones',
          fontSize: 20,
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Mis proyectos pendientes',
                  style: TextStyle(
                      color: AppTema.balticSea,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                  future: getProyectosEvaluar('JUR94992'),
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
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    proyectos[index].folio,
                                                    textAlign: TextAlign.center,
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
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Nombre descriptivo: ',
                                                        style: TextStyle(
                                                            color: AppTema
                                                                .bluegrey700,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                        overflow: TextOverflow
                                                            .visible,
                                                      ),
                                                      Text(
                                                        proyectos[index]
                                                            .nombreProyecto,
                                                        style: const TextStyle(
                                                            color: AppTema
                                                                .bluegrey700,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 15),
                                                        overflow: TextOverflow
                                                            .visible,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Nombre corto: ',
                                                        style: TextStyle(
                                                            color: AppTema
                                                                .bluegrey700,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                        overflow: TextOverflow
                                                            .visible,
                                                      ),
                                                      Text(
                                                        proyectos[index]
                                                            .nombreCorto,
                                                        style: const TextStyle(
                                                            color: AppTema
                                                                .bluegrey700,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 15),
                                                        overflow: TextOverflow
                                                            .visible,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Area: ',
                                                        style: TextStyle(
                                                            color: AppTema
                                                                .bluegrey700,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                        overflow: TextOverflow
                                                            .visible,
                                                      ),
                                                      Text(
                                                        proyectos[index]
                                                            .nombreArea,
                                                        style: const TextStyle(
                                                            color: AppTema
                                                                .bluegrey700,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 15),
                                                        overflow: TextOverflow
                                                            .visible,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Categoria: ',
                                                        style: TextStyle(
                                                            color: AppTema
                                                                .bluegrey700,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                        overflow: TextOverflow
                                                            .visible,
                                                      ),
                                                      Text(
                                                        proyectos[index]
                                                            .nombreCategoria,
                                                        style: const TextStyle(
                                                            color: AppTema
                                                                .bluegrey700,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 15),
                                                        overflow: TextOverflow
                                                            .visible,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
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
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          )),
    );
  }
}
