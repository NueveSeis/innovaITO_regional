import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innova_ito/models/datosEstudianteRegional.dart';
import 'package:innova_ito/models/proyectoAsesorGC.dart';
import 'package:innova_ito/models/proyectoGC.dart';
import 'package:innova_ito/providers/providers.dart';

import 'package:innova_ito/theme/app_tema.dart';

import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:innova_ito/helpers/helpers.dart';

import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

final selectedDateRangeProvider = StateProvider<DateTimeRange?>((ref) => null);
final valueAProvGC = StateProvider((ref) => null);
final valueEProvGC = StateProvider<String>((ref) => '');

class GeneracionConstanciaScreen extends ConsumerWidget {
  static const String name = 'GeneracionConstanciaScreen';
  GeneracionConstanciaScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController cdirector =
      TextEditingController(text: 'M.E. Fernando Toledo Toledo');
  TextEditingController cCoo =
      TextEditingController(text: 'M.I. Raquel López Celis');
  TextEditingController cCargo = TextEditingController(
      text: 'Jefa del Depto. de Gestión Tecnológica y Vinculación');

  String nombreTecnologicoConstancia = '';
  String nombreProyectoConstancia = '';
  String nombreProyectoCortoConstancia = '';
  String nombreParticipanteConst = '';
  String nombreCategoriaConstancia = '';

  final switchEstudianteProvider = StateProvider<bool>((ref) => true);
  final switchAsesorProvider = StateProvider<bool>((ref) => false);

  final switchIndividualProvider = StateProvider<bool>((ref) => true);
  final switchPorProyectoProvider = StateProvider<bool>((ref) => false);
  final switchTodosProvider = StateProvider<bool>((ref) => false);

  bool camposLlenos = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDateRange = ref.watch(selectedDateRangeProvider);
    final tecnologicos = ref.watch(futureTecnologicoProvGC);
    final proyectosGC = ref.watch(futureProyectosProvGC);
    final participantes = ref.watch(futureParticipantesProvGC);
    final asesores = ref.watch(futureAsesoresProvGC);
    final nombreCoordinador = ref.watch(nombreUsuarioLogin);
    final va = ref.watch(valueAProvGC);
    final ve = ref.watch(valueEProvGC);

    final isActiveEstudiante = ref.watch(switchEstudianteProvider);
    final isActiveAsesor = ref.watch(switchAsesorProvider);
    final isActiveIndividual = ref.watch(switchIndividualProvider);
    final isActivePorProyecto = ref.watch(switchPorProyectoProvider);
    final isActiveTodos = ref.watch(switchTodosProvider);

    String _director = 'M.E. Fernando Toledo Toledo';
    String _nombreEncargado = 'M.I. Raquel López Celis';
    String _puestoEncargada =
        'Jefa del Depto. de Gestión Tecnológica y Vinculación';

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
                                //value: 'Instituto Tecnológico de Oaxaca',
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
                            onChanged: (value) {
                              // Actualiza el valor cuando se modifica el texto.
                              _director = value;
                            },
                            validator: (value) {
                              return (!RegexUtil.nombres.hasMatch(value ?? ''))
                                  ? null
                                  : 'Nombre no válido.';
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
                                  : 'Nombre no válido.';
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
                                  : 'Cargo no válido.';
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Seleccione la forma de generación',
                              style: TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SwitchListTile.adaptive(
                              title: const Text('Individual'),
                              activeColor: AppTema.pizazz,
                              value: isActiveIndividual,
                              onChanged: (value) {
                                ref
                                    .read(switchIndividualProvider.notifier)
                                    .update((state) => value);
                                ref
                                    .read(switchPorProyectoProvider.notifier)
                                    .update((state) => !value);
                                ref
                                    .read(switchTodosProvider.notifier)
                                    .update((state) => !value);
                              }),
                          const SizedBox(height: 10),
                          SwitchListTile.adaptive(
                              title: const Text('Por Proyecto'),
                              activeColor: AppTema.pizazz,
                              value: isActivePorProyecto,
                              onChanged: (value) {
                                ref
                                    .read(switchIndividualProvider.notifier)
                                    .update((state) => !value);
                                ref
                                    .read(switchTodosProvider.notifier)
                                    .update((state) => !value);
                                ref
                                    .read(switchPorProyectoProvider.notifier)
                                    .update((state) => value);
                              }),
                          const SizedBox(height: 10),
                          SwitchListTile.adaptive(
                              title: const Text('Todos'),
                              activeColor: AppTema.pizazz,
                              value: isActiveTodos,
                              onChanged: (value) {
                                ref
                                    .read(switchPorProyectoProvider.notifier)
                                    .update((state) => !value);
                                ref
                                    .read(switchIndividualProvider.notifier)
                                    .update((state) => !value);
                                ref
                                    .read(switchTodosProvider.notifier)
                                    .update((state) => value);
                              }),
                          if (isActiveIndividual)
                            individual(proyectosGC, ref, isActiveEstudiante,
                                isActiveAsesor, participantes, asesores),
                          if (isActivePorProyecto)
                            porProyecto(
                                proyectosGC, ref, participantes, asesores),
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
//nombreParticipanteConst.isEmpty ||
                      if (camposLlenos == false ||
                          selectedDateRange == null ||
                          nombreTecnologicoConstancia.isEmpty ||
                          nombreProyectoConstancia.isEmpty ||
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
                        // print(
                        //String ruta = '';
                        //     'Día de inicio: ${DateFormat.d().format(selectedDateRange?.start ?? DateTime.now())}');

                        if (isActiveIndividual) {
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

                        if (isActivePorProyecto) {
                          List<String> nombresCompletos = [];

                          participantes.when(
                            data: (data) {
                              for (var estudiante in data) {
                                String nombreCompleto =
                                    '${estudiante.nombrePersona} ${estudiante.apellido1} ${estudiante.apellido2}';
                                nombresCompletos.add(nombreCompleto);
                              }
                            },
                            loading: () {
                              // Puedes manejar el estado de carga aquí si es necesario
                            },
                            error: (error, stackTrace) {
                              // Puedes manejar el estado de error aquí si es necesario
                            },
                          );
                          asesores.when(
                            data: (data) {
                              for (var estudiante in data) {
                                String nombreCompleto =
                                    '${estudiante.nombrePersona} ${estudiante.apellido1} ${estudiante.apellido2}';
                                nombresCompletos.add(nombreCompleto);
                              }
                            },
                            loading: () {
                              // Puedes manejar el estado de carga aquí si es necesario
                            },
                            error: (error, stackTrace) {
                              // Puedes manejar el estado de error aquí si es necesario
                            },
                          );

                          String ruta = await pdf.constanciasPorEquipo(
                              nombreProyectoCortoConstancia,
                              nombresCompletos,
                              nombreTecnologicoConstancia.toUpperCase(),
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
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Column porProyecto(
      AsyncValue<List<ProyectoGc>> proyectosGC,
      WidgetRef ref,
      AsyncValue<List<DatosEstudianteRegional>> participantes,
      AsyncValue<List<ProyectoAsesorGc>> asesores) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: const Text(
            'Seleccione proyecto',
            style: TextStyle(
                color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        proyectosGC.when(
          data: (data) => DropdownButtonFormField<String>(
              hint: const Text(
                'Seleccione una opción',
                overflow: TextOverflow.visible,
                style: TextStyle(
                    color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              isExpanded: true,
              value: null,
              style: const TextStyle(
                  color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
              items: data.map((itemone) {
                return DropdownMenuItem<String>(
                  alignment: Alignment.centerLeft,
                  value: itemone.folio,
                  child: Text(
                    itemone.nombreCorto,
                    overflow: TextOverflow.visible,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                // Buscar el proyecto seleccionado en la lista de 'data'
                final selectedProject =
                    data.firstWhere((itemone) => itemone.folio == value);

                // Obtener el nombre del proyecto y el folio del elemento seleccionado
                nombreProyectoCortoConstancia = selectedProject.nombreCorto;

                nombreProyectoConstancia = selectedProject.nombreProyecto;

                print(selectedProject.nombreProyecto);

                nombreCategoriaConstancia = selectedProject.nombreCategoria;

                print(selectedProject.nombreCategoria);

                ref
                    .read(proyectosProvGC.notifier)
                    .update((state) => value.toString());
                print(value.toString());
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
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Column individual(
      AsyncValue<List<ProyectoGc>> proyectosGC,
      WidgetRef ref,
      bool isActiveEstudiante,
      bool isActiveAsesor,
      AsyncValue<List<DatosEstudianteRegional>> participantes,
      AsyncValue<List<ProyectoAsesorGc>> asesores) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: const Text(
            'Seleccione proyecto',
            style: TextStyle(
                color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        proyectosGC.when(
          data: (data) => DropdownButtonFormField<String>(
              hint: const Text(
                'Seleccione una opción',
                overflow: TextOverflow.visible,
                style: TextStyle(
                    color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              isExpanded: true,
              value: null,
              style: const TextStyle(
                  color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
              items: data.map((itemone) {
                return DropdownMenuItem<String>(
                  alignment: Alignment.centerLeft,
                  value: itemone.folio,
                  child: Text(
                    itemone.nombreCorto,
                    overflow: TextOverflow.visible,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                // Buscar el proyecto seleccionado en la lista de 'data'
                final selectedProject =
                    data.firstWhere((itemone) => itemone.folio == value);

                // Obtener el nombre del proyecto y el folio del elemento seleccionado
                nombreProyectoCortoConstancia = selectedProject.nombreCorto;

                nombreProyectoConstancia = selectedProject.nombreProyecto;

                print(selectedProject.nombreProyecto);

                nombreCategoriaConstancia = selectedProject.nombreCategoria;

                print(selectedProject.nombreCategoria);

                ref
                    .read(proyectosProvGC.notifier)
                    .update((state) => value.toString());
                print(value.toString());
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
              ref.read(switchAsesorProvider.notifier).update((state) => !value);
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
              ref.read(switchAsesorProvider.notifier).update((state) => value);
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
                    data: (data) => DropdownButtonFormField<String>(
                        key: const Key("dropdown_1"),
                        hint: const Text(
                          'Seleccione una opción',
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              color: AppTema.bluegrey700,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        isExpanded: true,
                        //value: va.value,
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
                        onChanged: (valueE) {
                          nombreParticipanteConst = valueE.toString();
                          // print(valueE);
                          ref
                              .read(valueAProvGC.notifier)
                              .update((state) => null);
                          // ref.refresh(futureDepartamentoProv);
                        }),
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stackTrace) =>
                        const Text('Error al cargar los participantes.'),
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
                    data: (data) => DropdownButtonFormField<String>(
                        key: const Key("dropdown_2"),
                        hint: const Text(
                          'Seleccione una opción',
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              color: AppTema.bluegrey700,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        isExpanded: true,
                        // value: va.value,
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
                        onChanged: (valueA) {
                          nombreParticipanteConst = valueA.toString();
                          // print(value);
                          ref
                              .read(valueAProvGC.notifier)
                              .update((state) => null);
                          // ref.refresh(futureDepartamentoProv);
                        }),
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stackTrace) =>
                        const Text('Error al cargar los participantes.'),
                  )
                ],
              ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Future<void> _mostrarDateRangePickerRUJ(context, ref) async {
    final DateTime now = DateTime.now();
    final DateTime lastAllowedDate = DateTime.now().add(
        const Duration(days: 365)); // Por ejemplo, un año a partir de ahora

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
