import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:innova_ito/models/models.dart';

class DepartamentoScreen extends StatefulWidget {
  static const String name = 'departamento';
  DepartamentoScreen({super.key});

  @override
  State<DepartamentoScreen> createState() => _DepartamentoScreenState();
}

@override
void initState() {
  obtenerDepartamento();
}

List<Departamento> departamentos = [];

Future obtenerDepartamento() async {
  var url =
      'https://evarafael.com/Aplicacion/rest/get_departamento.php?Clave_tecnologico=TEC01';
  var response = await http.get(Uri.parse(url));
  departamentos = departamentoFromJson(response.body);
  //print(tecnologicoM[0].nombreTecnologico);
}

class _DepartamentoScreenState extends State<DepartamentoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Departamentos',
          fontSize: 20,
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
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
                        Icon(Icons.add_circle_outline_rounded),
                        Text(
                          '  Añadir departamento',
                          style:
                              TextStyle(color: AppTema.grey100, fontSize: 25),
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
                Column(
                  children: [
                    FutureBuilder(
                        future: obtenerDepartamento(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView.builder(
                                //scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: departamentos.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return TarjetaCarrera(
                                    nombreCarrera:
                                        departamentos[index].nombreDepartamento,
                                  );
                                  //print(departamentos[2].nombreDepartamento);
                                });
                          }
                        }),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
