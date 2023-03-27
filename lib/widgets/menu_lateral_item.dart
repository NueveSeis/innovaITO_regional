import 'package:flutter/material.dart';
import 'package:innova_ito/theme/cambiar_tema.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

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
    final temaApp = Provider.of<CambiarTema>(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 0),
          child: Divider(
            color: (temaApp.temaOscuro)
                ? CambiarTema.emperor
                : CambiarTema.bluegrey700,
            //Color(0xFF4E4B4D),
            height: 1,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              left: 10,
              top: 5,
              height: 46,
              width: esActivo ? 268 : 0,
              child: Container(
                decoration: BoxDecoration(
                  color: CambiarTema.pizazz,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            ListTile(
              leading: SizedBox(
                height: 34,
                width: 34,
                child: Icon(menu.icono,
                    color: (temaApp.temaOscuro)
                        ? Colors.white
                        : CambiarTema.bluegrey700),
              ),
              title: Text(
                menu.titulo,
                style: TextStyle(
                    color: (temaApp.temaOscuro)
                        ? Colors.white
                        : CambiarTema.bluegrey700),
              ),
              onTap: press,
            ),
          ],
        ),
      ],
    );
  }
}
