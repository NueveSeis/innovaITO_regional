import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/helpers/helpers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/services.dart';
//import 'package:flutter_quill/flutter_quill.dart';

class FichaTecnicaScreen extends StatelessWidget {
  static const String name = 'ficha_tecnica';
  FichaTecnicaScreen({super.key});
  bool cargando = false;
  bool cargando2 = false;
  List<Area> areas = [];
  List<Categoria> categorias = [];
  List<Naturaleza> naturalezas = [];
  String simon = '';
  bool seleccionado = false;

  Future obtenerAreas(String areaB) async {
    var url =
        'https://evarafael.com/Aplicacion/rest/get_area.php?Id_categoria=$areaB';
    var response = await http.get(Uri.parse(url));
    areas = areaFromJson(response.body);
    cargando = true;
  }

  Future obtenerCategorias() async {
    //final bool catProv = ref.watch(categoriaCargandoProvider);
    var url = 'https://evarafael.com/Aplicacion/rest/get_categorias.php';
    var response = await http.get(Uri.parse(url));
    categorias = categoriaFromJson(response.body);
  }

  Future obtenerNaturaleza() async {
    var url = 'https://evarafael.com/Aplicacion/rest/get_naturalezas.php';
    var response = await http.get(Uri.parse(url));
    naturalezas = naturalezaFromJson(response.body);
  }

  @override
  Widget build(BuildContext context) {
    //final bool catProv = ref.watch(categoriaCargandoProvider);

    return Scaffold(
      body: Fondo(
        tituloPantalla: 'Ficha tecnica',
        fontSize: 25,
        widget: Column(children: [
          const SizedBox(height: 50),
          const Text(
            'Datos del proyecto',
            style: TextStyle(
                color: AppTema.balticSea,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Form(
                child: Column(
              children: [
                const SizedBox(height: 20),
                FutureBuilder(
                    future: obtenerCategorias(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Consumer(builder: (context, ref, child) {
                          final bool areaProvLoad =
                              ref.watch(categoriaCargandoProvider);
                          final String areaProvSelec =
                              ref.watch(categoriaSelecProvider);
                          return cateSeleccion(ref);
                        });
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),

                Consumer(builder: (context, ref, child) {
                  final bool areaProvLoad =
                      ref.watch(categoriaCargandoProvider);
                  final String areaProvSelec =
                      ref.watch(categoriaSelecProvider);
                  return (areaProvLoad)
                      ? FutureBuilder(
                          future: obtenerAreas(areaProvSelec),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return areaDrop(areas);
                            } else {
                              return CircularProgressIndicator();
                            }
                          })
                      : SizedBox();
                }),

                FutureBuilder(
                  future: obtenerNaturaleza(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return naturalezaDrop(naturalezas);
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),

                const SizedBox(height: 20),
                TextFormField(
                  // inputFormatters: [
                  //   LengthLimitingTextInputFormatter(10),
                  // ],
                  maxLength: 30,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese nombre corto (nombre comercial)',
                    labelText: 'Nombre corto (nombre comercial)',
                  ),
                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  maxLength: 100,
                  maxLines: null,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese nombre descriptivo',
                    labelText: 'Nombre descriptivo',
                  ),
                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  //initialValue: 'Hola perros',
                  // minLines: 3,
                  maxLength: 500,
                  maxLines: null,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText:
                        'Plantear el objetivo general respondiendo a: ¿Qué?, ¿Cómo?, ¿Para qué?, ¿Qué soluciona?',
                    labelText: 'Objetivo del proyecto',
                  ),
                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  maxLength: 600,
                  maxLines: null,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText:
                        'Explicar qué necesidad, problemática u oportunidad del entorno se atiende, justificar por qué se quiere desarrollar este proyecto.',
                    labelText: 'Problemática identificada',
                    //prefixIcon: Icons.person
                  ),
                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  maxLength: 600,
                  maxLines: null,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText:
                        'Describir los beneficios cualitativos y cuantitativos de la propuesta.',
                    labelText: 'Resultados esperados del proyecto',
                    //prefixIcon: Icons.person
                  ),
                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
//                 SizedBox(height: 20),

                Container(
                  height: 50,
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: ElevatedButton(
                    child: const Center(
                        child: Text(
                      'Registrar',
                      style: TextStyle(color: AppTema.grey100, fontSize: 25),
                    )),
                    onPressed: () {
                      print(simon);
                      print(seleccionado);

                      String name = 'InnovaIto';
                      String uniqueID = Generar.idProyecto(name);
                      print('Unique ID: $uniqueID');
                      //context.pushNamed('registro_usuario_lider');
                      //Navigator.pushNamed(context, 'registro_usuario_lider');
                    },
                  ),
                ),
              ],
            )),
          ),
        ]),
      ),
    );
  }

  Column cateSeleccion(WidgetRef ref) {
    return Column(
      children: [
        Container(
          // padding: EdgeInsets.only(right: 2.0),
          alignment: Alignment.topLeft,
          child: const Text(
            'Seleccione categoria:',
            style: TextStyle(
                color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField(
          isExpanded: true,
          //value: 'Licenciatura',
          style: const TextStyle(
              color: AppTema.bluegrey700, fontWeight: FontWeight.bold),

          items: categorias.map((itemone) {
            return DropdownMenuItem(
              alignment: Alignment.centerLeft,
              value: itemone,
              child: Text(
                itemone.nombreCategoria,
                overflow: TextOverflow.visible,
              ),
            );
          }).toList(),
          onChanged: (value) {
            seleccionado = true;
            simon = value!.nombreCategoria;

            ref.read(categoriaCargandoProvider.notifier).state = true;
            ref.read(categoriaSelecProvider.notifier).update(
                  (state) => value.idCategoria,
                );
            // setState(() {
            //   cargando3 = false;
            // });
            // obtenerDepartamento();
          },
        ),
      ],
    );
  }

  Column areaDrop(List<Area> tipo) {
    return Column(
      children: [
        Container(
          // padding: EdgeInsets.only(right: 2.0),
          alignment: Alignment.topLeft,
          child: const Text(
            'Seleccione área de aplicación:',
            style: TextStyle(
                color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField(
          isExpanded: true,
          style: const TextStyle(
              color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
          items: tipo.map((itemone) {
            return DropdownMenuItem(
              alignment: Alignment.centerLeft,
              value: itemone,
              child: Text(
                itemone.nombreArea,
                overflow: TextOverflow.visible,
              ),
            );
          }).toList(),
          onChanged: (value) {
            // valueTipo = value!.idArea;
            // setState(() {
            //   cargando2 = false;
            //   cargando3 = false;
            // });
            // obtenerTecnologico();
          },
        ),
      ],
    );
  }

  Column naturalezaDrop(List<Naturaleza> tipo) {
    return Column(
      children: [
        Container(
          // padding: EdgeInsets.only(right: 2.0),
          alignment: Alignment.topLeft,
          child: const Text(
            'Seleccione naturaleza técnica:',
            style: TextStyle(
                color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField(
          isExpanded: true,
          style: const TextStyle(
              color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
          items: tipo.map((itemone) {
            return DropdownMenuItem(
              alignment: Alignment.centerLeft,
              value: itemone,
              child: Text(
                itemone.tipo,
                overflow: TextOverflow.visible,
              ),
            );
          }).toList(),
          onChanged: (value) {},
        ),
      ],
    );
  }
}
