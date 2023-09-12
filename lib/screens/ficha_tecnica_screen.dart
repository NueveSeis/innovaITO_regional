import 'dart:convert';

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
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quickalert/quickalert.dart';
//import 'package:flutter_quill/flutter_quill.dart';

class FichaTecnicaScreen extends StatefulWidget {
  static const String name = 'ficha_tecnica';
  FichaTecnicaScreen({super.key});

  @override
  State<FichaTecnicaScreen> createState() => _FichaTecnicaScreenState();
}

class _FichaTecnicaScreenState extends State<FichaTecnicaScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool camposLlenos = true;

  TextEditingController cNombreComercial = TextEditingController();
  TextEditingController cNombreDescriptivo = TextEditingController();
  TextEditingController cObjetivo = TextEditingController();
  TextEditingController cProblematica = TextEditingController();
  TextEditingController cResultados = TextEditingController();
  //TextEditingController cNaturaleza = TextEditingController();
  //TextEditingController cArea = TextEditingController();

  bool cargando = false;
  bool cargando2 = false;
  List<Area> areas = [];
  List<Categoria> categorias = [];
  List<Naturaleza> naturalezas = [];
  String simon = '';
  bool seleccionado = false;
  String valueNaturaleza = '';
  String valueArea = '';
  String matricula = '';
  String idPersona = '';
  String idFichaUnica = '';

  Future obtenerAreas(String areaB) async {
    var url = '${dotenv.env['HOST_REST']}get_area.php?Id_categoria=$areaB';
    var response = await http.get(Uri.parse(url));
    areas = areaFromJson(response.body);
    cargando = true;
  }

  Future obtenerCategorias() async {
    //final bool catProv = ref.watch(categoriaCargandoProvider);
    var url = '${dotenv.env['HOST_REST']}get_categorias.php';
    var response = await http.get(Uri.parse(url));
    categorias = categoriaFromJson(response.body);
  }

  Future obtenerNaturaleza() async {
    var url = '${dotenv.env['HOST_REST']}get_naturalezas.php';
    var response = await http.get(Uri.parse(url));
    naturalezas = naturalezaFromJson(response.body);
  }

  Future<String> getMatricula(String idpersona) async {
    String url =
        '${dotenv.env['HOST_REST']}get_estudiante.php?Id_persona=$idpersona';
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      var datos = jsonDecode(response.body);
      matricula = datos[0]['Matricula'].toString();
      //print(matricula);
      await Future.delayed(Duration(seconds: 2));
      agregarFichaTecnica(idFichaUnica, matricula.toString());
      return matricula;
    } else {
      return '';
      //  print('Error al obtener datos de la API');
    }
  }

  Future agregarFichaTecnica(String idFichaUnica, String mat) async {
    var url = '${dotenv.env['HOST_REST']}agregarFichaTecnica.php';
    await http.post(Uri.parse(url), body: {
      'Id_fichaTecnica': 'F$idFichaUnica',
      'Nombre_corto': cNombreComercial.text,
      'Nombre_proyecto': cNombreDescriptivo.text,
      'Objetivo': cObjetivo.text,
      'Descripcion_general': cProblematica.text,
      'Prospecto_resultados': cResultados.text,
      'Id_area': valueArea,
      'Id_naturalezaTecnica': valueNaturaleza,
      'Folio': 'F$idFichaUnica',
      'Matricula': mat,
    });
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Ficha técnica registrada',
      confirmBtnText: 'Hecho',
      confirmBtnColor: AppTema.pizazz,
    );
  }

  Future<void> agregarValidacionProyectoC(
      String coor, String fol, dynamic fechaV, dynamic obs, dynamic est) async {
    var url = '${dotenv.env['HOST_REST']}agregar_validacionProyectoC.php';
    var response = await http.post(
      Uri.parse(url),
      body: {
        'Id_coordinador': coor,
        'Folio': fol,
        'Fecha_validacion': fechaV,
        'Observaciones': obs,
        'Estado': est
      },
    );

    if (response.statusCode == 200) {
      // La solicitud se completó exitosamente
      //print('Solicitud completada: ${response.body}');
    } else {
      // Manejo de errores
      //print('Error en la solicitud: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    //final bool catProv = ref.watch(categoriaCargandoProvider);

    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Ficha técnica',
          fontSize: 25,
          widget: Consumer(builder: (context, ref, child) {
            final String? folioProyecto = ref.watch(folioProyectoUsuarioLogin);
            return (folioProyecto == 'SN' || folioProyecto == null)
                ? Column(children: [
                    const SizedBox(height: 50),
                    const Text(
                      'Datos del proyecto',
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
                              Consumer(builder: (context, ref, child) {
                                idPersona = ref.watch(idUsuarioLogin);
                                return const SizedBox();
                              }),
                              const SizedBox(height: 40),

                              TextFormField(
                                controller: cNombreDescriptivo,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                maxLength: 100,
                                maxLines: null,
                                style: const TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold),
                                autocorrect: false,
                                keyboardType: TextInputType.emailAddress,
                                decoration:
                                    InputDecorations.registroLiderDecoration(
                                  hintText: 'Ingrese nombre descriptivo',
                                  labelText: 'Nombre descriptivo',
                                ),
                                validator: (value) {
                                  return (!RegexUtil.datos
                                          .hasMatch(value ?? ''))
                                      ? null
                                      : 'No contiene ningún dato.';
                                },
                                //onChanged: (value) => accesoFormulario.correo = value,
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: cNombreComercial,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                maxLength: 30,
                                autocorrect: false,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold),
                                decoration:
                                    InputDecorations.registroLiderDecoration(
                                  hintText:
                                      'Ingrese nombre corto (nombre comercial)',
                                  labelText: 'Nombre corto (nombre comercial)',
                                ),
                                validator: (value) {
                                  return (!RegexUtil.datos
                                          .hasMatch(value ?? ''))
                                      ? null
                                      : 'No contiene ningún dato.';
                                },
                                //onChanged: (value) => accesoFormulario.correo = value,
                              ),
                              // const SizedBox(height: 20),

                              FutureBuilder(
                                  future: obtenerCategorias(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return Consumer(
                                          builder: (context, ref, child) {
                                        final bool areaProvLoad = ref
                                            .watch(categoriaCargandoProvider);
                                        final String areaProvSelec =
                                            ref.watch(categoriaSelecProvider);
                                        return cateSeleccion(ref);
                                      });
                                    } else {
                                      return const CircularProgressIndicator();
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
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            return areaDrop(areas);
                                          } else {
                                            return const CircularProgressIndicator();
                                          }
                                        })
                                    : const SizedBox();
                              }),
                              FutureBuilder(
                                future: obtenerNaturaleza(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return naturalezaDrop(naturalezas);
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: cObjetivo,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                maxLength: 500,
                                maxLines: null,
                                style: const TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold),
                                autocorrect: false,
                                keyboardType: TextInputType.emailAddress,
                                decoration:
                                    InputDecorations.registroLiderDecoration(
                                  hintText:
                                      'Plantear el objetivo general respondiendo a: ¿Qué?, ¿Cómo?, ¿Para qué?, ¿Qué soluciona?',
                                  labelText: 'Objetivo del proyecto',
                                ),
                                validator: (value) {
                                  return (!RegexUtil.datos
                                          .hasMatch(value ?? ''))
                                      ? null
                                      : 'No contiene ningún dato.';
                                },
                                //onChanged: (value) => accesoFormulario.correo = value,
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: cProblematica,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                maxLength: 600,
                                maxLines: null,
                                style: const TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold),
                                autocorrect: false,
                                keyboardType: TextInputType.emailAddress,
                                decoration:
                                    InputDecorations.registroLiderDecoration(
                                  hintText:
                                      'Explicar qué necesidad, problemática u oportunidad del entorno se atiende, justificar por qué se quiere desarrollar este proyecto.',
                                  labelText: 'Problemática identificada',
                                  //prefixIcon: Icons.person
                                ),
                                validator: (value) {
                                  return (!RegexUtil.datos
                                          .hasMatch(value ?? ''))
                                      ? null
                                      : 'No contiene ningún dato.';
                                },
                                //onChanged: (value) => accesoFormulario.correo = value,
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: cResultados,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                maxLength: 600,
                                maxLines: null,
                                style: const TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold),
                                autocorrect: false,
                                keyboardType: TextInputType.emailAddress,
                                decoration:
                                    InputDecorations.registroLiderDecoration(
                                  hintText:
                                      'Describir los beneficios cualitativos y cuantitativos de la propuesta.',
                                  labelText:
                                      'Resultados esperados del proyecto',
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
                                        color: AppTema.grey100, fontSize: 25),
                                  )),
                                  onPressed: () {
                                    setState(() {
                                      camposLlenos =
                                          _formKey.currentState!.validate();
                                      if (camposLlenos) {
                                        idFichaUnica = Generar.idProyecto(
                                            cNombreComercial.text);
                                        getMatricula(idPersona);
                                        //print('Matricula es: ' + matricula.toString());
                                        agregarFichaTecnica(
                                            idFichaUnica, matricula.toString());
                                        agregarValidacionProyectoC('COO01',
                                            'F$idFichaUnica', null, null, null);
                                        ref
                                            .read(folioProyectoUsuarioLogin
                                                .notifier)
                                            .update(
                                                (state) => 'F$idFichaUnica');
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.success,
                                          title: 'Ficha técnica agregada',
                                          confirmBtnText: 'Hecho',
                                          confirmBtnColor: AppTema.pizazz,
                                          onConfirmBtnTap: () {
                                            context.pushReplacementNamed(
                                                'inicioLider');
                                          },
                                        );
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

                                    //context.pushNamed('registro_usuario_lider');
                                  },
                                ),
                              ),
                            ],
                          )),
                    ),
                  ])
                : const Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Ya has subido la ficha técnica',
                          style: TextStyle(
                              color: AppTema.bluegrey700,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  );
          })),
    );
  }

  Column cateSeleccion(WidgetRef ref) {
    return Column(
      children: [
        Container(
          // padding: EdgeInsets.only(right: 2.0),
          alignment: Alignment.topLeft,
          child: const Text(
            'Seleccione categoría:',
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
            valueArea = value!.idArea;
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
          onChanged: (value) {
            valueNaturaleza = value!.idNaturalezaTecnica;
          },
        ),
      ],
    );
  }
}
