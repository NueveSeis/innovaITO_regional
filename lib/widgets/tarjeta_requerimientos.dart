import 'package:flutter/material.dart';

import 'package:innova_ito/theme/app_tema.dart';

class TarjetaRequerimiento extends StatelessWidget {
  final String nombre;
  final String descripcion;
  final String id;
  late bool vswi = false;
  final String folio;

  TarjetaRequerimiento({
    super.key,
    required this.nombre,
    required this.descripcion,
    required this.id,
    required this.folio,
    //required this.vswi,
  });

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
                  id,
                  style: const TextStyle(
                      color: AppTema.bluegrey700,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
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
                            descripcion,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Switch(
                    value: vswi,
                    onChanged: (value) {
                      vswi = value;
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
