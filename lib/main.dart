import 'package:flutter/material.dart';
import 'package:innova_ito/router/app_router.dart';
import 'package:provider/provider.dart';

import 'package:innova_ito/screens/screens.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/theme/cambiar_tema.dart';

void main() => runApp(ChangeNotifierProvider(
    create: (_) => CambiarTema(1), child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTema.modoLuz,
      debugShowCheckedModeBanner: false,
      title: 'Innova ITO',
    );
  }
}
