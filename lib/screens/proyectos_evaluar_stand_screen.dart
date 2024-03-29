import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/providers/providers.dart';

import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ProyectoEvaluarStandSreen extends ConsumerWidget {
  static const String name = 'ProyectoEvaluarStandSreen';
  ProyectoEvaluarStandSreen({super.key});

  List<EvaluacionProJuradoStand> proyectos = [];

  Future<void> getProyectosEvaluar(String idjur) async {
    String url =
        '${dotenv.env['HOST_REST']}get_evaluacionProJuradoStand.php?Id_jurado=$idjur';
    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        proyectos = evaluacionProJuradoStandFromJson(response.body);
      } else {
        //print('La solicitud no fue exitosa: ${response.statusCode}');
      }
    } catch (error) {
      //print('Error al realizar la solicitud: $error');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String juradoID = ref.watch(juradoIDProvider);
    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Evaluaciones Stand',
          fontSize: 20,
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Mis proyectos',
                  style: TextStyle(
                      color: AppTema.balticSea,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                  future: getProyectosEvaluar(juradoID),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                            child: Text('Error: ${snapshot.error.toString()}'));
                      } else {
                        return proyectos.isEmpty
                            ? const Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    'No tiene proyectos asignados',
                                    style: TextStyle(
                                        color: AppTema.bluegrey700,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              )
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: proyectos.length,
                                itemBuilder: (context, index) {
                                  return ElevatedButton(
                                    onPressed: proyectos[index]
                                                .estadoEvaluacion ==
                                            '1'
                                        ? null
                                        : () {
                                            // Acción a realizar cuando se presiona el botón
                                            List<EvaluacionProJuradoStand>
                                                proyecto = [proyectos[index]];
                                            ref
                                                .read(
                                                    proyectoDatosPESST.notifier)
                                                .update((state) => proyecto);
                                            context.pushNamed(
                                                'EvaluarStandScreen');
                                          },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 10,
                                      primary: AppTema
                                          .grey100, // Color de fondo del botón
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          bottom: 10,
                                          top: 10,
                                          left: 20,
                                          right: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        children: [
                                          // ... Resto del contenido ...
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: proyectos[index]
                                                          .estadoEvaluacion ==
                                                      '1'
                                                  ? Colors.green
                                                  : Colors.red,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15)),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Center(
                                              child: Text(
                                                proyectos[index]
                                                            .estadoEvaluacion ==
                                                        '1'
                                                    ? 'Evaluado'
                                                    : 'No evaluado',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                            height: 10),
                                                        Text(
                                                          proyectos[index]
                                                              .folio,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            color: AppTema
                                                                .bluegrey700,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                          ),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        const Text(
                                                          'Nombre descriptivo: ',
                                                          style: TextStyle(
                                                              color: AppTema
                                                                  .bluegrey700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        Text(
                                                          proyectos[index]
                                                              .nombreProyecto,
                                                          style: const TextStyle(
                                                              color: AppTema
                                                                  .bluegrey700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        const Text(
                                                          'Nombre corto: ',
                                                          style: TextStyle(
                                                              color: AppTema
                                                                  .bluegrey700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        Text(
                                                          proyectos[index]
                                                              .nombreCorto,
                                                          style: const TextStyle(
                                                              color: AppTema
                                                                  .bluegrey700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        const Text(
                                                          'Área: ',
                                                          style: TextStyle(
                                                              color: AppTema
                                                                  .bluegrey700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        Text(
                                                          proyectos[index]
                                                              .nombreArea,
                                                          style: const TextStyle(
                                                              color: AppTema
                                                                  .bluegrey700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        const Text(
                                                          'Categoría: ',
                                                          style: TextStyle(
                                                              color: AppTema
                                                                  .bluegrey700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        Text(
                                                          proyectos[index]
                                                              .nombreCategoria,
                                                          style: const TextStyle(
                                                              color: AppTema
                                                                  .bluegrey700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        const Text(
                                                          'Sala: ',
                                                          style: TextStyle(
                                                              color: AppTema
                                                                  .bluegrey700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        Text(
                                                          proyectos[index]
                                                              .nombreSala,
                                                          style: const TextStyle(
                                                              color: AppTema
                                                                  .bluegrey700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        const Text(
                                                          'Lugar: ',
                                                          style: TextStyle(
                                                              color: AppTema
                                                                  .bluegrey700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        Text(
                                                          proyectos[index]
                                                              .lugarSala,
                                                          style: const TextStyle(
                                                              color: AppTema
                                                                  .bluegrey700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        const Text(
                                                          'Hora inicio: ',
                                                          style: TextStyle(
                                                              color: AppTema
                                                                  .bluegrey700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        Text(
                                                          proyectos[index]
                                                              .horaInicioSala,
                                                          style: const TextStyle(
                                                              color: AppTema
                                                                  .bluegrey700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        const Text(
                                                          'Hora fin: ',
                                                          style: TextStyle(
                                                              color: AppTema
                                                                  .bluegrey700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        Text(
                                                          proyectos[index]
                                                              .horaFinalSala,
                                                          style: const TextStyle(
                                                              color: AppTema
                                                                  .bluegrey700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                      }
                    } else {
                      return const Center(child: Text('¡Algo salió mal!'));
                    }
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          )),
    );
  }
}
