import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:innova_ito/screens/screens.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/theme/cambiar_tema.dart';
import 'package:innova_ito/widgets/widgets.dart';

void main() => runApp(ChangeNotifierProvider(
    create: (_) => CambiarTema(1), child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final temaActua = Provider.of<CambiarTema>(context).temaActual;

    return MaterialApp(
      theme: temaActua,
      debugShowCheckedModeBanner: false,
      title: 'Innova ITO',
      initialRoute: 'menu_lateral',
      routes: {
        'inicio': (_) => const InicioScreen(),
        'detalles': (_) => const DetallesScreen(),
        'acceso': (_) => const AccesoScreen(),
        'menu_lateral': (_) => const MenuLateral(),
        'proyectos': (_) => const ProyectosPendientesScreen(),
        'registro_usuario': (_) => const RegistroUsuarioScreen(),
        'registro_usuario_lider': (_) => const RegistroUsuarioLiderScreen(),
      },
    );
  }
}
