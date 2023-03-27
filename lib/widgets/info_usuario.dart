import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:innova_ito/theme/cambiar_tema.dart';

class InfoUsuario extends StatelessWidget {
  const InfoUsuario({
    super.key,
    required this.nombre,
    required this.rol,
  });

  final String nombre, rol;

  @override
  Widget build(BuildContext context) {
    final temaApp = Provider.of<CambiarTema>(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: (temaApp.temaOscuro)
            ? CambiarTema.indigo50
            : CambiarTema.bluegrey700,
        child: Text('KI',
            style: TextStyle(
                color: (temaApp.temaOscuro)
                    ? CambiarTema.balticSea
                    : CambiarTema.indigo50)),
      ),
      title: Text(nombre,
          style: TextStyle(
              color: (temaApp.temaOscuro)
                  ? Colors.white
                  : CambiarTema.bluegrey700)),
      subtitle: Text(
        rol,
        style: TextStyle(
            color:
                (temaApp.temaOscuro) ? Colors.white : CambiarTema.bluegrey700),
      ),
    );
  }
}
