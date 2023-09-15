import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/screens/screens.dart';
import 'package:http/http.dart' as http;

//* PARA OBTENER LOS TECNOLOGICOS

Future<List<Tecnologico>> obtenerTecnologicoGC() async {
  final url = '${dotenv.env['HOST_REST']}get_tecnologicos.php';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final tecnologicoM = tecnologicoFromJson(response.body);
      return tecnologicoM;
    } else {
      throw Exception('Error al obtener tecnológicos');
    }
  } catch (e) {
    throw Exception('Error al obtener tecnológicos: $e');
  }
}

final tecnologicoProvGC = StateProvider<String>((ref) => 'SN');

final futureTecnologicoProvGC =
    FutureProvider<List<Tecnologico>>((ref) => obtenerTecnologicoGC());

//* PARA OBTENER LOS PROYECTOS

Future<List<ProyectoGc>> obtenerProyectosGC() async {
  final url = '${dotenv.env['HOST_REST']}get_proyecto.php';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final proyectos = proyectoGcFromJson(response.body);
      return proyectos;
    } else {
      throw Exception('Error al obtener tecnológicos');
    }
  } catch (e) {
    throw Exception('Error al obtener tecnológicos: $e');
  }
}

final proyectosProvGC = StateProvider<String>((ref) => 'SN');

final futureProyectosProvGC =
    FutureProvider<List<ProyectoGc>>((ref) => obtenerProyectosGC());

//* OBTENER LOS PARTICIPANDE DEL PROYECTO

Future<List<DatosEstudiante>> obtenerParticipantesGC(ref) async {
  final folio = ref.watch(proyectosProvGC);
  final url =
      '${dotenv.env['HOST_REST']}get_participanteProyecto.php?Folio=$folio';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final participantes = datosEstudianteFromJson(response.body);
      return participantes;
    } else {
      throw Exception('Error al obtener los participantes');
    }
  } catch (e) {
    throw Exception('Error al obtener los participantes: $e');
  }
}

final participantesProvGC = StateProvider<String>((ref) => 'SN');

final futureParticipantesProvGC =
    FutureProvider<List<DatosEstudiante>>((ref) => obtenerParticipantesGC(ref));

//* OBTENER LOS ASESORES DEL PROYECTO

Future<List<ProyectoAsesorGc>> obtenerAsesoresGC(ref) async {
  final folio = ref.watch(proyectosProvGC);
  final url = '${dotenv.env['HOST_REST']}get_proyectoAsesorGC.php?Folio=$folio';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final asesores = proyectoAsesorGcFromJson(response.body);
      return asesores;
    } else {
      throw Exception('Error al obtener los participantes');
    }
  } catch (e) {
    throw Exception('Error al obtener los participantes: $e');
  }
}

final asesoresProvGC = StateProvider<String>((ref) => 'SN');

final futureAsesoresProvGC =
    FutureProvider<List<ProyectoAsesorGc>>((ref) => obtenerAsesoresGC(ref));

//* OBTENER LOS SALAS DE LOS PROYECTOS

Future<List<SalaHs>> obtenerSalasGC(ref) async {
  final url = '${dotenv.env['HOST_REST']}get_asignarHSala.php';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final salas = salaHsFromJson(response.body);
      return salas;
    } else {
      throw Exception('Error al obtener los participantes');
    }
  } catch (e) {
    throw Exception('Error al obtener los participantes: $e');
  }
}

final salasProvGC = StateProvider<String>((ref) => 'SN');

final futureSalasProvGC =
    FutureProvider<List<SalaHs>>((ref) => obtenerSalasGC(ref));

//* OBTENER LOS STANDS DE LOS PROYECTOS

Future<List<StandHs>> obtenerStandGC(ref) async {
  final url = '${dotenv.env['HOST_REST']}get_asignarHStand.php';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final stands = standHsFromJson(response.body);
      return stands;
    } else {
      throw Exception('Error al obtener los participantes');
    }
  } catch (e) {
    throw Exception('Error al obtener los participantes: $e');
  }
}

final standProvGC = StateProvider<String>((ref) => 'SN');

final futureStandProvGC =
    FutureProvider<List<StandHs>>((ref) => obtenerStandGC(ref));
