import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';

class AgregarCarreraScreen extends StatefulWidget {
  const AgregarCarreraScreen({super.key});

  @override
  State<AgregarCarreraScreen> createState() => _AgregarCarreraScreenState();
}

class _AgregarCarreraScreenState extends State<AgregarCarreraScreen> {
  bool mostrarInput = false;
  @override
  Widget build(BuildContext context) {
    List<String> carreras = ModeloTecnologicos().carrera;
    return Scaffold(
        body: Fondo(
            fontSize: 20,
            tituloPantalla: 'Agregar carrera',
            widget: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    'Seleccione alguna opción o en su defecto seleccione: "Otra..."',
                    style: TextStyle(
                        color: AppTema.bluegrey700,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                  ),
                  Form(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        DropdownButtonFormField(
                          isExpanded: true,
                          style: const TextStyle(
                              color: AppTema.bluegrey700,
                              fontWeight: FontWeight.bold),
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              if (value == 'Otra...') {
                                mostrarInput = true;
                              } else {
                                mostrarInput = false;
                              }
                            });
                          },
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
                        SizedBox(
                          height: 25,
                        ),
                        if (mostrarInput == true)
                          TextFormField(
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese carrera',
                              labelText: 'Carrera',
                            ),
                          ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              child: Text(
                                'Cancelar',
                                style: TextStyle(
                                    color: AppTema.grey100, fontSize: 25),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            ElevatedButton(
                              child: Text(
                                'Guardar',
                                style: TextStyle(
                                    color: AppTema.grey100, fontSize: 25),
                              ),
                              onPressed: () {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.success,
                                  title: 'Agregado correctamente',
                                  autoCloseDuration: Duration(seconds: 7),
                                  confirmBtnText: 'Hecho',
                                  confirmBtnColor: AppTema.pizazz,
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
