import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/widgets/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

class SeleccionCategoriaScreen extends ConsumerWidget {
  static const String name = 'seleccionar_categoria';

  SeleccionCategoriaScreen({super.key});

  bool isSelectCategoria = false;
  String categoriaSelec = '';
  String areaSelec = '';
  String idAreaSelec = '';
  List<Area> areas = [];
  List<Categoria> categorias = [];
  List<Preferencias> pref = [];
  Future obtenerAreas(String areaB) async {
    var url =
        'https://evarafael.com/Aplicacion/rest/get_area.php?Id_categoria=$areaB';
    var response = await http.get(Uri.parse(url));
    areas = areaFromJson(response.body);
  }

  Future obtenerCategorias() async {
    var url = 'https://evarafael.com/Aplicacion/rest/get_categorias.php';
    var response = await http.get(Uri.parse(url));
    categorias = categoriaFromJson(response.body);
  }

  Future obtenerPreferenciaWhere(String idJurado) async {
    var url =
        'https://evarafael.com/Aplicacion/rest/get_preferenciaWhereJurado.php?Id_jurado=$idJurado';
    var response = await http.get(Uri.parse(url));
    pref = preferenciasFromJson(response.body);
  }

  Future<bool> agregarPreferencia(String idjurado, String idarea) async {
    var url =
        'https://evarafael.com/Aplicacion/rest/agregar_preferencia.php'; // Reemplaza con la URL del archivo PHP en tu servidor
    var response = await http
        .post(Uri.parse(url), body: {'Id_jurado': idjurado, 'Id_area': idarea});
    if (response.statusCode == 200) {
      print('Modificado en la db');
      return true;
    } else {
      print('No modificado');
      return false;
    }
  }

  Future createQuickAlert(
      BuildContext context, bool type, String title, String text) {
    return QuickAlert.show(
      context: context,
      type: type ? QuickAlertType.info : QuickAlertType.error,
      title: title,
      text: text,
      confirmBtnText: 'Ok',
      confirmBtnColor: AppTema.pizazz,
      onConfirmBtnTap: () {
        Navigator.pop(context);
      },
    );
  }

  Color setBackgroundColor(String categoriaSelected, String categoriaEvaluar) {
    if (categoriaSelected == categoriaEvaluar) {
      return AppTema.pizazz;
    }
    return AppTema.grey100;
  }

  Color setTextColor(String categoriaSelected, String categoriaEvaluar) {
    if (categoriaSelected == categoriaEvaluar) {
      return AppTema.grey100;
    }
    return AppTema.bluegrey700;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String juradoID = ref.watch(juradoIDProvider);
    final String areaProv = ref.watch(areaProvider);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Área de interés',
          fontSize: 20,
          widget: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: FutureBuilder(
                  future: obtenerPreferenciaWhere(juradoID),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return pref.isEmpty
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Seleccione la categoría de interés',
                                  style: TextStyle(
                                      color: AppTema.balticSea,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                FutureBuilder(
                                    future: obtenerCategorias(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        return SizedBox(
                                          height: size.height * 0.4,
                                          //width: double.infinity,
                                          child: GridView.builder(
                                            scrollDirection: Axis.horizontal,
                                            gridDelegate:
                                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 150.0,
                                              mainAxisSpacing: 10.0,
                                              //crossAxisSpacing: 10.0,
                                              childAspectRatio: .50,
                                            ),
                                            itemCount: categorias.length,
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: MaterialButton(
                                                    splashColor: AppTema.pizazz,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    height: size.height * 0.4,
                                                    elevation: 5.0,
                                                    //color: AppTema.grey100,
                                                    color: setBackgroundColor(
                                                        categoriaSelec,
                                                        categorias[index]
                                                            .nombreCategoria),
                                                    child: Text(
                                                      categorias[index]
                                                          .nombreCategoria,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          //color: AppTema.bluegrey700,
                                                          color: setTextColor(
                                                              categoriaSelec,
                                                              categorias[index]
                                                                  .nombreCategoria),
                                                          fontSize: 20),
                                                    ),
                                                    onPressed: () {
                                                      ref
                                                              .read(areaProvider
                                                                  .notifier)
                                                              .state =
                                                          categorias[index]
                                                              .idCategoria;
                                                      isSelectCategoria = true;
                                                      categoriaSelec =
                                                          categorias[index]
                                                              .nombreCategoria;
                                                      //.toLowerCase();
                                                      // ref.read(areaProvider.notifier).update(
                                                      //       (state) =>
                                                      //           categorias[index].idCategoria,
                                                      //     );
                                                    }),
                                              );
                                            },
                                          ),
                                        );
                                      }
                                    }),
                                const SizedBox(
                                  height: 30,
                                ),
                                if (isSelectCategoria == true)
                                  Column(
                                    children: [
                                      FutureBuilder(
                                          future: obtenerAreas(areaProv),
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else {
                                              return Column(
                                                children: [
                                                  const Text(
                                                    'Seleccione su área de interés',
                                                    style: TextStyle(
                                                        color:
                                                            AppTema.balticSea,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: SizedBox(
                                                      height: size.height * 0.4,
                                                      width: double.infinity,
                                                      child: GridView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        gridDelegate:
                                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                          maxCrossAxisExtent:
                                                              150.0,
                                                          mainAxisSpacing: 10.0,
                                                          //crossAxisSpacing: 10.0,
                                                          childAspectRatio: 0.5,
                                                        ),
                                                        itemCount: areas.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                index) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom:
                                                                        8.0),
                                                            child:
                                                                MaterialButton(
                                                                    splashColor:
                                                                        AppTema
                                                                            .pizazz,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                    height: 35,
                                                                    elevation:
                                                                        5.0,
                                                                    //color: AppTema.grey100,
                                                                    color: setBackgroundColor(
                                                                        areaSelec,
                                                                        areas[index]
                                                                            .nombreArea),
                                                                    child: Text(
                                                                      areas[index]
                                                                          .nombreArea,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .fade,
                                                                      style: TextStyle(
                                                                          //color:AppTema.bluegrey700,
                                                                          color: setTextColor(areaSelec, areas[index].nombreArea),
                                                                          fontSize: 20),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      ref
                                                                          .read(areaProvider
                                                                              .notifier)
                                                                          .state = areas[
                                                                              index]
                                                                          .idCategoria;
                                                                      areaSelec =
                                                                          areas[index]
                                                                              .nombreArea;
                                                                      idAreaSelec =
                                                                          areas[index]
                                                                              .idArea;
                                                                    }),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                          }),
                                      Container(
                                        height: 50,
                                        width: double.infinity,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 10),
                                        child: ElevatedButton(
                                            child: const Center(
                                              child: Text(
                                                'Enviar',
                                                style: TextStyle(
                                                    color: AppTema.grey100,
                                                    fontSize: 25),
                                              ),
                                            ),
                                            onPressed: () async {
                                              print(idAreaSelec);

                                              bool agregado =
                                                  await agregarPreferencia(
                                                      juradoID, idAreaSelec);
                                              if (agregado) {
                                                QuickAlert.show(
                                                  context: context,
                                                  type: QuickAlertType.success,
                                                  title:
                                                      'Asignado correctamente',
                                                  confirmBtnText: 'Hecho',
                                                  confirmBtnColor:
                                                      AppTema.pizazz,
                                                  onConfirmBtnTap: () {
                                                    context
                                                        .pushReplacementNamed(
                                                            'inicioLider');
                                                  },
                                                );
                                              } else {
                                                QuickAlert.show(
                                                  context: context,
                                                  type: QuickAlertType.error,
                                                  title: 'Ocurrió un error',
                                                  confirmBtnText: 'Hecho',
                                                  confirmBtnColor:
                                                      AppTema.pizazz,
                                                  onConfirmBtnTap: () {
                                                    context.pop();
                                                  },
                                                );
                                              }
                                              // QuickAlert.show(
                                              //   context: context,
                                              //   type: QuickAlertType.info,
                                              //   title: '¿Estás seguro?',
                                              //   text:
                                              //       'Categoría: $categoriaSelec \nÁrea: $areaSelec',
                                              //   confirmBtnText: 'Sí',
                                              //   cancelBtnText: 'No',
                                              //   confirmBtnColor: Colors.green,
                                              //   onConfirmBtnTap: () {
                                              //     print("Confirmado");
                                              //     agregarPreferencia('JUR02', idAreaSelec);
                                              //     Navigator.pop(context);
                                              //   },
                                              // );
                                            }),
                                      ),
                                    ],
                                  ),
                              ],
                            )
                          : const Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  'Ya ha seleccionado su área de interés',
                                  style: TextStyle(
                                      color: AppTema.balticSea,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            );
                    }
                  }))),
    );
  }
}
