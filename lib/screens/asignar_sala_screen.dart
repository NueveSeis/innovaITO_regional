import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/helpers/helpers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:uuid/uuid.dart';

class AsignarSalaScreen extends ConsumerWidget {
  static const String name = 'asignar_sala';
  AsignarSalaScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController cNombreRubrica = TextEditingController();
  TextEditingController cNumeroCriterios = TextEditingController();

  final futureNivelProv = FutureProvider<List<Nivel>>((ref) => obtenerNivel());

  Future<bool> agregarCriterio(
      String idCri,
      String nombreCri,
      String valorMaxCri,
      String valorMinCri,
      String porcentajeCri,
      String idRub) async {
    var url = 'https://evarafael.com/Aplicacion/rest/agregar_criterio.php';
    // Reemplaza con la URL del archivo PHP en tu servidor
    try {
      var response = await http.post(Uri.parse(url), body: {
        'Id_criterio': 'CRI$idCri',
        'Nombre_criterio': nombreCri,
        'Valor_max': valorMaxCri,
        'Valor_min': valorMinCri,
        'Porcentaje_criterio': porcentajeCri,
        'Id_rubrica': 'RUB$idRub'
      });
      print('Código de estado de la respuesta: ${response.statusCode}');
      print('Cuerpo de la respuesta: ${response.body}');
      if (response.statusCode == 200) {
        print('Modificado en la db');
        return true;
      } else {
        print('No modificado');
        return false;
      }
    } catch (error) {
      print('Error durante la solicitud HTTP: $error');
      return false;
    }
  }

  Future<List<Nivel>> obtenerNivel() async {
    var url = 'https://evarafael.com/Aplicacion/rest/get_nivel.php';
    var response = await http.get(Uri.parse(url));
    List<Nivel> lista = nivelFromJson(response.body);
    return lista;
  }
  //bool camposLlenos = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Fondo(
            tituloPantalla: 'Asignacion de Sala',
            fontSize: 20,
            widget: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Ingrese datos de la rubrica',
                  style: TextStyle(
                      color: AppTema.balticSea,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
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
                  error: (error, stackTrace) =>
                      const Text('Error al cargar los niveles academicos.'),
                ),
              ],
            )));
  }
}
