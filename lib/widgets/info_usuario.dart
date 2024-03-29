import 'package:flutter/material.dart';

import 'package:innova_ito/theme/app_tema.dart';

class InfoUsuario extends StatelessWidget {
  const InfoUsuario(
      {super.key,
      required this.nombre,
      required this.rol,
      required this.iniciales});

  final String nombre, rol, iniciales;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppTema.bluegrey700,
        child: Text(iniciales, style: const TextStyle(color: AppTema.indigo50)),
      ),
      title: Text(nombre, style: const TextStyle(color: AppTema.bluegrey700)),
      subtitle: Text(
        rol,
        style: const TextStyle(color: AppTema.bluegrey700),
      ),
    );
  }
}
