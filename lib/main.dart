import 'package:flutter/material.dart';
import 'package:innova_ito/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Innova ITO',
      initialRoute: 'acceso',
      routes: {
        'inicio': (_) => const InicioScreen(),
        'detalles': (_) => const DetallesScreen(),
        'acceso': (_) => const AccesoScreen(),
      },
    );
  }
}
