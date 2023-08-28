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

  String nombreTecnologicoConstancia = '';
  String nombreProyectoConstancia = '';
  String nombreParticipanteConst = '';
  String nombreCategoriaConstancia = '';

  final switchEstudianteProvider = StateProvider<bool>((ref) => true);
  final switchAsesorProvider = StateProvider<bool>((ref) => false);

  bool camposLlenos = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDateRange = ref.watch(selectedDateRangeProvider);
    final tecnologicos = ref.watch(futureTecnologicoProvGC);
    final proyectosGC = ref.watch(futureProyectosProvGC);
    final participantes = ref.watch(futureParticipantesProvGC);
    final asesores = ref.watch(futureAsesoresProvGC);
    final nombreCoordinador = ref.watch(nombreUsuarioLogin);

    final isActiveEstudiante = ref.watch(switchEstudianteProvider);
    final isActiveAsesor = ref.watch(switchAsesorProvider);

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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: cdirector,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese nombre completo del director',
                              labelText: 'Nombre completo del director',
                            ),
                            validator: (value) {
                              return (!RegexUtil.nombres.hasMatch(value ?? ''))
                                  ? null
                                  : 'Nombre no valido.';
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: cCoo,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese nombre del encargado',
                              labelText: 'Nombre del encargado',
                            ),
                            validator: (value) {
                              return (!RegexUtil.nombres.hasMatch(value ?? ''))
                                  ? null
                                  : 'Nombre no valido.';
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: cCargo,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese cargo del encargado',
                              labelText: 'Cargo del encargado',
                            ),
                            validator: (value) {
                              return (!RegexUtil.datos.hasMatch(value ?? ''))
                                  ? null
                                  : 'Cargo no valido.';
                            },
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
                                  ref.refresh(futureAsesoresProvGC);
                                }),
                            loading: () => const CircularProgressIndicator(),
                            error: (error, stackTrace) =>
                                const Text('Error al cargar los proyectos.'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SwitchListTile.adaptive(
                              title: const Text('Estudiante'),
                              activeColor: AppTema.pizazz,
                              value: isActiveEstudiante,
                              onChanged: (value) {
                                ref
                                    .read(switchEstudianteProvider.notifier)
                                    .update((state) => value);
                                ref
                                    .read(switchAsesorProvider.notifier)
                                    .update((state) => !value);
                              }),
                          const SizedBox(height: 10),
                          SwitchListTile.adaptive(
                              title: const Text('Asesor'),
                              activeColor: AppTema.pizazz,
                              value: isActiveAsesor,
                              onChanged: (value) {
                                ref
                                    .read(switchEstudianteProvider.notifier)
                                    .update((state) => !value);
                                ref
                                    .read(switchAsesorProvider.notifier)
                                    .update((state) => value);
                              }),
                          isActiveEstudiante
                              ? Column(
                                  children: [
                                    const SizedBox(height: 20),
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
                                      data: (data) => DropdownButtonFormField<
                                              String>(
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
                                            nombreParticipanteConst =
                                                value.toString();
                                            print(value);
                                            ref
                                                .read(participantesProvGC
                                                    .notifier)
                                                .update((state) =>
                                                    value.toString());
                                            // ref.refresh(futureDepartamentoProv);
                                          }),
                                      loading: () =>
                                          const CircularProgressIndicator(),
                                      error: (error, stackTrace) => const Text(
                                          'Error al cargar los asesores.'),
                                    )
                                  ],
                                )
                              : Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: const Text(
                                        'Seleccione Asesor',
                                        style: TextStyle(
                                            color: AppTema.bluegrey700,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    asesores.when(
                                      data: (data) => DropdownButtonFormField<
                                              String>(
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
                                            nombreParticipanteConst =
                                                value.toString();
                                            print(value);
                                            ref
                                                .read(asesoresProvGC.notifier)
                                                .update((state) =>
                                                    value.toString());
                                            // ref.refresh(futureDepartamentoProv);
                                          }),
                                      loading: () =>
                                          const CircularProgressIndicator(),
                                      error: (error, stackTrace) => const Text(
                                          'Error al cargar los participantes.'),
                                    )
                                  ],
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
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Fecha inicio: ${selectedDateRange?.start != null ? DateFormat.yMd().format(selectedDateRange!.start) : "Ninguna"}',
                      style: const TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Fecha fin: ${selectedDateRange?.end != null ? DateFormat.yMd().format(selectedDateRange!.end) : "Ninguna"}',
                      style: const TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
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
                      camposLlenos = _formKey.currentState!.validate();

                      if (camposLlenos == false ||
                          selectedDateRange == null ||
                          nombreTecnologicoConstancia.isEmpty ||
                          nombreProyectoConstancia.isEmpty ||
                          nombreParticipanteConst.isEmpty ||
                          nombreCategoriaConstancia.isEmpty) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.warning,
                          title: 'Cuidado',
                          text: 'Rellena los campos faltantes',
                          confirmBtnText: 'Hecho',
                          confirmBtnColor: AppTema.pizazz,
                        );
                      } else {
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
                      }
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
        start: now.subtract(const Duration(days: 5)),
        end: now, // Por ejemplo, un rango de 7 días inicial
      ),
      firstDate: DateTime(now.year),
      lastDate: lastAllowedDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTema.pizazz,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  primary: AppTema.primario // button text color
                  ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDateRange != null) {
      ref
          .read(selectedDateRangeProvider.notifier)
          .update((state) => selectedDateRange);
      // context.read(selectedDateRangeProvider).state = selectedDateRange;
    }
  }
}
