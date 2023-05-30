import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:innova_ito/helpers/helpers.dart';

import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';

import 'package:flutter/services.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:quickalert/quickalert.dart';

import 'dart:io';

import 'package:pdf/widgets.dart' as pw;

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

  Future agregarMemoriaTecnica() async {
    var url = 'https://evarafael.com/Aplicacion/rest/agregarMemoriaTecnica.php';
    await http.post(Uri.parse(url), body: {
      'Id_memoriaTecnica': cProblematica.text,
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
    });
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Registrado correctamente',
      confirmBtnText: 'Hecho',
      confirmBtnColor: AppTema.pizazz,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Fondo(
        tituloPantalla: 'Memoria tecnica',
        fontSize: 25,
        widget: Column(children: [
          const SizedBox(height: 50),
          const Text(
            'Datos la memoria técnica',
            style: TextStyle(
                color: AppTema.balticSea,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: cProblematica,
                      maxLength: 300,
                      maxLines: null,
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecorations.registroLiderDecoration(
                        hintText:
                            'Ingrese la descripción de la problemática y justificación.',
                        labelText: 'Problemática y justificación',
                      ),
                      validator: (value) {
                        return (!RegexUtil.datos.hasMatch(value ?? ''))
                            ? null
                            : 'No contiene ningun dato.';
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: cEstadoArte,
                      maxLength: 220,
                      maxLines: null,
                      style: const TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold),
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecorations.registroLiderDecoration(
                        hintText:
                            'Ingrese el estado de la técnica (estado del arte).',
                        labelText: 'Estado de la técnica (estado del arte)',
                      ),
                      validator: (value) {
                        return (!RegexUtil.datos.hasMatch(value ?? ''))
                            ? null
                            : 'No contiene ningun dato.';
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: cInnovacion,
                      maxLength: 220,
                      maxLines: null,
                      style: const TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold),
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecorations.registroLiderDecoration(
                        hintText: 'Ingrese la descripción de la innovación.',
                        labelText: 'Descripción de la innovación',
                      ),
                      validator: (value) {
                        return (!RegexUtil.datos.hasMatch(value ?? ''))
                            ? null
                            : 'No contiene ningun dato.';
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: cPropuestaValor,
                      maxLength: 220,
                      maxLines: null,
                      style: const TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold),
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecorations.registroLiderDecoration(
                        hintText:
                            'Ingrese propuesta de valor e impacto en el sector estratégico.',
                        labelText:
                            'Propuesta de valor e impacto en el sector estratégico',
                        //prefixIcon: Icons.person
                      ),
                      validator: (value) {
                        return (!RegexUtil.datos.hasMatch(value ?? ''))
                            ? null
                            : 'No contiene ningun dato.';
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: cMercadoP,
                      maxLength: 300,
                      maxLines: null,
                      style: const TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold),
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecorations.registroLiderDecoration(
                        hintText: 'Ingrese mercado potencial objetivo.',
                        labelText: 'Mercado potencial objetivo',
                      ),
                      validator: (value) {
                        return (!RegexUtil.datos.hasMatch(value ?? ''))
                            ? null
                            : 'No contiene ningun dato.';
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: cViabilidadT,
                      maxLength: 300,
                      maxLines: null,
                      style: const TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold),
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecorations.registroLiderDecoration(
                        hintText: 'Ingrese viabilidad técnica.',
                        labelText: 'Viabilidad técnica',
                      ),
                      validator: (value) {
                        return (!RegexUtil.datos.hasMatch(value ?? ''))
                            ? null
                            : 'No contiene ningun dato.';
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: cViabilidadF,
                      maxLength: 220,
                      maxLines: null,
                      style: const TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold),
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecorations.registroLiderDecoration(
                        hintText: 'Ingrese viabilidad financiera.',
                        labelText: 'Viabilidad financiera',
                      ),
                      validator: (value) {
                        return (!RegexUtil.datos.hasMatch(value ?? ''))
                            ? null
                            : 'No contiene ningun dato.';
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: cPropiedadI,
                      maxLength: 110,
                      maxLines: null,
                      style: const TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold),
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecorations.registroLiderDecoration(
                        hintText:
                            'Ingrese estrategia de propiedad intelectual.',
                        labelText: 'Estrategia de propiedad intelectual',
                      ),
                      validator: (value) {
                        return (!RegexUtil.datos.hasMatch(value ?? ''))
                            ? null
                            : 'No contiene ningun dato.';
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: cInterpretacionR,
                      maxLength: 300,
                      maxLines: null,
                      style: const TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold),
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecorations.registroLiderDecoration(
                        hintText: 'Ingrese interpretación de resultados.',
                        labelText: 'Interpretación de resultados',
                      ),
                      validator: (value) {
                        return (!RegexUtil.datos.hasMatch(value ?? ''))
                            ? null
                            : 'No contiene ningun dato.';
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: cFuentesC,
                      maxLength: 110,
                      maxLines: null,
                      style: const TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold),
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecorations.registroLiderDecoration(
                        hintText: 'Ingrese Fuentes consultadas.',
                        labelText: 'Fuentes consultadas',
                      ),
                      validator: (value) {
                        return (!RegexUtil.datos.hasMatch(value ?? ''))
                            ? null
                            : 'No contiene ningun dato.';
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
                          style:
                              TextStyle(color: AppTema.grey100, fontSize: 25),
                        )),
                        onPressed: () {
                          setState(() {
                            camposLlenos = _formKey.currentState!.validate();
                            if (camposLlenos) {
                              agregarMemoriaTecnica();

                              // print(contrasena);
                            } else {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.warning,
                                title: 'Cuidado',
                                text: 'Rellena los campos faltantes',
                                confirmBtnText: 'Hecho',
                                confirmBtnColor: AppTema.pizazz,
                              );
                            }
                          });
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
}
