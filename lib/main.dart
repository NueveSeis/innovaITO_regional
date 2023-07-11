import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innova_ito/router/app_router.dart';
import 'package:innova_ito/theme/app_tema.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

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
