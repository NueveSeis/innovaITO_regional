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
import 'package:uuid/uuid.dart';

class AgregarRubricaScreen extends ConsumerWidget {
  static const String name = 'agregar_rubrica';
  AgregarRubricaScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController cNombreRubrica = TextEditingController();
  TextEditingController cNumeroCriterios = TextEditingController();

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

  Future<bool> agregarRubrica(
      String id, String descripcion, String medio, String porcentaje) async {
    var url =
        'https://evarafael.com/Aplicacion/rest/agregar_rubrica.php'; // Reemplaza con la URL del archivo PHP en tu servidor
    var response = await http.post(Uri.parse(url), body: {
      'Id_rubrica': 'RUB$id',
      'Descripcion': descripcion,
      'Medio_evaluacion': medio,
      'Porcentaje_rubrica': porcentaje
    });
    if (response.statusCode == 200) {
      print('Modificado en la db');
      return true;
    } else {
      print('No modificado');
      return false;
    }
  }

  final criteriosProvider = StateProvider<int>((ref) => 1);
  final List<List<TextEditingController>> _controllersList = [];

  final switchStandProvider = StateProvider<bool>((ref) => false);
  final switchSalaProvider = StateProvider<bool>((ref) => false);
  final camposLLenosProvider = StateProvider<bool>((ref) => false);
  //bool camposLlenos = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final criterios = ref.watch(criteriosProvider);
    final isActiveStand = ref.watch(switchStandProvider);
    final isActiveSala = ref.watch(switchSalaProvider);
    final camposLLenosRubrica = ref.watch(camposLLenosProvider);

    _controllersList.clear();
    for (int i = 0; i < criterios; i++) {
      _controllersList.add([
        TextEditingController(),
        TextEditingController(),
      ]);
    }
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
                            controller: cNombreRubrica,
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
                              value: isActiveStand,
                              onChanged: (value) {
                                ref
                                    .read(switchStandProvider.notifier)
                                    .update((state) => value);
                                ref
                                    .read(switchSalaProvider.notifier)
                                    .update((state) => !value);
                              }),
                          const SizedBox(height: 10),
                          SwitchListTile.adaptive(
                              title: const Text('Rubrica Sala  (Valor: 40%)'),
                              activeColor: AppTema.pizazz,
                              value: isActiveSala,
                              onChanged: (value) {
                                ref
                                    .read(switchStandProvider.notifier)
                                    .update((state) => !value);
                                ref
                                    .read(switchSalaProvider.notifier)
                                    .update((state) => value);
                              }),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: cNumeroCriterios,
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
                            onChanged: (value) {
                              ref
                                  .read(criteriosProvider.notifier)
                                  .update((state) => int.tryParse(value) ?? 1);
                            },
                            validator: (value) {
                              return RegexUtil.criterios.hasMatch(value ?? '')
                                  ? null
                                  : 'Numero no valido, puede crear hasta 100 criterios.';
                            },
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'La suma total de los porcentajes de los criterios debe ser igual a 100.',
                            style: TextStyle(
                                color: AppTema.balticSea,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          const SizedBox(height: 20),
                          Column(
                            children: List.generate(
                              criterios,
                              (index) => Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Criterio ${index + 1}',
                                    style: const TextStyle(
                                        color: AppTema.balticSea,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  TextFormField(
                                    style: const TextStyle(
                                        color: AppTema.bluegrey700,
                                        fontWeight: FontWeight.bold),
                                    autocorrect: false,
                                    keyboardType: TextInputType.text,
                                    controller: _controllersList[index][0],
                                    decoration: InputDecorations
                                        .registroLiderDecoration(
                                      hintText:
                                          'Ingrese descripcion del criterio',
                                      labelText: 'Descripcion del criterio',
                                    ),
                                    validator: (value) {
                                      return RegexUtil.nombres
                                              .hasMatch(value ?? '')
                                          ? null
                                          : 'Descripcion no valida.';
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: _controllersList[index][1],
                                    style: const TextStyle(
                                        color: AppTema.bluegrey700,
                                        fontWeight: FontWeight.bold),
                                    autocorrect: false,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecorations
                                        .registroLiderDecoration(
                                      hintText:
                                          'Ingrese porcentaje (%) del criterio',
                                      labelText: 'Porcentaje (%) del criterio',
                                    ),
                                    validator: (value) {
                                      return RegexUtil.criterios
                                              .hasMatch(value ?? '')
                                          ? null
                                          : 'Numero no valido.';
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
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
                                  ref
                                      .read(camposLLenosProvider.notifier)
                                      .update((state) =>
                                          _formKey.currentState!.validate());

                                  print(camposLLenosRubrica);
                                  String id = Uuid().v4().substring(0, 8);
                                  int valorRubrica = 0;
                                  if (camposLLenosRubrica) {
                                    if (isActiveSala || isActiveStand) {
                                      print('Switch 1: $isActiveSala');
                                      print('Switch 2: $isActiveStand');
                                      final values =
                                          ref.read(criteriosProvider);

                                      //suma de valores
                                      int sum = 0;
                                      for (int i = 0; i < values; i++) {
                                        final text2 =
                                            _controllersList[i][1].text;
                                        sum += int.tryParse(text2) ?? 0;
                                      }
                                      if (sum == 100) {
                                        print('Felicidades');

                                        //*Crear rubrica89
                                        bool rubricaAdd = await agregarRubrica(
                                            id,
                                            cNombreRubrica.text,
                                            (isActiveSala) ? 'SALA' : 'STAND',
                                            (isActiveSala) ? '40' : '60');

                                        if (rubricaAdd) {
                                          for (int i = 0; i < values; i++) {
                                            final text1 =
                                                _controllersList[i][0].text;
                                            final text2 =
                                                _controllersList[i][1].text;
                                            final intValue =
                                                int.tryParse(text2) ?? 0;

                                            int minVal = 0;
                                            int maxVal = intValue;

                                            print('Nombre de la rubrica:' +
                                                cNombreRubrica.text);
                                            print('Valor de la rubrica:' +
                                                valorRubrica.toString());

                                            print('Numero de criterios: ' +
                                                values.toString());
                                            print(
                                                'Campo $i - 2: Mínimo: $minVal, Máximo: $maxVal');
                                            print('Campo $i - 1: $text1');
                                            print('Campo $i - 2: $text2');
                                            print('Id: RUB' + id);
                                          }
                                        } else {}
                                      } else {
                                        print('checar valores');
                                      }
                                    } else {
                                      print('Ningún interruptor está activado');
                                    }
                                  }

//imprimir maximos y minimos de una campo
                                }),
                          ),
                        ],
                      )),
                ),
              ],
            )));
  }
}

List<TextEditingController> _controllers = [];

TextEditingController textControllerProvider(int index, int fieldIndex) {
  while (_controllers.length <= index) {
    _controllers.add(TextEditingController());
  }
  return _controllers[index];
}
