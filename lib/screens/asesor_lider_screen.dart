import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/helpers/regexUtil.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/tarjeta_requerimientos.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AsesorLiderScreen extends ConsumerWidget {
  static const String name = 'asesor_lider';
  AsesorLiderScreen({super.key});

  List<Requerimientos> requerimientos = [];

  List<DatosAsesor> asesores = [];
  Future<bool> getAsesor(String rfc) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/get_asesorWhere.php?RFC=$rfc';

    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        asesores = datosAsesorFromJson(response.body);
        return true;
      } else {
        print('La solicitud no fue exitosa: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      return false;
      print('Error al realizar la solicitud: $error');
    }
  }

  Future<bool> agregarAsesorLider(String foliop, String asesor) async {
    var url =
        'https://evarafael.com/Aplicacion/rest/agregar_asesorProyecto.php'; // Reemplaza con la URL del archivo PHP en tu servidor
    var response = await http.post(Uri.parse(url), body: {
      'Folio': foliop,
      'Id_asesor': asesor,
    });
    if (response.statusCode == 200) {
      print('Modificado en la db');
      return true;
    } else {
      print('No modificado');
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
          tituloPantalla: 'Agregar asesor',
          fontSize: 20,
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Búsqueda de asesor',
                  style: TextStyle(
                      color: AppTema.balticSea,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: cRFCLider,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese RFC del asesor',
                    labelText: 'RFC del asesor',
                  ),
                  //onChanged: (value) => registroLider.nombre = value,
                  validator: (value) {
                    return RegexUtil.rfc.hasMatch(value ?? '')
                        ? null
                        : 'RFC no valido.';
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    child: const Center(
                        //height: 50,
                        child: Text(
                      'Buscar asesor',
                      style: TextStyle(color: AppTema.grey100, fontSize: 25),
                    )),
                    onPressed: () async {
                      print(cRFCLider.text);
                      //verAsesor();
                      if (cRFCLider.text.isNotEmpty) {
                        ref.read(listoAsesor.notifier).update((state) => true);
                      } else {
                        ref.read(listoAsesor.notifier).update((state) => false);
                      }
                    }),
                //verAsesor(),

                const SizedBox(height: 50),

                listo
                    ? Column(
                        children: [
                          const Text(
                            'Para agregar al asesor solo da clic sobre el',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppTema.balticSea,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          const SizedBox(height: 20),
                          verAsesor(cRFCLider.text),
                        ],
                      )
                    : const Text(
                        'No has ingresado ningún RFC',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: AppTema.balticSea,
                            fontWeight: FontWeight.normal,
                            fontSize: 18),
                      ),
              ],
            ),
          )),
    );
  }

  FutureBuilder<bool> verAsesor(String rfc) {
    //cRFC.dispose();
    return FutureBuilder(
      future: getAsesor(rfc),
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
              itemCount: asesores.length,
              itemBuilder: (context, index) {
                int valor = index + 1;
                return MaterialButton(
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
                          asesores[index].abreviaturaProfesional +
                              ' ' +
                              asesores[index].nombrePersona +
                              ' ' +
                              asesores[index].apellido1 +
                              ' ' +
                              asesores[index].apellido2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: AppTema.bluegrey700, fontSize: 18.0),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Tecnologico: ${asesores[index].nombreTecnologico}',
                          style: const TextStyle(
                              color: AppTema.bluegrey700, fontSize: 15.0),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Departamento: ${asesores[index].nombreDepartamento}',
                          style: const TextStyle(
                              color: AppTema.bluegrey700, fontSize: 15.0),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'RFC: ${asesores[index].rfc}',
                          style: const TextStyle(
                              color: AppTema.bluegrey700, fontSize: 15.0),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Telefono: ${asesores[index].telefono}',
                          style: const TextStyle(
                              color: AppTema.bluegrey700, fontSize: 15.0),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      bool asesorAgregado = await agregarAsesorLider(
                          'PRO2716', asesores[index].idAsesor);

                      if (asesorAgregado) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          title: 'Requerimiento agregado',
                          confirmBtnText: 'Hecho',
                          confirmBtnColor: AppTema.pizazz,
                          onConfirmBtnTap: () {
                            context.pushReplacementNamed('asesor_lider');
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
                            context.pushReplacementNamed('asesor_lider');
                          },
                        );
                      }
                    });
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
