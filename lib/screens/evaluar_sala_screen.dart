import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innova_ito/models/criterioRubrica.dart';

import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/widgets/widgets.dart';

import 'package:http/http.dart' as http;

class EvaluarSalaScreen extends ConsumerWidget {
  static const String name = 'EvaluarSalaScreen';
  EvaluarSalaScreen({super.key});

  List<CriterioRubrica> rubrica = [];

  Future<void> getRubrica(String medio) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/get_criterioRubrica.php?Medio_evaluacion=$medio';
    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        rubrica = criterioRubricaFromJson(response.body);
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
          tituloPantalla: 'Evaluaciones Stand',
          fontSize: 20,
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Mis proyectos',
                  style: TextStyle(
                      color: AppTema.balticSea,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                  future: getRubrica('STAND'),
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
                          itemCount: rubrica.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(16),
                              margin: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(rubrica[index].descripcion),
                                  Text(
                                      'Nombre criterio: ${rubrica[index].nombreCriterio}'),
                                  Text(
                                      'Puntaje: ${rubrica[index].valorMin} - ${rubrica[index].valorMax}'),
                                  SizedBox(height: 8),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      // final newValues = List.from(valoresIngresados.state);
                                      // newValues[index] = ValorIngresado(int.parse(value));
                                      // ref.read(valoresIngresadosProvider).state = newValues;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Ingrese el valor',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      // final newValues = List.from(valoresIngresados.state);
                                      // newValues[index] = ValorIngresado(int.parse(value));
                                      // ref.read(valoresIngresadosProvider).state = newValues;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Ingrese el valor',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      // final newValues = List.from(valoresIngresados.state);
                                      // newValues[index] = ValorIngresado(int.parse(value));
                                      // ref.read(valoresIngresadosProvider).state = newValues;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Ingrese el valor',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ],
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
