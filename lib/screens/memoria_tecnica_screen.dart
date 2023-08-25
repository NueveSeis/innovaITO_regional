import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/providers/providers.dart';

import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;

import 'package:innova_ito/helpers/helpers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

class MemoriaTecnicaScreen extends StatefulWidget {
  static const String name = 'memoria_tecnica';
  const MemoriaTecnicaScreen({super.key});

  @override
  State<MemoriaTecnicaScreen> createState() => _MemoriaTecnicaScreenState();
}

class _MemoriaTecnicaScreenState extends State<MemoriaTecnicaScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool camposLlenos = true;
  TextEditingController cProblematica = TextEditingController();
  TextEditingController cEstadoArte = TextEditingController();
  TextEditingController cInnovacion = TextEditingController();
  TextEditingController cPropuestaValor = TextEditingController();
  TextEditingController cMercadoP = TextEditingController();
  TextEditingController cViabilidadT = TextEditingController();
  TextEditingController cViabilidadF = TextEditingController();
  TextEditingController cPropiedadI = TextEditingController();
  TextEditingController cInterpretacionR = TextEditingController();
  TextEditingController cFuentesC = TextEditingController();

  Future<bool> agregarMemoriaTecnica(String id, String folioPro) async {
    var url = 'https://evarafael.com/Aplicacion/rest/agregarMemoriaTecnica.php';
    try {
      var response = await http.post(Uri.parse(url), body: {
        'Id_memoriaTecnica': id,
        'Descripcion_problematica': cProblematica.text,
        'Estado_arte': cEstadoArte.text,
        'Descripcion_innovacion': cInnovacion.text,
        'Propuesta_valor': cPropuestaValor.text,
        'Mercado_potencial': cMercadoP.text,
        'Viabilidad_tecnica': cViabilidadT.text,
        'Viabilidad_financiera': cViabilidadF.text,
        'Estrategia_propiedadIntelectual': cPropiedadI.text,
        'Interpretacion_resultados': cInterpretacionR.text,
        'Fuentes_consultadas': cFuentesC.text,
        'Folio': folioPro
      });

      if (response.statusCode == 200) {
        // La solicitud se realizó correctamente
        return true;
      } else {
        // La solicitud falló
        return false;
      }
    } catch (e) {
      // Manejar el error de manera adecuada, por ejemplo, mostrar un mensaje de error al usuario
      print('Error en la solicitud HTTP: $e');
      return false;
    }
  }

  String? memoriaProyecto = null;
  Future<String?> getDatosProyecto(String fol) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/get_proyectoWhere.php?Folio=$fol';
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      var datos = jsonDecode(response.body);
      memoriaProyecto = datos[0]['Id_memoriaTecnica'] as String?;
      print(memoriaProyecto);
      //await Future.delayed(Duration(seconds: 2));
      return memoriaProyecto;
    } else {
      return 'SN';
      print('Error al obtener datos de la API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Memoria técnica',
          fontSize: 25,
          widget: Consumer(builder: (context, ref, child) {
            final folioPROV = ref.watch(folioProyectoUsuarioLogin);
            return FutureBuilder(
              future: getDatosProyecto(folioPROV),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    // return Center(
                    //     child: Text('Error: ${snapshot.error.toString()}'));
                    print('Error: ${snapshot.error.toString()}');
                    return const Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Genere la ficha técnica',
                          style: TextStyle(
                              color: AppTema.bluegrey700,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    );
                  } else {
                    return memoriaProyecto != null
                        ? const Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Text(
                                'Ya haz subido la memoria técnica',
                                style: TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          )
                        : Column(children: [
                            const SizedBox(height: 50),
                            const Text(
                              'Datos la memoria técnica',
                              style: TextStyle(
                                  color: AppTema.balticSea,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: cProblematica,
                                        maxLength: 300,
                                        maxLines: null,
                                        autocorrect: false,
                                        keyboardType: TextInputType.text,
                                        style: const TextStyle(
                                            color: AppTema.bluegrey700,
                                            fontWeight: FontWeight.bold),
                                        decoration: InputDecorations
                                            .registroLiderDecoration(
                                          hintText:
                                              'Ingrese la descripción de la problemática y justificación.',
                                          labelText:
                                              'Problemática y justificación',
                                        ),
                                        validator: (value) {
                                          return (!RegexUtil.datos
                                                  .hasMatch(value ?? ''))
                                              ? null
                                              : 'No contiene ningún dato.';
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: cEstadoArte,
                                        maxLength: 220,
                                        maxLines: null,
                                        style: const TextStyle(
                                            color: AppTema.bluegrey700,
                                            fontWeight: FontWeight.bold),
                                        autocorrect: false,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecorations
                                            .registroLiderDecoration(
                                          hintText:
                                              'Ingrese el estado de la técnica (estado del arte).',
                                          labelText:
                                              'Estado de la técnica (estado del arte)',
                                        ),
                                        validator: (value) {
                                          return (!RegexUtil.datos
                                                  .hasMatch(value ?? ''))
                                              ? null
                                              : 'No contiene ningún dato.';
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: cInnovacion,
                                        maxLength: 220,
                                        maxLines: null,
                                        style: const TextStyle(
                                            color: AppTema.bluegrey700,
                                            fontWeight: FontWeight.bold),
                                        autocorrect: false,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecorations
                                            .registroLiderDecoration(
                                          hintText:
                                              'Ingrese la descripción de la innovación.',
                                          labelText:
                                              'Descripción de la innovación',
                                        ),
                                        validator: (value) {
                                          return (!RegexUtil.datos
                                                  .hasMatch(value ?? ''))
                                              ? null
                                              : 'No contiene ningun dato.';
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: cPropuestaValor,
                                        maxLength: 220,
                                        maxLines: null,
                                        style: const TextStyle(
                                            color: AppTema.bluegrey700,
                                            fontWeight: FontWeight.bold),
                                        autocorrect: false,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecorations
                                            .registroLiderDecoration(
                                          hintText:
                                              'Ingrese propuesta de valor e impacto en el sector estratégico.',
                                          labelText:
                                              'Propuesta de valor e impacto en el sector estratégico',
                                          //prefixIcon: Icons.person
                                        ),
                                        validator: (value) {
                                          return (!RegexUtil.datos
                                                  .hasMatch(value ?? ''))
                                              ? null
                                              : 'No contiene ningún dato.';
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: cMercadoP,
                                        maxLength: 300,
                                        maxLines: null,
                                        style: const TextStyle(
                                            color: AppTema.bluegrey700,
                                            fontWeight: FontWeight.bold),
                                        autocorrect: false,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecorations
                                            .registroLiderDecoration(
                                          hintText:
                                              'Ingrese mercado potencial objetivo.',
                                          labelText:
                                              'Mercado potencial objetivo',
                                        ),
                                        validator: (value) {
                                          return (!RegexUtil.datos
                                                  .hasMatch(value ?? ''))
                                              ? null
                                              : 'No contiene ningún dato.';
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: cViabilidadT,
                                        maxLength: 300,
                                        maxLines: null,
                                        style: const TextStyle(
                                            color: AppTema.bluegrey700,
                                            fontWeight: FontWeight.bold),
                                        autocorrect: false,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecorations
                                            .registroLiderDecoration(
                                          hintText:
                                              'Ingrese viabilidad técnica.',
                                          labelText: 'Viabilidad técnica',
                                        ),
                                        validator: (value) {
                                          return (!RegexUtil.datos
                                                  .hasMatch(value ?? ''))
                                              ? null
                                              : 'No contiene ningún dato.';
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: cViabilidadF,
                                        maxLength: 220,
                                        maxLines: null,
                                        style: const TextStyle(
                                            color: AppTema.bluegrey700,
                                            fontWeight: FontWeight.bold),
                                        autocorrect: false,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecorations
                                            .registroLiderDecoration(
                                          hintText:
                                              'Ingrese viabilidad financiera.',
                                          labelText: 'Viabilidad financiera',
                                        ),
                                        validator: (value) {
                                          return (!RegexUtil.datos
                                                  .hasMatch(value ?? ''))
                                              ? null
                                              : 'No contiene ningún dato.';
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: cPropiedadI,
                                        maxLength: 110,
                                        maxLines: null,
                                        style: const TextStyle(
                                            color: AppTema.bluegrey700,
                                            fontWeight: FontWeight.bold),
                                        autocorrect: false,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecorations
                                            .registroLiderDecoration(
                                          hintText:
                                              'Ingrese estrategia de propiedad intelectual.',
                                          labelText:
                                              'Estrategia de propiedad intelectual',
                                        ),
                                        validator: (value) {
                                          return (!RegexUtil.datos
                                                  .hasMatch(value ?? ''))
                                              ? null
                                              : 'No contiene ningún dato.';
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: cInterpretacionR,
                                        maxLength: 300,
                                        maxLines: null,
                                        style: const TextStyle(
                                            color: AppTema.bluegrey700,
                                            fontWeight: FontWeight.bold),
                                        autocorrect: false,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecorations
                                            .registroLiderDecoration(
                                          hintText:
                                              'Ingrese interpretación de resultados.',
                                          labelText:
                                              'Interpretación de resultados',
                                        ),
                                        validator: (value) {
                                          return (!RegexUtil.datos
                                                  .hasMatch(value ?? ''))
                                              ? null
                                              : 'No contiene ningún dato.';
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: cFuentesC,
                                        maxLength: 110,
                                        maxLines: null,
                                        style: const TextStyle(
                                            color: AppTema.bluegrey700,
                                            fontWeight: FontWeight.bold),
                                        autocorrect: false,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecorations
                                            .registroLiderDecoration(
                                          hintText:
                                              'Ingrese Fuentes consultadas.',
                                          labelText: 'Fuentes consultadas',
                                        ),
                                        validator: (value) {
                                          return (!RegexUtil.datos
                                                  .hasMatch(value ?? ''))
                                              ? null
                                              : 'No contiene ningún dato.';
                                        },
                                      ),
                                      Container(
                                        height: 50,
                                        width: double.infinity,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 10),
                                        child: ElevatedButton(
                                          child: const Center(
                                              child: Text(
                                            'Registrar',
                                            style: TextStyle(
                                                color: AppTema.grey100,
                                                fontSize: 25),
                                          )),
                                          onPressed: () async {
                                            setState(() async {
                                              camposLlenos = _formKey
                                                  .currentState!
                                                  .validate();
                                              if (camposLlenos) {
                                                String idm = const Uuid()
                                                    .v4()
                                                    .substring(0, 8);
                                                bool agregado =
                                                    await agregarMemoriaTecnica(
                                                        'MEM$idm', folioPROV);

                                                if (agregado) {
                                                  QuickAlert.show(
                                                    context: context,
                                                    type:
                                                        QuickAlertType.success,
                                                    title:
                                                        'Asignado correctamente',
                                                    confirmBtnText: 'Hecho',
                                                    confirmBtnColor:
                                                        AppTema.pizazz,
                                                    onConfirmBtnTap: () {
                                                      context
                                                          .pushReplacementNamed(
                                                              'memoria_tecnica');
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

                                                // print(contrasena);
                                              } else {
                                                QuickAlert.show(
                                                  context: context,
                                                  type: QuickAlertType.warning,
                                                  title: 'Cuidado',
                                                  text:
                                                      'Rellena los campos faltantes',
                                                  confirmBtnText: 'Hecho',
                                                  confirmBtnColor:
                                                      AppTema.pizazz,
                                                );
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ]);
                  }
                } else {
                  return const Center(child: Text('¡Algo salió mal!'));
                }
              },
            );
          })),
    );
  }
}
