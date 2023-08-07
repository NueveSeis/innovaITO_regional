import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class TarjetaParticipante extends StatelessWidget {
  //final String nombreCarrera;
  final String idParticipante;
  final String nombre;
  final String control;
  final int numero;
  final String semestre;
  final String carrera;
  final String folio;

  const TarjetaParticipante({
    super.key,
    required this.nombre,
    required this.control,
    required this.numero,
    required this.semestre,
    required this.carrera,
    required this.folio,
    required this.idParticipante,
  });

  Future<void> eliminarParticipante(
      String matricula, String folio, String id, BuildContext context) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/delete_proyectoParticipante.php?matricula=$matricula&folio=$folio&id_persona=$id';
    var response = await http.delete(Uri.parse(url));
    if (response.statusCode == 200) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Eliminado correctamente',
        text: 'El participante fue eliminado correctamente.',
        confirmBtnText: 'Hecho',
        confirmBtnColor: AppTema.pizazz,
        onConfirmBtnTap: () {
          context.pushReplacementNamed('participantes');
        },
      );
    } else {
      print('nisiquiera carga');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 10,
          top: 10,
          left: 20,
          right: 20,
        ),
        decoration: BoxDecoration(
          color: AppTema.grey100,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  numero.toString(),
                  style: const TextStyle(
                      color: AppTema.bluegrey700,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  overflow: TextOverflow.visible,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      //isExpanded: true,
                      //width: double.infinity,
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nombre,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            overflow: TextOverflow.visible,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            control,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                            overflow: TextOverflow.visible,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Semestre $semestre',
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.normal,
                                fontSize: 13),
                            overflow: TextOverflow.visible,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            carrera,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.normal,
                                fontSize: 13),
                            overflow: TextOverflow.visible,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              //width: double.infinity,
                              //color: AppTema.grey100,
                              height: 200,

                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    'Administrar',
                                    style: TextStyle(
                                        color: AppTema.bluegrey700,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  ListTile(
                                    splashColor: AppTema.primario,
                                    title: const Text(
                                      'Renombrar',
                                      style: TextStyle(
                                          //color: AppTema.bluegrey700,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    leading: const Icon(
                                      Icons.edit,
                                      //color: AppTema.bluegrey700,
                                    ),
                                    onTap: () {
                                      print(idParticipante);
                                    },
                                  ),
                                  ListTile(
                                    splashColor: AppTema.primario,
                                    title: const Text(
                                      'Eliminar',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    leading: const Icon(
                                      Icons.delete,
                                      color: AppTema.redA400,
                                    ),
                                    onTap: () {
                                      eliminarParticipante(control, folio,
                                          idParticipante, context);
                                    },
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.more_vert_outlined,
                      color: AppTema.bluegrey700,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
