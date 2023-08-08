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

Future<List<Genero>> obtenerGenero() async {
  var url = 'https://evarafael.com/Aplicacion/rest/get_genero.php';
  var response = await http.get(Uri.parse(url));
  List<Genero> lista = generoFromJson(response.body);
  return lista;
}

Future<List<Expectativa>> obtenerExpectativa() async {
  var url = 'https://evarafael.com/Aplicacion/rest/get_expectativa.php';
  var response = await http.get(Uri.parse(url));
  List<Expectativa> lista = expectativaFromJson(response.body);
  return lista;
}

Future<List<Semestre>> obtenerSemestre() async {
  var url = 'https://evarafael.com/Aplicacion/rest/get_semestre.php';
  var response = await http.get(Uri.parse(url));
  List<Semestre> lista = semestreFromJson(response.body);
  return lista;
}

Future<List<Nivel>> obtenerNivel() async {
  var url = 'https://evarafael.com/Aplicacion/rest/get_nivel.php';
  var response = await http.get(Uri.parse(url));
  List<Nivel> lista = nivelFromJson(response.body);
  return lista;
}

Future<List<TipoTecnologico>> obtenerTipoTec() async {
  var url = 'https://evarafael.com/Aplicacion/rest/get_tipoTec.php';
  var response = await http.get(Uri.parse(url));
  List<TipoTecnologico> tipoTec = tipoTecnologicoFromJson(response.body);
  return tipoTec;
}

Future<List<Tecnologico>> obtenerTecnologico(ref) async {
  final valueTipo = ref.watch(tipoTecProv);
  var url =
      'https://evarafael.com/Aplicacion/rest/get_tecnologico.php?Id_tipoTec=$valueTipo';
  var response = await http.get(Uri.parse(url));
  List<Tecnologico> tecnologicoM = tecnologicoFromJson(response.body);
  return tecnologicoM;
}

Future<List<Departamento>> obtenerDepartamentos(ref) async {
  final valueClaveTec = ref.watch(tecnologicoProv);
  var url =
      'https://evarafael.com/Aplicacion/rest/get_departamento.php?Clave_tecnologico=$valueClaveTec';
  var response = await http.get(Uri.parse(url));
  List<Departamento> departamento = departamentoFromJson(response.body);
  return departamento;
}

Future<List<Carrera>> obtenerCarrera(ref) async {
  final depto = ref.watch(departamentoProv);
  var url =
      'https://evarafael.com/Aplicacion/rest/get_carrera.php?Id_departamento=$depto';
  var response = await http.get(Uri.parse(url));
  List<Carrera> carrera = carreraFromJson(response.body);
  return carrera;
}

Future<bool> existente(String idPersona) async {
  String url = 'https://evarafael.com/Aplicacion/rest/existePersona.php';
  var response = await http.post(Uri.parse(url), body: {
    'Id_persona': idPersona,
  });

  var data = json.decode(response.body);
  if (data == "Realizado") {
    return true;
  } else {
    return false;
  }
}

Future agregarParticipante(
    String id,
    String nombre,
    String ap1,
    String ap2,
    String telefono,
    String correo,
    String ine,
    String curp,
    String matricula,
    String fecha,
    String promedio,
    String expectativa,
    String carrera,
    String genero,
    String semestre,
    String nivel,
    String folio) async {
  var url = 'https://evarafael.com/Aplicacion/rest/agregar_participante.php';
  await http.post(Uri.parse(url), body: {
    'Id_persona': id,
    'Nombre_persona': nombre,
    'Apellido1': ap1,
    'Apellido2': ap2,
    'Telefono': telefono,
    'Correo_electronico': correo,
    'Num_ine': ine,
    'Curp': curp,
    'Matricula': matricula,
    'Fecha_nacimiento': fecha,
    'Promedio': promedio,
    'Id_expectativa': expectativa,
    'Id_carrera': carrera,
    'Id_genero': genero,
    'Id_semestre': semestre,
    'Id_nivel': nivel,
    'Folio': folio,
  });
}

class AgregarParticipanteScreen extends ConsumerWidget {
  static const String name = 'agregar_participantes';

  AgregarParticipanteScreen({super.key});

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
    final cFolio = ref.watch(folioProyectoUsuarioLogin);

    //generosList = generos;

    return Scaffold(
        body: Fondo(
            tituloPantalla: 'Registro de participante',
            fontSize: 20,
            widget: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Ingrese datos del estudiante',
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
                              hintText: 'Ingrese nombre(s)',
                              labelText: 'Nombre(s)',
                            ),
                            //onChanged: (value) => registroLider.nombre = value,
                            validator: (value) {
                              return RegexUtil.nombres.hasMatch(value ?? '')
                                  ? null
                                  : 'Nombre no valido.';
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: cApellidoP,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese apellido paterno',
                              labelText: 'Apellido paterno',
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: cApellidoM,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese apellido materno',
                              labelText: 'Apellido materno',
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: cMatricula,
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese matricula',
                              labelText: 'Matricula',
                            ),
                            validator: (value) {
                              return RegexUtil.matricula.hasMatch(value ?? '')
                                  ? null
                                  : 'Matricula no valida.';
                            },
                          ),
                          const SizedBox(height: 20),
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
                            controller: cCorreo,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese correo electronico',
                              labelText: 'Correo electronico',
                            ),
                            validator: (value) {
                              return RegexUtil.correoEdu.hasMatch(value ?? '')
                                  ? null
                                  : 'Solo se acepta correo institucional.';
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
                                  String idPersona = Generar.idPersona(
                                      cNombre.text.toUpperCase(),
                                      cApellidoP.text.toUpperCase(),
                                      cApellidoM.text.toUpperCase(),
                                      cCorreo.text.toUpperCase());
                                  bool result = await existente(idPersona);
                                  //print('1');
                                  if (result) {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      title: 'Usuario existente',
                                      confirmBtnText: 'Hecho',
                                      confirmBtnColor: AppTema.pizazz,
                                    );
                                  } else {
                                    agregarParticipante(
                                        idPersona,
                                        cNombre.text.toUpperCase(),
                                        cApellidoP.text.toUpperCase(),
                                        cApellidoM.text.toUpperCase(),
                                        cNumero.text,
                                        cCorreo.text.toUpperCase(),
                                        cIne.text,
                                        cCurp.text.toUpperCase(),
                                        cMatricula.text.toUpperCase(),
                                        DateFormat('yyyy-MM-dd').format(fecha),
                                        cPromedio.text,
                                        cExpectativa,
                                        cCarrera,
                                        cGenero,
                                        cSemestre,
                                        cNivel,
                                        cFolio);
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
