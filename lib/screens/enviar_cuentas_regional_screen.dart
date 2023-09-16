import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/helpers/regexUtil.dart';
import 'package:innova_ito/models/personasRegional.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnviarCuentasRegionalScreen extends ConsumerWidget {
  static const String name = 'EnviarCuentasRegionalScreen';
  EnviarCuentasRegionalScreen({super.key});

  List<PersonasRegional> persona = [];
  Future<bool> getPersona(String correo) async {
    String url =
        '${dotenv.env['HOST_REST']}get_personaRegional.php?correo=$correo';

    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        persona = personasRegionalFromJson(response.body);
        return true;
      } else {
        // print('La solicitud no fue exitosa: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      return false;
      //print('Error al realizar la solicitud: $error');
    }
  }

  List<ProyectoAsesorWf> asesoWF = [];
  Future<bool> getAsesorWhere(String? idfol) async {
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
    final String? folioProv = ref.watch(folioProyectoUsuarioLogin);
    final listo = ref.watch(listoAsesor);
    return Scaffold(
        body: Fondo(
            tituloPantalla: 'Enviar cuentas',
            fontSize: 20,
            widget: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: FutureBuilder(
                  future: getAsesorWhere(folioProv),
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
                        return asesoWF.isEmpty
                            ? Column(
                                children: [
                                  const SizedBox(height: 50),
                                  const Text(
                                    'Búsqueda de estudiante',
                                    style: TextStyle(
                                        color: AppTema.bluegrey700,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: cRFCLider,
                                    style: const TextStyle(
                                        color: AppTema.bluegrey700,
                                        fontWeight: FontWeight.bold),
                                    autocorrect: false,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecorations
                                        .registroLiderDecoration(
                                      hintText: 'Ingrese correo del estudiante',
                                      labelText: 'Correo del estudiante',
                                    ),
                                    //onChanged: (value) => registroLider.nombre = value,
                                    validator: (value) {
                                      return RegexUtil.correo
                                              .hasMatch(value ?? '')
                                          ? null
                                          : 'Correo no válido.';
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          child: const Center(
                                            child: Text(
                                              'Borrar Correo',
                                              style: TextStyle(
                                                color: AppTema.grey100,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            //verAsesor();
                                            cRFCLider.text = '';
                                            ref
                                                .read(listoAsesor.notifier)
                                                .update((state) => false);
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                          child: const Center(
                                            child: Text(
                                              'Buscar',
                                              style: TextStyle(
                                                color: AppTema.grey100,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            //verAsesor();
                                            ref
                                                .read(listoAsesor.notifier)
                                                .update((state) =>
                                                    cRFCLider.text.isNotEmpty);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  //verAsesor(),

                                  const SizedBox(height: 50),

                                  listo
                                      ? Column(
                                          children: [
                                            const Text(
                                              'Para enviar su contraseña solo da clic sobre él',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: AppTema.bluegrey700,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            const SizedBox(height: 20),
                                            verAsesor(cRFCLider.text,
                                                folioProv.toString()),
                                            const SizedBox(height: 20),
                                          ],
                                        )
                                      : const Text(
                                          'No has ingresado ningún correo electrónico',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: AppTema.bluegrey700,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 18),
                                        ),
                                ],
                              )
                            : const Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Center(
                                    child: Text(
                                      'Ya has seleccionado tu asesor',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          color: AppTema.bluegrey700,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                              );
                      }
                    } else {
                      return const Center(child: Text('¡Algo salió mal!'));
                    }
                  },
                ))));
  }

  FutureBuilder<bool> verAsesor(String correo, String folioProyecto) {
    //cRFC.dispose();
    return FutureBuilder(
      future: getPersona(correo),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          } else {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: persona.length,
              itemBuilder: (context, index) {
                //int valor = index + 1;
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    MaterialButton(
                        splashColor: AppTema.pizazz,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 35,
                        elevation: 15.0,
                        color: AppTema.grey100,
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              persona[index].nombrePersona +
                                  ' ' +
                                  persona[index].apellido1 +
                                  ' ' +
                                  persona[index].apellido2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: AppTema.bluegrey700, fontSize: 18.0),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              'Correo electrónico: ${persona[index].correoElectronico}',
                              style: const TextStyle(
                                  color: AppTema.bluegrey700, fontSize: 15.0),
                            ),
                          ],
                        ),
                        onPressed: () async {}),
                  ],
                );
              },
            );
          }
        } else {
          return const Center(child: Text('¡Algo salió mal!'));
        }
      },
    );
  }
}
