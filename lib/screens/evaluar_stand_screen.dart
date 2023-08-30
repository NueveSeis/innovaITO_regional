import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/models/criterioRubrica.dart';
import 'package:innova_ito/providers/providers.dart';

import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/widgets/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:uuid/uuid.dart';

class EvaluarStandScreen extends ConsumerWidget {
  static const String name = 'EvaluarStandScreen';
  EvaluarStandScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<CriterioRubrica> rubrica = [];

  Future<void> getRubrica(String medio) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/get_criterioRubrica.php?Medio_evaluacion=$medio';
    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        rubrica = criterioRubricaFromJson(response.body);
      } else {
        //print('La solicitud no fue exitosa: ${response.statusCode}');
      }
    } catch (error) {
      //  print('Error al realizar la solicitud: $error');
    }
  }

  Future<bool> agregarCalificacion(String idCal, String puntaje, String folio,
      String idCrit, String idJur, String obs, String rec) async {
    var url =
        'https://evarafael.com/Aplicacion/rest/agregarCalificacionJurado.php'; // Reemplaza con la URL del archivo PHP en tu servidor
    var response = await http.post(Uri.parse(url), body: {
      'Id_calificacion': 'CAL$idCal',
      'Puntaje': puntaje,
      'Folio': folio,
      'Id_criterio': idCrit,
      'Id_jurado': idJur,
      'Observaciones': obs,
      'Recomendaciones': rec
    });
    if (response.statusCode == 200) {
      //print('Modificado en la db');
      return true;
    } else {
      //print('No modificado');
      return false;
    }
  }

  Future<bool> updateEvaluacionStand(
      String foliop, String idjur, String eva) async {
    var url =
        'https://evarafael.com/Aplicacion/rest/update_evaluacionStand.php'; // Reemplaza con la URL del archivo PHP en tu servidor
    var response = await http.post(Uri.parse(url),
        body: {'Folio': foliop, 'Id_jurado': idjur, 'Estado_evaluacion': eva});
    if (response.statusCode == 200) {
      //print('Modificado en la db');
      return true;
    } else {
      //print('No modificado');
      return false;
    }
  }

  final List<List<TextEditingController>> _controllersListCriterios = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datosProyectoPESSTvar = ref.watch(proyectoDatosPESST);
    final String juradoID = ref.watch(juradoIDProvider);
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
                  'Criterios de la rúbrica',
                  style: TextStyle(
                      color: AppTema.balticSea,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: FutureBuilder(
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
                              child:
                                  Text('Error: ${snapshot.error.toString()}'));
                        } else {
                          _controllersListCriterios.clear();
                          for (int i = 0; i < rubrica.length; i++) {
                            _controllersListCriterios.add([
                              TextEditingController(),
                              TextEditingController(),
                              TextEditingController(),
                            ]);
                          }
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: rubrica.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(16),
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(rubrica[index].descripcion),
                                    Text(
                                        'Criterio: ${rubrica[index].nombreCriterio}'),
                                    Text('Puntaje'),
                                    Text(
                                        'mínimo: ${rubrica[index].valorMin}     máximo: ${rubrica[index].valorMax}'),
                                    SizedBox(height: 8),
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      maxLength: 2,
                                      controller:
                                          _controllersListCriterios[index][0],
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d{0,2}$')),
                                      ],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Ingrese una calificación';
                                        }

                                        int? intValue = int.tryParse(
                                            value); // Usa int? en lugar de int
                                        if (intValue == null) {
                                          return 'Ingrese un número válido';
                                        }

                                        if (intValue <
                                                int.parse(
                                                    rubrica[index].valorMin) ||
                                            intValue >
                                                int.parse(
                                                    rubrica[index].valorMax)) {
                                          return 'La calificación debe estar entre ${rubrica[index].valorMin} y ${rubrica[index].valorMax}';
                                        }

                                        return null; // La validación pasó
                                      },
                                      decoration: const InputDecoration(
                                        labelText:
                                            'Ingrese calificación para el criterio',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      //maxLength: 2,
                                      controller:
                                          _controllersListCriterios[index][1],
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {
                                        // final newValues = List.from(valoresIngresados.state);
                                        // newValues[index] = ValorIngresado(int.parse(value));
                                        // ref.read(valoresIngresadosProvider).state = newValues;
                                      },
                                      decoration: const InputDecoration(
                                        labelText:
                                            'Ingrese observaciones si existe',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller:
                                          _controllersListCriterios[index][2],
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {
                                        // final newValues = List.from(valoresIngresados.state);
                                        // newValues[index] = ValorIngresado(int.parse(value));
                                        // ref.read(valoresIngresadosProvider).state = newValues;
                                      },
                                      decoration: const InputDecoration(
                                        labelText:
                                            'Ingrese recomendaciones si existe',
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
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    child: const Center(
                        //height: 50,
                        child: Text(
                      'Registrar rúbrica',
                      style: TextStyle(color: AppTema.grey100, fontSize: 25),
                    )),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        for (int index = 0;
                            index < _controllersListCriterios.length;
                            index++) {
                          // print('Valores para el índice $index:');
                          // print(
                          //     'Primer TextEditingController: ${_controllersListCriterios[index][0].text}');
                          // print(
                          //     'Segundo TextEditingController: ${_controllersListCriterios[index][1].text}');
                          // print(
                          //     'Tercer TextEditingController: ${_controllersListCriterios[index][2].text}');
                          // print('---');
                          // Separador entre conjuntos de TextEditingController
                          String id = const Uuid().v4().substring(0, 8);
                          agregarCalificacion(
                              id,
                              _controllersListCriterios[index][0].text,
                              datosProyectoPESSTvar.first.folio,
                              rubrica[index].idCriterio,
                              juradoID,
                              _controllersListCriterios[index][1].text,
                              _controllersListCriterios[index][2].text);
                        }
                        bool upEvaSt = await updateEvaluacionStand(
                            datosProyectoPESSTvar.first.folio, juradoID, '1');
                        if (upEvaSt == true) {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            title: 'Calificado correctamente',
                            confirmBtnText: 'Hecho',
                            confirmBtnColor: AppTema.pizazz,
                            onConfirmBtnTap: () {
                              context.pushReplacementNamed(
                                  'ProyectoEvaluarStandSreen');
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
                              context.pop();
                            },
                          );
                        }
                      } else {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.warning,
                          title: 'Campos incompletos',
                          confirmBtnText: 'Hecho',
                          confirmBtnColor: AppTema.pizazz,
                          onConfirmBtnTap: () {
                            context.pop();
                          },
                        );
                      }
                    }),
              ],
            ),
          )),
    );
  }
}
