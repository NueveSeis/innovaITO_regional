import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/helpers/helpers.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';

Future<bool> actualizarLider(
  String id,
  String telefono,
  String ine,
  String curp,
  String fecha,
  String promedio,
  String expectativa,
  String carrera,
  String genero,
  String semestre,
  String nivel,
) async {
  try {
    var url = 'https://evarafael.com/Aplicacion/rest/update_lider.php';
    var response = await http.post(Uri.parse(url), body: {
      'Id_persona': id,
      'Telefono': telefono,
      'Num_ine': ine,
      'Curp': curp,
      'Fecha_nacimiento': fecha,
      'Promedio': promedio,
      'Id_expectativa': expectativa,
      'Id_carrera': carrera,
      'Id_genero': genero,
      'Id_semestre': semestre,
      'Id_nivel': nivel,
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      print('La solicitud no fue exitosa: ${response.statusCode}');
      return false;
    }
  } catch (error) {
    print('Error al realizar la solicitud: $error');
    return false;
  }
}

class ActualizarDatosLiderScreen extends ConsumerWidget {
  static const String name = 'actualizar_lider';

  ActualizarDatosLiderScreen({super.key});

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

  String id = '';
  DateTime? fechaSeleccionada;
  DateTime fecha = DateTime(0000, 00, 00);

  Future _mostrarDatePicker(context, ref) async {
    final seleccion = await showDatePicker(
      context: context,
      locale: const Locale("es", "ES"),
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2024),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTema.pizazz,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  primary: AppTema.pizazz // button text color
                  ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (seleccion != null && seleccion != fechaSeleccionada) {
      fechaSeleccionada = seleccion;
      fecha = DateTime(seleccion.year, seleccion.month, seleccion.day);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matricula = ref.watch(matriculaProvider);
    final id = ref.watch(idUsuarioLogin);

    final generos = ref.watch(futureGeneroProv);
    final semestres = ref.watch(futureSemestreProv);
    final expectativas = ref.watch(futureExpectativaProv);
    final niveles = ref.watch(futureNivelProv);
    final tiposTec = ref.watch(futureTipoTecProv);
    final tecnologicos = ref.watch(futureTecnologicoProv);
    final departamentos = ref.watch(futureDepartamentoProv);
    final carreras = ref.watch(futureCarreraProv);
    final cGenero = ref.watch(generoProv);
    final cExpectativa = ref.watch(expectativaProv);
    final cSemestre = ref.watch(semestreProv);
    final cNivel = ref.watch(nivelAcademicoProv);
    final cCarrera = ref.watch(carreraProv);
    final camposLlenos = ref.watch(camposLlenosProv);

    //generosList = generos;

    return Scaffold(
        body: Fondo(
            tituloPantalla: 'Completar registro lider',
            fontSize: 20,
            widget: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Ingrese datos del estudiante lider',
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
                          const SizedBox(height: 40),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: cPromedio,
                            autocorrect: false,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese promedio',
                              labelText: 'Promedio',
                            ),
                            validator: (value) {
                              return RegexUtil.promedio.hasMatch(value ?? '')
                                  ? null
                                  : 'Promedio no valido.';
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: cCurp,
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese CURP',
                              labelText: 'CURP',
                            ),
                            validator: (value) {
                              return RegexUtil.curp.hasMatch(value ?? '')
                                  ? null
                                  : 'CURP no valida.';
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: cIne,
                            autocorrect: false,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese No. de credencial INE',
                              labelText: 'No. Cred. INE',
                            ),
                            validator: (value) {
                              return RegexUtil.ine.hasMatch(value ?? '')
                                  ? null
                                  : 'Credencial no valida.';
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: cNumero,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese Numero telefonico',
                              labelText: 'Numero telefonico',
                            ),
                            validator: (value) {
                              return RegexUtil.telefono.hasMatch(value ?? '')
                                  ? null
                                  : 'Solo se aceptan numeros.';
                            },
                          ),
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Genero',
                              style: TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          generos.when(
                            data: (data) => DropdownButtonFormField<String>(
                                value: null,
                                style: const TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold),
                                items: data.map((itemone) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.centerLeft,
                                    value: itemone.idGenero,
                                    child: Text(
                                      itemone.tipoGenero,
                                      overflow: TextOverflow.visible,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  ref
                                      .read(generoProv.notifier)
                                      .update((state) => value.toString());
                                }),
                            loading: () => const CircularProgressIndicator(),
                            error: (error, stackTrace) =>
                                const Text('Error al cargar los generos'),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Expectativa',
                              style: TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          expectativas.when(
                            data: (data) => DropdownButtonFormField<String>(
                                value: null,
                                style: const TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold),
                                items: data.map((itemone) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.centerLeft,
                                    value: itemone.idExpectativa,
                                    child: Text(
                                      itemone.expectativa,
                                      overflow: TextOverflow.visible,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  ref
                                      .read(expectativaProv.notifier)
                                      .update((state) => value.toString());
                                }),
                            loading: () => const CircularProgressIndicator(),
                            error: (error, stackTrace) =>
                                const Text('Error al cargar las expectativas.'),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Semestre',
                              style: TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          semestres.when(
                            data: (data) => DropdownButtonFormField<String>(
                                value: null,
                                style: const TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold),
                                items: data.map((itemone) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.centerLeft,
                                    value: itemone.idSemestre,
                                    child: Text(
                                      itemone.numeroSemestre,
                                      overflow: TextOverflow.visible,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  ref
                                      .read(semestreProv.notifier)
                                      .update((state) => value.toString());
                                }),
                            loading: () => const CircularProgressIndicator(),
                            error: (error, stackTrace) =>
                                const Text('Error al cargar los semestres.'),
                          ),
                          const SizedBox(height: 20),
                          Center(
                              child: ElevatedButton(
                            child: const Text('Seleccione fecha de nacimiento'),
                            onPressed: () => _mostrarDatePicker(context, ref),
                          )),
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Nivel academico',
                              style: TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          niveles.when(
                            data: (data) => DropdownButtonFormField<String>(
                                value: null,
                                style: const TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold),
                                items: data.map((itemone) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.centerLeft,
                                    value: itemone.idNivel,
                                    child: Text(
                                      itemone.nombreNivel,
                                      overflow: TextOverflow.visible,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  ref
                                      .read(nivelAcademicoProv.notifier)
                                      .update((state) => value.toString());
                                }),
                            loading: () => const CircularProgressIndicator(),
                            error: (error, stackTrace) => const Text(
                                'Error al cargar los niveles academicos.'),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Tipo de instituto o centro de investigación',
                              style: TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          tiposTec.when(
                            data: (data) => DropdownButtonFormField<String>(
                                isExpanded: true,
                                value: null,
                                style: const TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold),
                                items: data.map((itemone) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.centerLeft,
                                    value: itemone.idTipoTec,
                                    child: Text(
                                      itemone.tipoTec,
                                      overflow: TextOverflow.visible,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  print(value);
                                  ref
                                      .read(tipoTecProv.notifier)
                                      .update((state) => value.toString());
                                  ref.refresh(futureTecnologicoProv);
                                }),
                            loading: () => const CircularProgressIndicator(),
                            error: (error, stackTrace) => const Text(
                                'Error al cargar los tipos de institutos.'),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Instituto de pertenencia',
                              style: TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          tecnologicos.when(
                            data: (data) => DropdownButtonFormField<String>(
                                value: null,
                                isExpanded: true,
                                style: const TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold),
                                items: data.map((itemone) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.centerLeft,
                                    value: itemone.claveTecnologico,
                                    child: Text(
                                      itemone.nombreTecnologico,
                                      overflow: TextOverflow.visible,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  print(value);
                                  ref
                                      .read(tecnologicoProv.notifier)
                                      .update((state) => value.toString());
                                  ref.refresh(futureDepartamentoProv);
                                }),
                            loading: () => const CircularProgressIndicator(),
                            error: (error, stackTrace) =>
                                const Text('Error al cargar los tecnologicos.'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Departamento perteneciente',
                              style: TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          departamentos.when(
                            data: (data) => DropdownButtonFormField<String>(
                                value: null,
                                isExpanded: true,
                                style: const TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold),
                                items: data.map((itemone) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.centerLeft,
                                    value: itemone.idDepartamento,
                                    child: Text(
                                      itemone.nombreDepartamento,
                                      overflow: TextOverflow.visible,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  ref
                                      .read(departamentoProv.notifier)
                                      .update((state) => value.toString());
                                  ref.refresh(futureCarreraProv);
                                }),
                            loading: () => const CircularProgressIndicator(),
                            error: (error, stackTrace) =>
                                const Text('Error al cargar los tecnologicos.'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Carrera',
                              style: TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          carreras.when(
                            data: (data) => DropdownButtonFormField<String>(
                                value: null,
                                isExpanded: true,
                                style: const TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold),
                                items: data.map((itemone) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.centerLeft,
                                    value: itemone.idCarrera,
                                    child: Text(
                                      itemone.nombreCarrera,
                                      overflow: TextOverflow.visible,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  ref
                                      .read(carreraProv.notifier)
                                      .update((state) => value.toString());
                                }),
                            loading: () => const CircularProgressIndicator(),
                            error: (error, stackTrace) =>
                                const Text('Error al cargar las carreras.'),
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
                                'Registrar',
                                style: TextStyle(
                                    color: AppTema.grey100, fontSize: 25),
                              )),
                              onPressed: () async {
                                ref.read(camposLlenosProv.notifier).update(
                                    (state) =>
                                        _formKey.currentState!.validate());
                                if (camposLlenos == true &&
                                    fecha != DateTime(0000, 00, 00)) {
                                  //print('1');
                                  bool si = await actualizarLider(
                                    id,
                                    cNumero.text,
                                    cIne.text,
                                    cCurp.text,
                                    DateFormat('yyyy-MM-dd').format(fecha),
                                    cPromedio.text,
                                    cExpectativa,
                                    cCarrera,
                                    cGenero,
                                    cSemestre,
                                    cNivel,
                                  );

                                  if (si == true) {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.success,
                                      title: 'Agregado correctamente',
                                      confirmBtnText: 'Hecho',
                                      confirmBtnColor: AppTema.pizazz,
                                      onConfirmBtnTap: () {
                                        context.pushReplacementNamed(
                                            'participantes');
                                      },
                                    );
                                  } else {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      title: 'Error',
                                      text: 'Porfavor intente mas tarde.',
                                      confirmBtnText: 'Hecho',
                                      confirmBtnColor: AppTema.pizazz,
                                      onConfirmBtnTap: () {
                                        context.pushReplacementNamed(
                                            'participantes');
                                      },
                                    );
                                  }
                                } else {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.warning,
                                    title: 'Existen campos vacios',
                                    confirmBtnText: 'Hecho',
                                    confirmBtnColor: AppTema.pizazz,
                                  );
                                }
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
