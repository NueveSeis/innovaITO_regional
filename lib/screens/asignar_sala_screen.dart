import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/helpers/helpers.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

final proyectoASProv = StateProvider<String>((ref) => 'SN');
final futureProyectosASProv =
    FutureProvider<List<AsignacionProyecto>>((ref) => getProyectosAS());

final salaASProv = StateProvider<String>((ref) => 'SN');
final futureSalaASProv = FutureProvider<List<Sala>>((ref) => getSalaAS());

final fechaSeleccionadaASProv = StateProvider<DateTime?>((ref) => null);

Future<List<AsignacionProyecto>> getProyectosAS() async {
  var url = 'https://evarafael.com/Aplicacion/rest/get_proyecto.php';
  var response = await http.get(Uri.parse(url));
  List<AsignacionProyecto> lista = asignacionProyectoFromJson(response.body);
  return lista;
}

Future<List<Sala>> getSalaAS() async {
  var url = 'https://evarafael.com/Aplicacion/rest/get_sala.php';
  var response = await http.get(Uri.parse(url));
  List<Sala> lista = salaFromJson(response.body);
  return lista;
}

Future<bool> agregarHSala(
  String idSala,
  String folioHS,
  String fechaHS,
  String hIncio,
  String hFin,
) async {
  var url = 'https://evarafael.com/Aplicacion/rest/agregar_asignarHSala.php';
  // Reemplaza con la URL del archivo PHP en tu servidor
  try {
    var response = await http.post(Uri.parse(url), body: {
      'Id_sala': idSala,
      'Folio': folioHS,
      'Fecha': fechaHS,
      'Hora_inicio': hIncio,
      'Hora_final': hFin
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

class AsignarSalaScreen extends ConsumerWidget {
  static const String name = 'asignar_sala';
  AsignarSalaScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController cNombreRubrica = TextEditingController();
  TextEditingController cNumeroCriterios = TextEditingController();

  DateTime? fechaSeleccionada;
  DateTime fecha = DateTime(0000, 00, 00);
  DateTime? horaIni;
  DateTime? horaFin;

  Future _mostrarDatePicker(context, ref) async {
    final seleccion = await showDatePicker(
      context: context,
      locale: const Locale("es", "ES"),
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
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

      ref.read(fechaSeleccionadaASProv.notifier).update((state) => fecha);
    }
  }

  TextEditingController cHoraInicio = TextEditingController();
  TextEditingController cHoraFinal = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeState = ref.read(timeProvider);
    final proyectos = ref.watch(futureProyectosASProv);
    final salas = ref.watch(futureSalaASProv);
    final cProyecto = ref.watch(proyectoASProv);
    final cSala = ref.watch(salaASProv);
    final fechas = ref.watch(fechaSeleccionadaASProv);

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
                SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Seleccione el proyecto',
                          style: TextStyle(
                              color: AppTema.bluegrey700,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      proyectos.when(
                        data: (data) => DropdownButtonFormField<String>(
                            value: null,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
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
                              ref
                                  .read(proyectoASProv.notifier)
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
                          'Seleccione la sala',
                          style: TextStyle(
                              color: AppTema.bluegrey700,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      salas.when(
                        data: (data) => DropdownButtonFormField<String>(
                            value: null,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            items: data.map((itemone) {
                              return DropdownMenuItem<String>(
                                alignment: Alignment.centerLeft,
                                value: itemone.idSala,
                                child: Text(
                                  itemone.nombreSala,
                                  overflow: TextOverflow.visible,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              ref
                                  .read(salaASProv.notifier)
                                  .update((state) => value.toString());
                            }),
                        loading: () => const CircularProgressIndicator(),
                        error: (error, stackTrace) => const Text(
                            'Error al cargar los niveles academicos.'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        child: Text(
                          fechaSeleccionada != null
                              ? 'Fecha seleccionada: ${DateFormat('yyyy-MM-dd').format(fecha)}'
                              : 'Seleccione fecha',
                        ),
                        onPressed: fechaSeleccionada != null
                            ? null
                            : () => _mostrarDatePicker(context, ref),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Seleccione hora de incio:',
                          style: TextStyle(
                              color: AppTema.bluegrey700,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TimePickerSpinner(
                        is24HourMode: true,
                        normalTextStyle:
                            TextStyle(fontSize: 24, color: AppTema.bluegrey700),
                        highlightedTextStyle:
                            TextStyle(fontSize: 30, color: AppTema.pizazz),
                        spacing: 50,
                        itemHeight: 40,
                        isForce2Digits: true,
                        onTimeChange: (time) {
                          // ref.read(timeProvider.notifier).updateStartTime(time);

                          //ref.read(timeProvider.notifier).updateStartTime(time);
                          horaIni = time;
                        },
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Seleccione hora final:',
                          style: TextStyle(
                              color: AppTema.bluegrey700,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TimePickerSpinner(
                        is24HourMode: true,
                        normalTextStyle:
                            TextStyle(fontSize: 24, color: AppTema.bluegrey700),
                        highlightedTextStyle:
                            TextStyle(fontSize: 30, color: AppTema.pizazz),
                        spacing: 50,
                        itemHeight: 40,
                        isForce2Digits: true,
                        onTimeChange: (time) {
                          // ref.read(timeProvider.notifier).updateEndTime(time);
                          horaFin = time;
                        },
                      ),
                      const SizedBox(height: 40),
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
                            style:
                                TextStyle(color: AppTema.grey100, fontSize: 25),
                          )),
                          onPressed: () async {
                            if (cSala == 'SN' || cProyecto == 'SN') {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.warning,
                                title: 'Seleccione sala y proyecto',
                                confirmBtnText: 'Hecho',
                                confirmBtnColor: AppTema.pizazz,
                              );
                            } else {
                              if (fecha != DateTime(0000, 00, 00)) {
                                final startHour =
                                    horaIni!.hour.toString().padLeft(2, '0');
                                final startMinute =
                                    horaIni!.minute.toString().padLeft(2, '0');
                                final endHour =
                                    horaFin!.hour.toString().padLeft(2, '0');
                                final endMinute =
                                    horaFin!.minute.toString().padLeft(2, '0');

                                print(cSala);
                                print(cProyecto);
                                print(DateFormat('yyyy-MM-dd').format(fecha));
                                print(
                                    "Hora de inicio: $startHour:$startMinute");
                                print("Hora de inicio: $endHour:$endMinute");

                                bool agregada = await agregarHSala(
                                    cSala,
                                    cProyecto,
                                    DateFormat('yyyy-MM-dd').format(fecha),
                                    "$startHour:$startMinute",
                                    "$endHour:$endMinute");
                                if (agregada) {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.success,
                                    title: 'Agregado correctamente',
                                    confirmBtnText: 'Hecho',
                                    confirmBtnColor: AppTema.pizazz,
                                    onConfirmBtnTap: () {
                                      context
                                          .pushReplacementNamed('asignar_sala');
                                    },
                                  );
                                } else {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.error,
                                    title: 'Ocurrio un error',
                                    confirmBtnText: 'Hecho',
                                    confirmBtnColor: AppTema.pizazz,
                                    onConfirmBtnTap: () {
                                      context.pop();
                                    },
                                  );
                                }
                              } else {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.warning,
                                  title: 'Fecha vacia',
                                  confirmBtnText: 'Hecho',
                                  confirmBtnColor: AppTema.pizazz,
                                );
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}