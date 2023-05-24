import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/theme/app_tema.dart';

import 'package:innova_ito/widgets/widgets.dart';

class SeleccionCategoriaScreen extends StatefulWidget {
  static const String name = 'seleccionar_categoria';
  const SeleccionCategoriaScreen({super.key});

  @override
  State<SeleccionCategoriaScreen> createState() =>
      _SeleccionCategoriaScreenState();
}

class _SeleccionCategoriaScreenState extends State<SeleccionCategoriaScreen> {
  bool isSelected_1 = false;
  bool isSelectCategoria = false;

  String categoriaSelec = '';

  List<Area> areas = [];
  List<Categoria> categorias = [];

  Future obtenerAreas(String areaB) async {
    var url =
        'https://evarafael.com/Aplicacion/rest/get_area.php?Id_categoria=$areaB';
    var response = await http.get(Uri.parse(url));
    areas = areaFromJson(response.body);
    // print("simon ${areas.length}");
  }

  Future obtenerCategorias() async {
    var url = 'https://evarafael.com/Aplicacion/rest/get_categorias.php';
    var response = await http.get(Uri.parse(url));
    categorias = categoriaFromJson(response.body);
    // print("simon
    isSelectCategoria = true;
  }

  @override
  Widget build(BuildContext context) {
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
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    //maxCrossAxisExtent: 200,
                                    childAspectRatio: 3 / 6,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
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
                                    style: TextStyle(
                                        color: AppTema.bluegrey700,
                                        fontSize: 20),
                                  ),
                                  onPressed: () {
//isSelectCategoria = true;
                                    categoriaSelec =
                                        categorias[index].idCategoria;
                                    print(categoriaSelec);
                                    //setState(() {
                                    //categoriaSelec =
                                    //  categorias[index].idCategoria;
                                    //});
                                    isSelectCategoria = true;

                                    obtenerAreas(categoriaSelec);
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
                  SelecionarArea(size: size, areas: areas),
                Container(
                  height: 50,
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: ElevatedButton(
                      child: const Center(
                          child: Text(
                        'Enviar',
                        style: TextStyle(color: AppTema.grey100, fontSize: 25),
                      )),
                      onPressed: () async {}),
                ),
              ],
            ),
          )),
    );
  }
}

class SelecionarArea extends StatelessWidget {
  const SelecionarArea({
    super.key,
    required this.size,
    required this.areas,
  });

  final Size size;
  final List<Area> areas;

  @override
  Widget build(BuildContext context) {
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
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                childAspectRatio: 10 / 3),
            itemCount: areas.length,
            itemBuilder: (BuildContext context, index) {
              return MaterialButton(
                  splashColor: AppTema.pizazz,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 35,
                  elevation: 5.0,
                  color: AppTema.grey100,
                  child: Text(
                    areas[index].nombreArea,
                    style: TextStyle(color: AppTema.bluegrey700, fontSize: 20),
                  ),
                  onPressed: () {});
            },
          ),
        ),
      ],
    );
  }
}
