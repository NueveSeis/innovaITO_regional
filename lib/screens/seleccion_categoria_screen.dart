import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html_editor_enhanced/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:quickalert/quickalert.dart';

class SeleccionCategoriaScreen extends ConsumerWidget {
  static const String name = 'seleccionar_categoria';

  SeleccionCategoriaScreen({super.key});

  bool isSelectCategoria = false;
  String categoriaSelec = '';
  String areaSelec = '';
  List<Area> areas = [];
  List<Categoria> categorias = [];

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

  Future<void> sendData(
      BuildContext context, String categoria, String area) async {
    var url = 'https://evarafael.com/Aplicacion/rest/set_preferencias';

    var data = {
      'categoria': categoria,
      'area': area,
    };

    try {
      // Hacemos el POST
      var response = await http.post(
        Uri.parse(url),
        body: data,
      );

      // TODO: Revisar y remplazar los mensajes en los QuickAlerts.
      if (context.mounted) {
        // Si la información se envió correctamente, le decimos al usuario que
        if (response.statusCode == 200) {
          createQuickAlert(context, true, 'Datos guardado con éxito', '');
        } else {
          // Si no se pudo enviar la información, le mostramos al usuario un mensaje de error
          createQuickAlert(
              context, false, 'ERROR', 'Lo sentimos, algo salió mal.');
        }
      }
    } catch (error) {
      // Capturamos el error que se esté presentando
      createQuickAlert(context, false, 'ERROR', 'Lo sentimos, algo salió mal.');
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
    final String areaProv = ref.watch(areaProvider);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Área de interés',
          fontSize: 20,
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
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
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: MaterialButton(
                                    splashColor: AppTema.pizazz,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    height: size.height * 0.4,
                                    elevation: 5.0,
                                    //color: AppTema.grey100,
                                    color: setBackgroundColor(categoriaSelec,
                                        categorias[index].nombreCategoria),
                                    child: Text(
                                      categorias[index].nombreCategoria,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          //color: AppTema.bluegrey700,
                                          color: setTextColor(
                                              categoriaSelec,
                                              categorias[index]
                                                  .nombreCategoria),
                                          fontSize: 20),
                                    ),
                                    onPressed: () {
                                      ref.read(areaProvider.notifier).state =
                                          categorias[index].idCategoria;
                                      isSelectCategoria = true;
                                      categoriaSelec =
                                          categorias[index].nombreCategoria;
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
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return Column(
                                children: [
                                  const Text(
                                    'Seleccione su área de interes',
                                    style: TextStyle(
                                        color: AppTema.balticSea,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: SizedBox(
                                      height: size.height * 0.4,
                                      width: double.infinity,
                                      child: GridView.builder(
                                        scrollDirection: Axis.horizontal,
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 150.0,
                                          mainAxisSpacing: 10.0,
                                          //crossAxisSpacing: 10.0,
                                          childAspectRatio: 0.5,
                                        ),
                                        itemCount: areas.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: MaterialButton(
                                                splashColor: AppTema.pizazz,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                height: 35,
                                                elevation: 5.0,
                                                //color: AppTema.grey100,
                                                color: setBackgroundColor(
                                                    areaSelec,
                                                    areas[index].nombreArea),
                                                child: Text(
                                                  areas[index].nombreArea,
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.fade,
                                                  style: TextStyle(
                                                      //color:AppTema.bluegrey700,
                                                      color: setTextColor(
                                                          areaSelec,
                                                          areas[index]
                                                              .nombreArea),
                                                      fontSize: 20),
                                                ),
                                                onPressed: () {
                                                  ref
                                                          .read(areaProvider
                                                              .notifier)
                                                          .state =
                                                      areas[index].idCategoria;
                                                  areaSelec =
                                                      areas[index].nombreArea;
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
                                    color: AppTema.grey100, fontSize: 25),
                              ),
                            ),
                            onPressed: () async {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.info,
                                title: '¿Estás seguro?',
                                text:
                                    'Categoría: $categoriaSelec \nÁrea: $areaSelec',
                                confirmBtnText: 'Sí',
                                cancelBtnText: 'No',
                                confirmBtnColor: Colors.green,
                                onConfirmBtnTap: () {
                                  print("Confirmado");
                                  sendData(context, categoriaSelec, areaSelec);
                                  Navigator.pop(context);
                                },
                              );
                            }),
                      ),
                    ],
                  ),
              ],
            ),
          )),
    );
  }
}
