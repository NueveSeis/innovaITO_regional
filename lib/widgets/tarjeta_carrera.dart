import 'package:flutter/material.dart';
import 'package:innova_ito/theme/app_tema.dart';

import 'package:innova_ito/theme/cambiar_tema.dart';

class TarjetaCarrera extends StatelessWidget {
  final String nombreCarrera;
  const TarjetaCarrera({super.key, required this.nombreCarrera});

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
        ),
        decoration: BoxDecoration(
          color: CambiarTema.grey100,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  //isExpanded: true,
                  //width: double.infinity,
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    nombreCarrera,
                    style: const TextStyle(
                        color: CambiarTema.bluegrey700,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    overflow: TextOverflow.visible,
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
                                onTap: () {},
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
                                onTap: () {},
                              )
                            ],
                          ),
                        );
                      });
                },
                icon: const Icon(
                  Icons.more_vert_outlined,
                  color: CambiarTema.bluegrey700,
                )),
          ],
        ),
      ),
    );
  }
}
