import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/helpers/helpers.dart';
import 'package:innova_ito/models/criterioRubrica.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/theme/app_tema.dart';

import 'package:innova_ito/widgets/widgets.dart';

class InicioEtapasScreen extends ConsumerWidget {
  static const String name = 'InicioEtapasScreen';
  InicioEtapasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final etapaEventoNotifier = ref.watch(etapaEventoProv);
    return Scaffold(
        body: FondoEtapas(
      child: SingleChildScrollView(
          child: Column(
        children: [
          ContenedorCarta(
              child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Bienvenido a la aplicación InnovaITO',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppTema.balticSea,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              // MaterialButton(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(25),
              //     ),
              //     disabledColor: Colors.grey,
              //     elevation: 10,
              //     color: const Color.fromRGBO(250, 122, 30, 1),
              //     child: Container(
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 80, vertical: 15),
              //         child: const Text(
              //           ' LOCAL ',
              //           style: TextStyle(color: Colors.white),
              //         )),
              //     onPressed: () async {
              //       ref
              //           .read(etapaEventoProv.notifier)
              //           .update((state) => 'LOCAL');
              //       context.pushNamed('acceso');
              //     }),
              // const SizedBox(
              //   height: 30,
              // ),
              SizedBox(
                width: 250, // Ancho deseado del botón
                height: 50, // Altura deseada del botón
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  disabledColor: Colors.grey,
                  elevation: 10,
                  color: const Color.fromRGBO(250, 122, 30, 1),
                  onPressed: () async {
                    context.pushNamed('BuscarPresentacionScreen');
                  },
                  child: Container(
                    // padding: const EdgeInsets.symmetric(
                    //   horizontal: 10,
                    //   vertical: 15,
                    //),
                    child: const Text(
                      'ESTUDIANTE LIDER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 250, // Ancho deseado del botón
                height: 50, // Altura deseada del botón
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  disabledColor: Colors.grey,
                  elevation: 10,
                  color: const Color.fromRGBO(250, 122, 30, 1),
                  onPressed: () async {
                    ref
                        .read(etapaEventoProv.notifier)
                        .update((state) => 'REGIONAL');
                    context.pushNamed('acceso');
                  },
                  child: Container(
                    // padding: const EdgeInsets.symmetric(
                    //   horizontal: 10,
                    //   vertical: 15,
                    // ),
                    child: const Text(
                      'COORDINADOR REGIONAL',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Todos los derechos reservados 2023 ©',
                textAlign: TextAlign.center,
              ),
              const Text(
                'HUKER',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic, // Agrega cursiva
                ),
              )
            ],
          ))
        ],
      )),
    ));
  }
}
