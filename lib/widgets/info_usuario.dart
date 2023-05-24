import 'package:flutter/material.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:provider/provider.dart';

class InfoUsuario extends StatelessWidget {
  const InfoUsuario({
    super.key,
    required this.nombre,
    required this.rol,
  });

  final String nombre, rol;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppTema.bluegrey700,
        child: Text('KI', style: TextStyle(color: AppTema.indigo50)),
      ),
      title: Text(nombre, style: TextStyle(color: AppTema.bluegrey700)),
      subtitle: Text(
        rol,
        style: const TextStyle(color: AppTema.bluegrey700),
      ),
    );
  }
}
