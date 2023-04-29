import 'package:flutter/material.dart';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';

import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/widgets/widgets.dart';

class AsignacionFechasScreen extends StatelessWidget {
  const AsignacionFechasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List _dates;
    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Asignación de fechas',
          fontSize: 25,
          widget: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTema.grey100,
                  ),
                  child: Container(
                    height: 85,
                    decoration: BoxDecoration(
                      color: AppTema.grey100,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              //padding: const EdgeInsets.only(right: 5),
                              child: Text(
                                ' nombreCarrera',
                                style: const TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppTema.primario,
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          )),
    );
  }
}
