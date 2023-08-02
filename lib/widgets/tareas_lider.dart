import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/theme/app_tema.dart';

class TareasLider extends StatelessWidget {
  final bool listo;
  final String fase;
  final String ruta1;
  final String ruta2;

  const TareasLider({
    super.key,
    required this.listo,
    required this.fase,
    required this.ruta1,
    required this.ruta2,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 10,
      shadowColor: (listo) ? AppTema.greenS400 : AppTema.redA400,
      child: Container(
        width: 350,
        //height: 100,
        padding: const EdgeInsets.all(10),
        //margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: AppTema.grey100,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    (listo) ? "COMPLETADO" : "NO COMPLETADO",
                    style: TextStyle(
                        color: (listo) ? AppTema.greenS400 : AppTema.redA400,
                        //fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                const SizedBox(height: 5),
                Divider(
                  // Aquí está el Divider para la línea horizontal
                  thickness: 2.5,
                  color: (listo) ? AppTema.greenS400 : AppTema.redA400,
                ),
                const SizedBox(height: 5),
                Text(
                  fase,
                  style: const TextStyle(
                      color: AppTema.bluegrey700,
                      //fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  IconButton(
                      icon: const Icon(Icons.visibility_rounded, size: 25),
                      onPressed: () {},
                      color: AppTema.bluegrey700),
                  const Text(
                    'Visualizar',
                    style: TextStyle(
                      color: AppTema.bluegrey700,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  IconButton(
                      icon:
                          const Icon(Icons.mode_edit_outline_rounded, size: 25),
                      onPressed: () {
                        context.goNamed(ruta1);
                      },
                      color: AppTema.bluegrey700),
                  const Text(
                    'Modificar',
                    style: TextStyle(
                      color: AppTema.bluegrey700,
                    ),
                  )
                ],
              )
            ],
          ),
        ]),
      ),
    );
  }
}
