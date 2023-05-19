import 'package:flutter/material.dart';
import 'package:innova_ito/theme/cambiar_tema.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:card_swiper/card_swiper.dart';

class SeleccionCategoriaScreen extends StatelessWidget {
  const SeleccionCategoriaScreen({super.key});

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
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: size.height * 0.5,
                  //color: Colors.red,
                  child: Swiper(
                    itemCount: 6,
                    layout: SwiperLayout.STACK,
                    itemWidth: size.width * 0.6,
                    itemHeight: size.height * 0.8,
                    itemBuilder: (_, int index) {
                      return Stack(children: [
                        SizedBox(
                          height: size.height * 0.8,
                          width: size.width * 0.6,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage(
                              placeholder:
                                  AssetImage('assets/imagenes/806.gif'),
                              image: NetworkImage(
                                  "https://th.bing.com/th/id/OIG.mKk5C4bM5y9UztvusVFx?pid=ImgGn"),
                              fit: BoxFit.cover,
                            ),
                            // Image.network(
                            //   "https://th.bing.com/th/id/OIG.mKk5C4bM5y9UztvusVFx?pid=ImgGn",
                            //   fit: BoxFit.fill,
                            // ),
                          ),
                        ),
                        Center(child: Text('Hola'))
                      ]);
                    },
                    //itemCount: 3,
                    //pagination: SwiperPagination(),
                    //control: SwiperControl(),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
