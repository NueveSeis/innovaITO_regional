import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/theme/app_tema.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

//import 'package:provider/provider.dart';

import 'package:innova_ito/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuLateral extends StatefulWidget {
  static const String name = 'menu_lateral';
  const MenuLateral({super.key});

  @override
  State<MenuLateral> createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  ModeloMenu seleccionMenu = itemsMenu.first;
  @override
  Widget build(BuildContext context) {
    //final temaApp = Provider.of<AppTema>(context);

    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: AppTema.indigo50,
        child: SafeArea(
          child: SingleChildScrollView(
            child: 
            Consumer(builder: (context, ref, child) {
  final nombre = ref.watch(nombreUsuarioLogin);
  final rol = ref.watch(nombreRolLogin);
  final iniciales = ref.watch(inicialesUsuario);
  
 return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                    InfoUsuario(
                       nombre: nombre,
                       rol: rol,
                       iniciales: iniciales,
                     ),

                   
                  
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    top: 32,
                    bottom: 16,
                  ),
                  child: Text(
                    'Menu'.toUpperCase(),
                    style: TextStyle(color: AppTema.bluegrey700),
                  ),
                ),
                ...itemsMenu.map(
                  (menu) => MenuLateralItem(
                    menu: menu,
                    press: () {
                      context.push('/${menu.pantalla.toString()}');
                      //Navigator.pushNamed(context, menu.pantalla.toString());
                      setState(() {
                        seleccionMenu = menu;
                      });
                    },
                    esActivo: seleccionMenu == menu,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    top: 32,
                    bottom: 16,
                  ),
                  child: Text(
                    'Ajustes'.toUpperCase(),
                    style: TextStyle(color: AppTema.bluegrey700),
                  ),
                ),
                ...itemsConfig.map(
                  (menu) => MenuLateralItem(
                    menu: menu,
                    press: () {
                      (menu.pantalla.toString() == 'acceso')
                          ? context.replace('/${menu.pantalla.toString()}')
                          : //context.pushNamed('/${menu.pantalla.toString()}');
                          setState(() {
                              seleccionMenu = menu;
                            });
                    },
                    esActivo: seleccionMenu == menu,
                  ),
                ),
              ],
            );
}),
            
            
          ),
        ),
      ),
    );
  }
}
