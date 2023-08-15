import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

final mostrarInputProvider = StateProvider<bool>((ref) => false);
final selectedCarreraProvider = StateProvider<String>((ref) => '');
final TextEditingController _carreraController =
    TextEditingController(); // Agregamos

Future<List<Departamento>> obtenerDepartamentoAC() async {
  var url =
      'https://evarafael.com/Aplicacion/rest/get_departamento.php?Clave_tecnologico=TEC01';

  var response = await http.post(Uri.parse(url));
  if (response.statusCode == 200) {
    List<Departamento> departamentoAG = departamentoFromJson(response.body);
    return departamentoAG;
  } else {
    throw Exception(
        'No se pudo obtener el departamento. Código de estado: ${response.statusCode}');
  }
}

Future<List<Nivel>> obtenerNivelAC() async {
  var url = 'https://evarafael.com/Aplicacion/rest/get_nivel.php';

  var response = await http.post(Uri.parse(url));
  if (response.statusCode == 200) {
    List<Nivel> nivelAG = nivelFromJson(response.body);
    return nivelAG;
  } else {
    throw Exception(
        'No se pudo obtener el departamento. Código de estado: ${response.statusCode}');
  }
}

Future<bool> agregarCarrareAG(
    String idCarr, String nombreCarr, String idNivel, String idDep) async {
  var url = 'https://evarafael.com/Aplicacion/rest/agregar_carrera.php';
  // Reemplaza con la URL del archivo PHP en tu servidor
  try {
    var response = await http.post(Uri.parse(url), body: {
      'Id_carrera': 'CAR$idCarr',
      'Nombre_carrera': nombreCarr,
      'Id_nivel': idNivel,
      'Id_departamento': idDep
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

class AgregarCarreraScreen extends ConsumerWidget {
  static const String name = 'agregar_carrera';

  //List<Departamento> departamentos = [];

  final departamentoACProv = StateProvider<String>((ref) => 'SN');
  final futureDepartamentoAGProv =
      FutureProvider<List<Departamento>>((ref) => obtenerDepartamentoAC());

  final nivelACProv = StateProvider<String>((ref) => 'SN');
  final futureNivelAGProv =
      FutureProvider<List<Nivel>>((ref) => obtenerNivelAC());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carreras = ModeloTecnologicos().carrera;
    final mostrarInput = ref.watch(mostrarInputProvider);
    final selectedCarrera = ref.watch(selectedCarreraProvider);
    final departamentos = ref.watch(futureDepartamentoAGProv);
    final cDepartamento = ref.watch(departamentoACProv);

    final niveles = ref.watch(futureNivelAGProv);
    final cNivel = ref.watch(nivelACProv);

    return Scaffold(
      body: Fondo(
        fontSize: 20,
        tituloPantalla: 'Agregar carrera',
        widget: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                'Ingrese datos del estudiante',
                style: TextStyle(
                    color: AppTema.balticSea,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(height: 50),
              const Text(
                'Seleccione alguna opción o en su defecto seleccione: "Otra..."',
                style: TextStyle(
                  color: AppTema.bluegrey700,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
              Form(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    DropdownButtonFormField(
                      isExpanded: true,
                      style: const TextStyle(
                        color: AppTema.bluegrey700,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) {
                        ref
                            .read(selectedCarreraProvider.notifier)
                            .update((state) => value.toString());
                        ref
                            .read(mostrarInputProvider.notifier)
                            .update((state) => value == 'Otra...');
                      },
                      //value: selectedCarrera,
                      items: carreras.map((itemone) {
                        return DropdownMenuItem(
                          alignment: Alignment.centerLeft,
                          value: itemone,
                          child: Text(
                            itemone,
                            overflow: TextOverflow.visible,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 25),
                    if (mostrarInput)
                      TextFormField(
                        controller: _carreraController,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecorations.registroLiderDecoration(
                          hintText: 'Ingrese carrera',
                          labelText: 'Carrera',
                        ),
                      ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Departamento',
                        style: TextStyle(
                            color: AppTema.bluegrey700,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    departamentos.when(
                      data: (data) => DropdownButtonFormField<String>(
                          value: null,
                          isExpanded: true,
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
                            ref
                                .read(departamentoACProv.notifier)
                                .update((state) => value.toString());
                          }),
                      loading: () => const CircularProgressIndicator(),
                      error: (error, stackTrace) =>
                          const Text('Error al cargar los departamentos.'),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Nivel',
                        style: TextStyle(
                            color: AppTema.bluegrey700,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    niveles.when(
                      data: (data) => DropdownButtonFormField<String>(
                          value: null,
                          isExpanded: true,
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
                                .read(nivelACProv.notifier)
                                .update((state) => value.toString());
                          }),
                      loading: () => const CircularProgressIndicator(),
                      error: (error, stackTrace) =>
                          const Text('Error al cargar niveles.'),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(
                              color: AppTema.grey100,
                              fontSize: 25,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        ElevatedButton(
                          child: const Text(
                            'Guardar',
                            style: TextStyle(
                              color: AppTema.grey100,
                              fontSize: 25,
                            ),
                          ),
                          onPressed: () async {
                            String idCarr = Uuid().v4().substring(0, 8);
                            String carreraSeleccionada = selectedCarrera;
                            if (selectedCarrera == 'Otra...') {
                              carreraSeleccionada = _carreraController.text;
                            }
                            print('Carrera seleccionada: $carreraSeleccionada');
                            print(cNivel);
                            print(cDepartamento);
                            if (cNivel.isNotEmpty && cDepartamento.isNotEmpty) {
                              bool agregado = await agregarCarrareAG(idCarr,
                                  carreraSeleccionada, cNivel, cDepartamento);

                              if (agregado) {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.success,
                                  title: 'Agregado correctamente',
                                  confirmBtnText: 'Hecho',
                                  confirmBtnColor: AppTema.pizazz,
                                  onConfirmBtnTap: () {
                                    context.pushNamed('carrera');
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
                                title: 'Campos Vacios',
                                confirmBtnText: 'Hecho',
                                confirmBtnColor: AppTema.pizazz,
                              );
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
