import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innova_ito/models/informacionProyectoER.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/screens/screens.dart';
import 'package:http/http.dart' as http;

final buscarProyectoRegionalProv = StateProvider<String>((ref) => 'SN');

//* PARA OBTENER LOS TECNOLOGICOS

Future<List<InformacionProyectoEr>> obtenerInfoProyectosRegional(ref) async {
  final url = '${dotenv.env['HOST_REST']}get_proyectosPresentacionesER.php';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final info = informacionProyectoErFromJson(response.body);
      return info;
    } else {
      throw Exception('Error al obtener los proyectos');
    }
  } catch (e) {
    throw Exception('Error al obtener los proyectos: $e');
  }
}

final infoProyectosRegionalProv = StateProvider<String>((ref) => 'SN');

final futureinfoProyectosRegionalProv =
    FutureProvider<List<InformacionProyectoEr>>(
        (ref) => obtenerInfoProyectosRegional(ref));
