import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innova_ito/providers/providers.dart';

import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:innova_ito/helpers/helpers.dart';

import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

final selectedDateRangeProvider = StateProvider<DateTimeRange?>((ref) => null);

class GeneracionConstanciaScreen extends ConsumerWidget {
  static const String name = 'GeneracionConstanciaScreen';
  GeneracionConstanciaScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController cdirector = TextEditingController();
  TextEditingController cCoo = TextEditingController();
  TextEditingController cCargo = TextEditingController();

  List<SalaHs> salas = [];

  Future<void> getSala() async {
    String url = 'https://evarafael.com/Aplicacion/rest/get_asignarHSala.php';
    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        salas = salaHsFromJson(response.body);
      } else {
        print('La solicitud no fue exitosa: ${response.statusCode}');
      }
    } catch (error) {
      print('Error al realizar la solicitud: $error');
    }
  }

  Future<bool> eliminarAsignarHS(String foliop, String idSala) async {
    var url =
        'https://evarafael.com/Aplicacion/rest/delete_asignarHSala.php?Id_sala=$idSala&Folio=$foliop'; // Reemplaza con la URL del archivo PHP en tu servidor
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      print('Modificado en la db');
      return true;
    } else {
      print('No modificado');
      return false;
    }
  }

  String nombreTecnologicoConstancia = '';
  String nombreProyectoConstancia = '';
  String nombreParticipanteConst = '';
  String nombreCategoriaConstancia = '';
  String id = '';
  DateTime? fechaSeleccionada;
  DateTime fecha = DateTime(0000, 00, 00);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDateRange = ref.watch(selectedDateRangeProvider);
    final tecnologicos = ref.watch(futureTecnologicoProvGC);
    final proyectosGC = ref.watch(futureProyectosProvGC);
    final participantes = ref.watch(futureParticipantesProvGC);
    final nombreCoordinador = ref.watch(nombreUsuarioLogin);

    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Constancias',
          fontSize: 20,
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
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
                                hint: const Text(
                                  'Seleccione una opción',
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                      color: AppTema.bluegrey700,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                ),
                                isExpanded: true,
                                value: null,
                                style: const TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold),
                                items: data.map((itemone) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.centerLeft,
                                    value: itemone.nombreTecnologico,
                                    child: Text(
                                      itemone.nombreTecnologico,
                                      overflow: TextOverflow.visible,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  nombreTecnologicoConstancia =
                                      value.toString();
                                  print(value);
                                  ref
                                      .read(tecnologicoProvGC.notifier)
                                      .update((state) => value.toString());
                                  //ref.refresh(futureDepartamentoProv);
                                }),
                            loading: () => const CircularProgressIndicator(),
                            error: (error, stackTrace) =>
                                const Text('Error al cargar los tecnológicos.'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: cdirector,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese nombre completo del director',
                              labelText: 'Nombre completo del director',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: cCoo,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese nombre del encargado',
                              labelText: 'Nombre del encargado',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: cCargo,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese cargo del encargado',
                              labelText: 'Cargo del encargado',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Seleccione proyecto',
                              style: TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          proyectosGC.when(
                            data: (data) => DropdownButtonFormField<String>(
                                hint: const Text(
                                  'Seleccione una opción',
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                      color: AppTema.bluegrey700,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                ),
                                isExpanded: true,
                                value: null,
                                style: const TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold),
                                items: data.map((itemone) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.centerLeft,
                                    value: itemone.folio,
                                    child: Text(
                                      itemone.nombreProyecto,
                                      overflow: TextOverflow.visible,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  // Buscar el proyecto seleccionado en la lista de 'data'
                                  final selectedProject = data.firstWhere(
                                      (itemone) => itemone.folio == value);

                                  // Obtener el nombre del proyecto y el folio del elemento seleccionado
                                  nombreProyectoConstancia =
                                      selectedProject.nombreProyecto;

                                  nombreCategoriaConstancia =
                                      selectedProject.nombreCategoria;
                                  // Resto del código que quieras ejecutar al seleccionar un proyecto
                                  ref
                                      .read(proyectosProvGC.notifier)
                                      .update((state) => value.toString());
                                  ref.refresh(futureParticipantesProvGC);
                                }),
                            loading: () => const CircularProgressIndicator(),
                            error: (error, stackTrace) =>
                                const Text('Error al cargar los proyectos.'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Seleccione participante',
                              style: TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          participantes.when(
                            data: (data) => DropdownButtonFormField<String>(
                                hint: const Text(
                                  'Seleccione una opción',
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                      color: AppTema.bluegrey700,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                ),
                                isExpanded: true,
                                value: null,
                                style: const TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold),
                                items: data.map((itemone) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.centerLeft,
                                    value:
                                        '${itemone.nombrePersona} ${itemone.apellido1} ${itemone.apellido2}',
                                    child: Text(
                                      '${itemone.nombrePersona} ${itemone.apellido1} ${itemone.apellido2}',
                                      overflow: TextOverflow.visible,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  nombreParticipanteConst = value.toString();
                                  print(value);
                                  ref
                                      .read(participantesProvGC.notifier)
                                      .update((state) => value.toString());
                                  // ref.refresh(futureDepartamentoProv);
                                }),
                            loading: () => const CircularProgressIndicator(),
                            error: (error, stackTrace) => const Text(
                                'Error al cargar los participantes.'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _mostrarDateRangePickerRUJ(context, ref);
                  },
                  child: const Text('Seleccionar rango del evento'),
                ),
                Text(
                    'Fecha de inicio: ${selectedDateRange?.start != null ? DateFormat.yMd().format(selectedDateRange!.start) : "Ninguna"}'),
                Text(
                    'Fecha de fin: ${selectedDateRange?.end != null ? DateFormat.yMd().format(selectedDateRange!.end) : "Ninguna"}'),
                Container(
                  height: 50,
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: ElevatedButton(
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Generar constancia',
                          style:
                              TextStyle(color: AppTema.grey100, fontSize: 20),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      final now = DateTime.now();

                      final dia = DateFormat.d().format(now); // Día del mes
                      final mes =
                          DateFormat.MMMM('es').format(now); // Mes en letras
                      final ano = DateFormat.y().format(now); // Año
                      final fIni = DateFormat.d()
                          .format(selectedDateRange?.start ?? DateTime.now());
                      final fFin = DateFormat.d()
                          .format(selectedDateRange?.end ?? DateTime.now());
                      print(
                          'Día de inicio: ${DateFormat.d().format(selectedDateRange?.start ?? DateTime.now())}');
                      String ruta = await pdf.constancia(
                          nombreTecnologicoConstancia.toUpperCase(),
                          nombreParticipanteConst.toUpperCase(),
                          'PARTICIPANTE',
                          nombreProyectoConstancia.toUpperCase(),
                          nombreCategoriaConstancia.toUpperCase(),
                          'LOCAL',
                          cdirector.text.toUpperCase(),
                          dia,
                          mes.toUpperCase(),
                          ano,
                          fIni,
                          fFin,
                          cCoo.text.toUpperCase(),
                          cCargo.text.toUpperCase());
                      OpenFilex.open(ruta);
                      //context.pushNamed('asignar_sala');
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Future<void> _mostrarDateRangePickerRUJ(context, ref) async {
    final DateTime now = DateTime.now();
    final DateTime lastAllowedDate = DateTime.now()
        .add(Duration(days: 365)); // Por ejemplo, un año a partir de ahora

    final selectedDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: now,
        end: now
            .add(Duration(days: 7)), // Por ejemplo, un rango de 7 días inicial
      ),
      firstDate: DateTime(1950),
      lastDate: lastAllowedDate,
    );

    if (selectedDateRange != null) {
      ref
          .read(selectedDateRangeProvider.notifier)
          .update((state) => selectedDateRange);
      // context.read(selectedDateRangeProvider).state = selectedDateRange;
    }
  }
}
