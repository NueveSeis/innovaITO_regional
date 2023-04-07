import 'package:flutter/material.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/theme/cambiar_tema.dart';
import 'package:provider/provider.dart';

import 'package:innova_ito/widgets/widgets.dart';

class MenuLateral extends StatefulWidget {
  const MenuLateral({super.key});

  @override
  State<MenuLateral> createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  ModeloMenu seleccionMenu = itemsMenu.first;
  @override
  Widget build(BuildContext context) {
    final temaApp = Provider.of<CambiarTema>(context);

    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color:
            (temaApp.temaOscuro) ? CambiarTema.balticSea : CambiarTema.indigo50,
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
                    style: TextStyle(
                        color: (temaApp.temaOscuro)
                            ? Colors.white
                            : CambiarTema.bluegrey700),
                  ),
                ),
                ...itemsMenu.map(
                  (menu) => MenuLateralItem(
                    menu: menu,
                    press: () {
                      Navigator.pushNamed(context, menu.pantalla.toString());
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
                    style: TextStyle(
                        color: (temaApp.temaOscuro)
                            ? Colors.white
                            : CambiarTema.bluegrey700),
                  ),
                ),
                ...itemsConfig.map(
                  (menu) => MenuLateralItem(
                    menu: menu,
                    press: () {
                      setState(() {
                        seleccionMenu = menu;
                      });
                    },
                    esActivo: seleccionMenu == menu,
                  ),
                ),
                SafeArea(
                  bottom: true,
                  top: false,
                  left: false,
                  right: false,
                  child: ListTile(
                    leading: Icon(Icons.lightbulb_outline,
                        color: (temaApp.temaOscuro)
                            ? Colors.white
                            : CambiarTema.bluegrey700),
                    title: Text(
                      'Dark Mode',
                      style: TextStyle(
                          color: (temaApp.temaOscuro)
                              ? Colors.white
                              : CambiarTema.bluegrey700),
                    ),
                    trailing: Switch.adaptive(
                        value: temaApp.temaOscuro,
                        activeColor: Colors.green,
                        onChanged: (value) => temaApp.temaOscuro = value),
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
