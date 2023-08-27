import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/screens/screens.dart';
import 'package:http/http.dart' as http;

//* PARA OBTENER LOS TECNOLOGICOS

Future<List<Tecnologico>> obtenerTecnologicoGC() async {
  final url = 'https://evarafael.com/Aplicacion/rest/get_tecnologicos.php';

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
  final url = 'https://evarafael.com/Aplicacion/rest/get_proyecto.php';

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
      'https://evarafael.com/Aplicacion/rest/get_participanteProyecto.php?Folio=$folio';

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
