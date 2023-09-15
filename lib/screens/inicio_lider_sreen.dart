import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/widgets/widgets.dart';

class InicioLiderScreen extends ConsumerWidget {
  static const String name = 'inicioLider';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final etapaEventoNotifier = ref.watch(etapaEventoProv);
    final rol = ref.watch(nombreRolLogin);
    final folioLider = ref.watch(folioProyectoUsuarioLogin);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppTema.primario,
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    iconSize: 45,
                    color: Colors.white,
                    onPressed: () {
                      context.pushNamed('menu_lateral');
                    },
                    icon: const Icon(Icons.clear_all_rounded),
                  ),
                  const Text(
                    'Inicio',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  const SizedBox(width: 45),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppTema.indigo50,
                  ),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (folioLider != 'SN')
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          disabledColor: AppTema.grey100,
                          elevation: 10,
                          height: 30,
                          color: AppTema.grey100,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            child: Text(
                              (folioLider ?? 'BIENVENIDO'),
                              style: const TextStyle(
                                color: AppTema.bluegrey700,
                              ),
                            ),
                          ),
                          onPressed: () {},
                        ),
                      if (folioLider == 'SN')
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          disabledColor: AppTema.grey100,
                          elevation: 10,
                          height: 30,
                          color: AppTema.grey100,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            child: const Text(
                              'BIENVENIDO',
                              style: TextStyle(
                                color: AppTema.bluegrey700,
                              ),
                            ),
                          ),
                          onPressed: () {},
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 2),

              if (etapaEventoNotifier == 'LOCAL' &&
                  rol.toUpperCase() == 'ADMINISTRADOR')
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppTema.indigo50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: itemsAdministrador.length,
                      itemBuilder: (context, index) {
                        return TareasLider(
                          icono: itemsAdministrador[index].icono,
                          texto: itemsAdministrador[index].titulo,
                          ruta1: itemsAdministrador[index].pantalla.toString(),
                        );
                      },
                    ),
                  ),
                ),
              if (etapaEventoNotifier == 'LOCAL' &&
                  rol.toLowerCase() == 'estudiante lider')
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppTema.indigo50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: itemsLider.length,
                      itemBuilder: (context, index) {
                        return TareasLider(
                          icono: itemsLider[index].icono,
                          texto: itemsLider[index].titulo,
                          ruta1: itemsLider[index].pantalla.toString(),
                        );
                      },
                    ),
                  ),
                ),
              if (etapaEventoNotifier == 'LOCAL' &&
                  rol.toLowerCase() == 'asesor')
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppTema.indigo50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: itemsAsesor.length,
                      itemBuilder: (context, index) {
                        return TareasLider(
                          icono: itemsAsesor[index].icono,
                          texto: itemsAsesor[index].titulo,
                          ruta1: itemsAsesor[index].pantalla.toString(),
                        );
                      },
                    ),
                  ),
                ),
              if (etapaEventoNotifier == 'LOCAL' &&
                  rol.toLowerCase() == 'jurado interno')
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppTema.indigo50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: itemsJuradoInterno.length,
                      itemBuilder: (context, index) {
                        return TareasLider(
                          icono: itemsJuradoInterno[index].icono,
                          texto: itemsJuradoInterno[index].titulo,
                          ruta1: itemsJuradoInterno[index].pantalla.toString(),
                        );
                      },
                    ),
                  ),
                ),
              if (etapaEventoNotifier == 'LOCAL' &&
                  rol.toLowerCase() == 'coordinador local')
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppTema.indigo50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: itemsCoordinadorLocal.length,
                      itemBuilder: (context, index) {
                        return TareasLider(
                          icono: itemsCoordinadorLocal[index].icono,
                          texto: itemsCoordinadorLocal[index].titulo,
                          ruta1:
                              itemsCoordinadorLocal[index].pantalla.toString(),
                        );
                      },
                    ),
                  ),
                ),

//! AQUI VA LA ETAPA REGIONAL

              if (etapaEventoNotifier == 'REGIONAL' &&
                  rol.toUpperCase() == 'ADMINISTRADOR')
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppTema.indigo50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: itemsAdministrador.length,
                      itemBuilder: (context, index) {
                        return TareasLider(
                          icono: itemsAdministrador[index].icono,
                          texto: itemsAdministrador[index].titulo,
                          ruta1: itemsAdministrador[index].pantalla.toString(),
                        );
                      },
                    ),
                  ),
                ),
              if (etapaEventoNotifier == 'REGIONAL' &&
                  rol.toLowerCase() == 'estudiante lider')
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppTema.indigo50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: itemsLiderRegional.length,
                      itemBuilder: (context, index) {
                        return TareasLider(
                          icono: itemsLiderRegional[index].icono,
                          texto: itemsLiderRegional[index].titulo,
                          ruta1: itemsLiderRegional[index].pantalla.toString(),
                        );
                      },
                    ),
                  ),
                ),
              if (etapaEventoNotifier == 'REGIONAL' &&
                  rol.toLowerCase() == 'asesor')
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppTema.indigo50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: itemsAsesor.length,
                      itemBuilder: (context, index) {
                        return TareasLider(
                          icono: itemsAsesor[index].icono,
                          texto: itemsAsesor[index].titulo,
                          ruta1: itemsAsesor[index].pantalla.toString(),
                        );
                      },
                    ),
                  ),
                ),
              if (etapaEventoNotifier == 'REGIONAL' &&
                  rol.toLowerCase() == 'jurado interno')
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppTema.indigo50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: itemsJuradoInterno.length,
                      itemBuilder: (context, index) {
                        return TareasLider(
                          icono: itemsJuradoInterno[index].icono,
                          texto: itemsJuradoInterno[index].titulo,
                          ruta1: itemsJuradoInterno[index].pantalla.toString(),
                        );
                      },
                    ),
                  ),
                ),
              if (etapaEventoNotifier == 'REGIONAL' &&
                  rol.toLowerCase() == 'coordinador local')
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppTema.indigo50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: itemsCoordinadorLocalRegional.length,
                      itemBuilder: (context, index) {
                        return TareasLider(
                          icono: itemsCoordinadorLocalRegional[index].icono,
                          texto: itemsCoordinadorLocalRegional[index].titulo,
                          ruta1: itemsCoordinadorLocalRegional[index]
                              .pantalla
                              .toString(),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
