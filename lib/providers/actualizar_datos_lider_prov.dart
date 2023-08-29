import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/screens/screens.dart';
import 'package:http/http.dart' as http;

Future<List<Genero>> obtenerGeneroAP() async {
  var url = 'https://evarafael.com/Aplicacion/rest/get_genero.php';
  var response = await http.get(Uri.parse(url));
  List<Genero> lista = generoFromJson(response.body);
  return lista;
}

Future<List<Expectativa>> obtenerExpectativaAP() async {
  var url = 'https://evarafael.com/Aplicacion/rest/get_expectativa.php';
  var response = await http.get(Uri.parse(url));
  List<Expectativa> lista = expectativaFromJson(response.body);
  return lista;
}

Future<List<Semestre>> obtenerSemestreAP() async {
  var url = 'https://evarafael.com/Aplicacion/rest/get_semestre.php';
  var response = await http.get(Uri.parse(url));
  List<Semestre> lista = semestreFromJson(response.body);
  return lista;
}

Future<List<Nivel>> obtenerNivelAP() async {
  var url = 'https://evarafael.com/Aplicacion/rest/get_nivel.php';
  var response = await http.get(Uri.parse(url));
  List<Nivel> lista = nivelFromJson(response.body);
  return lista;
}

Future<List<TipoTecnologico>> obtenerTipoTecAP() async {
  var url = 'https://evarafael.com/Aplicacion/rest/get_tipoTec.php';
  var response = await http.get(Uri.parse(url));
  List<TipoTecnologico> tipoTec = tipoTecnologicoFromJson(response.body);
  return tipoTec;
}

Future<List<Tecnologico>> obtenerTecnologicoAP(ref) async {
  final valueTipo = ref.watch(tipoTecProvAP);
  var url =
      'https://evarafael.com/Aplicacion/rest/get_tecnologico.php?Id_tipoTec=$valueTipo';
  var response = await http.get(Uri.parse(url));
  List<Tecnologico> tecnologicoM = tecnologicoFromJson(response.body);
  return tecnologicoM;
}

Future<List<Departamento>> obtenerDepartamentosAP(ref) async {
  final valueClaveTec = ref.watch(tecnologicoProvAP);
  var url =
      'https://evarafael.com/Aplicacion/rest/get_departamento.php?Clave_tecnologico=$valueClaveTec';
  var response = await http.get(Uri.parse(url));
  List<Departamento> departamento = departamentoFromJson(response.body);
  return departamento;
}

Future<List<Carrera>> obtenerCarreraAP(ref) async {
  final depto = ref.watch(departamentoProvAP);
  var url =
      'https://evarafael.com/Aplicacion/rest/get_carrera.php?Id_departamento=$depto';
  var response = await http.get(Uri.parse(url));
  List<Carrera> carrera = carreraFromJson(response.body);
  return carrera;
}

final tipoTecProvAP = StateProvider<String>((ref) => 'SN');
final tecnologicoProvAP = StateProvider<String>((ref) => 'SN');
final departamentoProvAP = StateProvider<String>((ref) => 'SN');
final carreraProvAP = StateProvider<String>((ref) => 'SN');
final fechaSeleccionadaProvAP =
    StateProvider<DateTime?>((ref) => DateTime(0000, 0, 0));
final generoProvAP = StateProvider<String>((ref) => 'SN');
final expectativaProvAP = StateProvider<String>((ref) => 'SN');
final semestreProvAP = StateProvider<String>((ref) => 'SN');
final nivelAcademicoProvAP = StateProvider<String>((ref) => 'SN');

final futureGeneroProvAP =
    FutureProvider<List<Genero>>((ref) => obtenerGeneroAP());
final futureExpectativaProvAP =
    FutureProvider<List<Expectativa>>((ref) => obtenerExpectativaAP());
final futureSemestreProvAP =
    FutureProvider<List<Semestre>>((ref) => obtenerSemestreAP());
final futureNivelProvAP =
    FutureProvider<List<Nivel>>((ref) => obtenerNivelAP());
final futureTipoTecProvAP =
    FutureProvider<List<TipoTecnologico>>((ref) => obtenerTipoTecAP());
final futureTecnologicoProvAP =
    FutureProvider<List<Tecnologico>>((ref) => obtenerTecnologicoAP(ref));
final futureDepartamentoProvAP =
    FutureProvider<List<Departamento>>((ref) => obtenerDepartamentosAP(ref));
final futureCarreraProvAP =
    FutureProvider<List<Carrera>>((ref) => obtenerCarreraAP(ref));
