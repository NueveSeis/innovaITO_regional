import 'package:flutter/material.dart';

class AppTema {
  static const Color primario = Color(0xFFFA7A1E); //Ecstaszy
  static const Color pizazz = Color(0xFFFF9500); //Pizazz
  static const Color balticSea = Color(0xFF2E2D2F); //Baltic Sea
  static const Color emperor = Color(0xFF4E4B4D); //Emperor
  static const Color indigo50 = Color(0xFFE4EBF5); //Indigo50
  static const Color grey100 = Color(0xFFF4F8FB); //Grey100
  static const Color bluegrey700 = Color(0xFF4B597B);

  static final ThemeData modoOscuro = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: balticSea,
  );

  static final ThemeData modoLuz = ThemeData.light().copyWith(
    scaffoldBackgroundColor: primario,
  );
}
