import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String areaProv = ref.watch(areaProvider);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Area de interes',
          fontSize: 20,
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Seleccione la categoria de interes',
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
                          width: double.infinity,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200.0,
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0,
                              childAspectRatio: .75,
                            ),
                            itemCount: categorias.length,
                            itemBuilder: (BuildContext context, index) {
                              return MaterialButton(
                                  splashColor: AppTema.pizazz,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: size.height * 0.4,
                                  elevation: 5.0,
                                  color: AppTema.grey100,
                                  child: Text(
                                    categorias[index].nombreCategoria,
                                    style: const TextStyle(
                                        color: AppTema.bluegrey700,
                                        fontSize: 20),
                                  ),
                                  onPressed: () {
                                    ref.read(areaProvider.notifier).state =
                                        categorias[index].idCategoria;
                                    isSelectCategoria = true;
                                    categoriaSelec = categorias[index]
                                        .nombreCategoria
                                        .toLowerCase();
                                    // ref.read(areaProvider.notifier).update(
                                    //       (state) =>
                                    //           categorias[index].idCategoria,
                                    //     );
                                  });
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
                                    'Seleccione su area de interes',
                                    style: TextStyle(
                                        color: AppTema.balticSea,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: size.height * 0.4,
                                    width: double.infinity,
                                    child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200.0,
                                        mainAxisSpacing: 10.0,
                                        crossAxisSpacing: 10.0,
                                        childAspectRatio: 0.5,
                                      ),
                                      itemCount: areas.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return MaterialButton(
                                            splashColor: AppTema.pizazz,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            height: 35,
                                            elevation: 5.0,
                                            color: AppTema.grey100,
                                            child: Text(
                                              areas[index].nombreArea,
                                              style: const TextStyle(
                                                  color: AppTema.bluegrey700,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () {
                                              areaSelec = areas[index]
                                                  .nombreArea
                                                  .toLowerCase();
                                              // print(areas[index].nombreArea);
                                            });
                                      },
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
                            )),
                            onPressed: () async {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.confirm,
                                text:
                                    'Categoria: $categoriaSelec \nArea: $areaSelec',
                                title: '¿ Esta seguro ?',
                                confirmBtnText: 'Si',
                                cancelBtnText: 'No',
                                confirmBtnColor: Colors.green,
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
