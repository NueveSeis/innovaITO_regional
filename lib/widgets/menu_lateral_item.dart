import 'package:flutter/material.dart';

import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/theme/app_tema.dart';

class MenuLateralItem extends StatelessWidget {
  final ModeloMenu menu;
  final bool esActivo;
  final VoidCallback press;
  // final ValueChanged<pantalla>

  const MenuLateralItem({
    super.key,
    required this.menu,
    required this.esActivo,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 0),
          child: Divider(
            color: AppTema.bluegrey700,
            //Color(0xFF4E4B4D),
            height: 1,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              left: 10,
              top: 5,
              height: 46,
              width: esActivo ? 268 : 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppTema.pizazz,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            ListTile(
              leading: SizedBox(
                height: 34,
                width: 34,
                child: Icon(menu.icono, color: AppTema.bluegrey700),
              ),
              title: Text(
                menu.titulo,
                style: const TextStyle(color: AppTema.bluegrey700),
              ),
              onTap: press,
            ),
          ],
        ),
      ],
    );
  }
}
