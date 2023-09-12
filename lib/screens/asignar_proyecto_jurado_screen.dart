import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:innova_ito/models/proyectosJuradoASJS.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/widgets/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AsignarProyectoJuradoScreen extends ConsumerWidget {
  static const String name = 'AsignarProyectoJuradoScreen';
  AsignarProyectoJuradoScreen({super.key});

  List<ProyectosJuradoAsjs> jurados = [];
  Future<bool> getJurados() async {
    String url = '${dotenv.env['HOST_REST']}get_JuradoNumPro.php';

    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        jurados = proyectosJuradoAsjsFromJson(response.body);
        return true;
      } else {
        //print('La solicitud no fue exitosa: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      return false;
      //print('Error al realizar la solicitud: $error');
    }
  }

  List<ProyectoAsesorWf> asesoWF = [];
  Future<bool> getAsesorWhere(String idfol) async {
    String url =
        '${dotenv.env['HOST_REST']}get_proyectoAsesorWhere.php?Folio=$idfol';

    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        asesoWF = proyectoAsesorWfFromJson(response.body);
        return true;
      } else {
        //print('La solicitud no fue exitosa: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      return false;
      //print('Error al realizar la solicitud: $error');
    }
  }

  Future<bool> agregarAsesorLider(String foliop, String asesor) async {
    var url =
        '${dotenv.env['HOST_REST']}agregar_asesorProyecto.php'; // Reemplaza con la URL del archivo PHP en tu servidor
    var response = await http.post(Uri.parse(url), body: {
      'Folio': foliop,
      'Id_asesor': asesor,
    });
    if (response.statusCode == 200) {
      //print('Modificado en la db');
      return true;
    } else {
      //print('No modificado');
      return false;
    }
  }

  final listoAsesor = StateProvider(
    (ref) => false,
  );
  TextEditingController cRFCLider = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listo = ref.watch(listoAsesor);
    return Scaffold(
        body: Fondo(
            tituloPantalla: 'Jueces',
            fontSize: 20,
            widget: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    const Text(
                      'Lista de jueces',
                      style: TextStyle(
                          color: AppTema.balticSea,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    const SizedBox(height: 30),
                    FutureBuilder(
                        future: getJurados(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text(
                                      'Error: ${snapshot.error.toString()}'));
                            } else {
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: jurados.length,
                                itemBuilder: (context, index) {
                                  //int valor = index + 1;
                                  return Column(
                                    children: [
                                      MaterialButton(
                                        splashColor: AppTema.pizazz,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        height: 35,
                                        elevation: 15.0,
                                        color: AppTema.grey100,
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              jurados[index].nombrePersona +
                                                  ' ' +
                                                  jurados[index].apellido1 +
                                                  ' ' +
                                                  jurados[index].apellido2,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: AppTema.bluegrey700,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            const SizedBox(height: 10.0),
                                            Text(
                                              'RFC: ${jurados[index].rfc}',
                                              style: const TextStyle(
                                                color: AppTema.bluegrey700,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            const SizedBox(height: 4.0),
                                            Text(
                                              'Correo electronico: ${jurados[index].correoElectronico}',
                                              style: const TextStyle(
                                                color: AppTema.bluegrey700,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            const SizedBox(height: 4.0),
                                            Text(
                                              'Teléfono: ${jurados[index].telefono}',
                                              style: const TextStyle(
                                                color: AppTema.bluegrey700,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            const SizedBox(height: 4.0),
                                            Text(
                                              'Categoría:  ${jurados[index].nombreCategoria ?? 'No seleccionado por el juez'}',
                                              style: const TextStyle(
                                                color: AppTema.bluegrey700,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            const SizedBox(height: 4.0),
                                            Text(
                                              'Área: ${jurados[index].nombreArea ?? 'No seleccionado por el juez'}',
                                              style: const TextStyle(
                                                color: AppTema.bluegrey700,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            const SizedBox(height: 4.0),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Proyectos asignados: ',
                                                  style: TextStyle(
                                                    color: AppTema.bluegrey700,
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: (int.parse(jurados[
                                                                    index]
                                                                .cantidadProyectos) >=
                                                            1)
                                                        ? AppTema.greenS400
                                                        : AppTema.redA400,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Text(
                                                    jurados[index]
                                                        .cantidadProyectos
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        onPressed: () async {
                                          // Resto del código
                                          List<ProyectosJuradoAsjs>
                                              juradoSeleccionado = [
                                            jurados[index]
                                          ];
                                          //  print(jurados[index].)
                                          ref
                                              .read(juradoDatosSL.notifier)
                                              .update((state) =>
                                                  juradoSeleccionado);
                                          context.pushNamed(
                                              'SeleccionaProyectoJuradoScreen');
                                        },
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      )
                                    ],
                                  );
                                },
                              );
                            }
                          } else {
                            return const Center(
                                child: Text('¡Algo salió mal!'));
                          }
                        }),
                  ],
                ))));
  }
}
