import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/helpers/helpers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AgregarRubricaScreen extends ConsumerWidget {
  static const String name = 'agregar_rubrica';
  AgregarRubricaScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController cNombre = TextEditingController();
  TextEditingController cApellidoP = TextEditingController();
  TextEditingController cApellidoM = TextEditingController();
  TextEditingController cMatricula = TextEditingController();
  TextEditingController cPromedio = TextEditingController();
  TextEditingController cCurp = TextEditingController();
  TextEditingController cIne = TextEditingController();
  TextEditingController cCorreo = TextEditingController();
  TextEditingController cNumero = TextEditingController();
  bool _sliderStand = false;

  List numCriterios = [3, 3, 4];

  List<Genero> genero = [];

  Future<void> getGenero(WidgetRef ref) async {
    String url = 'https://evarafael.com/Aplicacion/rest/get_genero.php';
    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        genero = generoFromJson(response.body);
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
            tituloPantalla: 'Registro rubricas',
            fontSize: 20,
            widget: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Ingrese datos de la rubrica',
                  style: TextStyle(
                      color: AppTema.balticSea,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Form(
                      //autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          const SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: cNombre,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese nombre de la rubrica',
                              labelText: 'Nombre de la rubrica',
                            ),
                            //onChanged: (value) => registroLider.nombre = value,
                            validator: (value) {
                              return RegexUtil.nombres.hasMatch(value ?? '')
                                  ? null
                                  : 'Nombre no valido.';
                            },
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Seleccione el tipo de rubrica:',
                            style: TextStyle(
                                color: AppTema.balticSea,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          SwitchListTile.adaptive(
                              title: const Text('Rubrica Stand  (Valor: 60%)'),
                              activeColor: AppTema.pizazz,
                              value: _sliderStand,
                              onChanged: (value) {
                                _sliderStand = value ?? true;
                              }),
                          const SizedBox(height: 10),
                          SwitchListTile.adaptive(
                              title: const Text('Rubrica Sala  (Valor: 40%)'),
                              activeColor: AppTema.pizazz,
                              value: _sliderStand,
                              onChanged: (value) {
                                _sliderStand = value ?? true;
                              }),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: cApellidoP,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Numero de criterios',
                              labelText: 'Numero de criterios',
                            ),
                          ),
                          const SizedBox(height: 20),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: numCriterios.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  const SizedBox(height: 50),
                                  TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: cNombre,
                                    style: const TextStyle(
                                        color: AppTema.bluegrey700,
                                        fontWeight: FontWeight.bold),
                                    autocorrect: false,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecorations
                                        .registroLiderDecoration(
                                      hintText: 'Ingrese nombre del criterio',
                                      labelText: 'Nombre del criterio',
                                    ),
                                    //onChanged: (value) => registroLider.nombre = value,
                                    validator: (value) {
                                      return RegexUtil.nombres
                                              .hasMatch(value ?? '')
                                          ? null
                                          : 'Nombre no valido.';
                                    },
                                  ),
                                  const SizedBox(height: 30),
                                  TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: cNombre,
                                    style: const TextStyle(
                                        color: AppTema.bluegrey700,
                                        fontWeight: FontWeight.bold),
                                    autocorrect: false,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecorations
                                        .registroLiderDecoration(
                                      hintText:
                                          'Ingrese el valor de porcentaje del criterio',
                                      labelText: 'Porcentaje del criterio',
                                    ),
                                    //onChanged: (value) => registroLider.nombre = value,
                                    validator: (value) {
                                      return RegexUtil.nombres
                                              .hasMatch(value ?? '')
                                          ? null
                                          : 'Nombre no valido.';
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 50,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: ElevatedButton(
                              child: const Center(
                                  //height: 50,
                                  child: Text(
                                'Registrar rubrica',
                                style: TextStyle(
                                    color: AppTema.grey100, fontSize: 25),
                              )),
                              onPressed: () async {
                                ref.read(camposLlenosProv.notifier).update(
                                    (state) =>
                                        _formKey.currentState!.validate());
                              },
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            )));
  }
}
