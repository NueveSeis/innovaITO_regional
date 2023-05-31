import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/theme/app_tema.dart';

import 'package:provider/provider.dart';

import 'package:innova_ito/widgets/widgets.dart';

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoUsuario(
                  nombre: 'Kevin Ivan Luis Gonzalez',
                  rol: 'Jefe de vinculación',
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
            ),
          ),
        ),
      ),
    );
  }
}
