import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innova_ito/helpers/helpers.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/screens/departamento_screen.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

final futureGeneroProv = FutureProvider<List<Genero>>((ref) => obtenerGenero());
final futureExpectativaProv =
    FutureProvider<List<Expectativa>>((ref) => obtenerExpectativa());
final futureSemestreProv =
    FutureProvider<List<Semestre>>((ref) => obtenerSemestre());
final futureNivelProv = FutureProvider<List<Nivel>>((ref) => obtenerNivel());
final futureTipoTecProv =
    FutureProvider<List<TipoTecnologico>>((ref) => obtenerTipoTec());
final futureTecnologicoProv =
    FutureProvider<List<Tecnologico>>((ref) => obtenerTecnologico(ref));
final futureDepartamentoProv =
    FutureProvider<List<Departamento>>((ref) => obtenerDepartamentos(ref));
final futureCarreraProv =
    FutureProvider<List<Carrera>>((ref) => obtenerCarrera(ref));

final TipoTecProv = StateProvider<String>((ref) => 'SN');
final TecnologicoProv = StateProvider<String>((ref) => 'SN');
final DepartamentoProv = StateProvider<String>((ref) => 'SN');
final CarreraProv = StateProvider<String>((ref) => 'SN');
final FechaSeleccionadaProv =
    StateProvider<DateTime?>((ref) => DateTime(0000, 0, 0));

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
  final valueTipo = ref.watch(TipoTecProv);
  var url =
      'https://evarafael.com/Aplicacion/rest/get_tecnologico.php?Id_tipoTec=$valueTipo';
  var response = await http.get(Uri.parse(url));
  List<Tecnologico> tecnologicoM = tecnologicoFromJson(response.body);
  return tecnologicoM;
}

Future<List<Departamento>> obtenerDepartamentos(ref) async {
  final valueClaveTec = ref.watch(TecnologicoProv);
  var url =
      'https://evarafael.com/Aplicacion/rest/get_departamento.php?Clave_tecnologico=$valueClaveTec';
  var response = await http.get(Uri.parse(url));
  List<Departamento> departamento = departamentoFromJson(response.body);
  return departamento;
}

Future<List<Carrera>> obtenerCarrera(ref) async {
  final depto = ref.watch(DepartamentoProv);
  var url =
      'https://evarafael.com/Aplicacion/rest/get_carrera.php?Id_departamento=$depto';
  var response = await http.get(Uri.parse(url));
  List<Carrera> carrera = carreraFromJson(response.body);
  return carrera;
}

class AgregarParticipanteScreen extends ConsumerWidget {
  static const String name = 'agregar_participantes';

  AgregarParticipanteScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //TextEditingController nivel = TextEditingController();
  TextEditingController cMatricula = TextEditingController();
  TextEditingController cNombre = TextEditingController();
  TextEditingController cApellidoP = TextEditingController();
  TextEditingController cApellidoM = TextEditingController();
  TextEditingController cCorreo = TextEditingController();
  TextEditingController cPromedio = TextEditingController();
  TextEditingController cNumero = TextEditingController();
  TextEditingController cCurp = TextEditingController();
  TextEditingController cIne = TextEditingController();
  String contrasena = '';
  String id = '';
  String contrasenaHash = '';
  bool existePersona = false;
  String idNivel = '';
  bool camposLlenos = true;
  DateTime? fechaSeleccionada;

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
      DateTime fecha = DateTime(seleccion.year, seleccion.month, seleccion.day);
      // ref
      //     .read(FechaSeleccionadaProv.notifier)
      //     .update((state) => seleccion.);
      print(DateFormat('yyyy-MM-dd').format(fecha));
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
                                    value: itemone.tipoGenero,
                                    child: Text(
                                      itemone.tipoGenero,
                                      overflow: TextOverflow.visible,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {}),
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
                                    value: itemone.expectativa,
                                    child: Text(
                                      itemone.expectativa,
                                      overflow: TextOverflow.visible,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {}),
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
                                    value: itemone.numeroSemestre,
                                    child: Text(
                                      itemone.numeroSemestre,
                                      overflow: TextOverflow.visible,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {}),
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
                                    value: itemone.nombreNivel,
                                    child: Text(
                                      itemone.nombreNivel,
                                      overflow: TextOverflow.visible,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {}),
                            loading: () => const CircularProgressIndicator(),
                            error: (error, stackTrace) =>
                                const Text('Error al cargar los generos'),
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
                                      .read(TipoTecProv.notifier)
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
                                      .read(TecnologicoProv.notifier)
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
                                  print(value);
                                  ref
                                      .read(DepartamentoProv.notifier)
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
                                  print(value);
                                  ref
                                      .read(CarreraProv.notifier)
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
                              onPressed: () async {},
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            )));
  }
}
