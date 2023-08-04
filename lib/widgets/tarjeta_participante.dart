import 'package:flutter/material.dart';
import 'package:innova_ito/theme/app_tema.dart';

class TarjetaParticipante extends StatelessWidget {
  //final String nombreCarrera;
  const TarjetaParticipante({
    super.key,
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
                  '1',
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
                            'Kevin Ivan Luis Gonzalez',
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
                            '17161164',
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
                            'Semestre 12',
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
                            'Ingeniaria en sistemas computacionales',
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
