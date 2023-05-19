import 'package:flutter/material.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/theme/cambiar_tema.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:selectable_box/selectable_box.dart';

class SeleccionCategoriaScreen extends StatefulWidget {
  const SeleccionCategoriaScreen({super.key});

  @override
  State<SeleccionCategoriaScreen> createState() =>
      _SeleccionCategoriaScreenState();
}

class _SeleccionCategoriaScreenState extends State<SeleccionCategoriaScreen> {
  bool isSelected_1 = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Area de interes',
          fontSize: 20,
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Seleccione la categoria de interes',
                  style: TextStyle(
                      color: CambiarTema.balticSea,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: size.height * 0.4,
                  width: double.infinity,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            //maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 6,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemCount: 7,
                    itemBuilder: (BuildContext context, index) {
                      return MaterialButton(
                          splashColor: CambiarTema.pizazz,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: size.height * 0.4,
                          elevation: 5.0,
                          color: CambiarTema.grey100,
                          child: Text(
                            'Lider de proyecto',
                            style: TextStyle(
                                color: CambiarTema.bluegrey700, fontSize: 25),
                          ),
                          onPressed: () {});
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Seleccione su area de interes',
                  style: TextStyle(
                      color: CambiarTema.balticSea,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: size.height * 0.4,
                  width: double.infinity,
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 10,
                        childAspectRatio: 10 / 3),
                    itemCount: 7,
                    itemBuilder: (BuildContext context, index) {
                      return MaterialButton(
                          splashColor: CambiarTema.pizazz,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 35,
                          elevation: 5.0,
                          color: CambiarTema.grey100,
                          child: Text(
                            'Lider de proyecto',
                            style: TextStyle(
                                color: CambiarTema.bluegrey700, fontSize: 25),
                          ),
                          onPressed: () {});
                    },
                  ),
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: ElevatedButton(
                      child: const Center(
                          child: Text(
                        'Enviar',
                        style: TextStyle(color: AppTema.grey100, fontSize: 25),
                      )),
                      onPressed: () async {}),
                ),
              ],
            ),
          )),
    );
  }
}
