import 'package:flutter/material.dart';

class CambiarTema with ChangeNotifier {
  static const Color primario = Color(0xFFFA7A1E); //Ecstaszy
  static const Color pizazz = Color(0xFFFF9500); //Pizazz
  static const Color balticSea = Color(0xFF2E2D2F); //Baltic Sea
  static const Color emperor = Color(0xFF4E4B4D); //Emperor
  static const Color indigo50 = Color(0xFFE4EBF5); //Indigo50
  static const Color grey100 = Color(0xFFF4F8FB); //Grey100
  static const Color bluegrey700 = Color(0xFF4B597B);

  bool _temaLuz = false;
  bool _temaOscuro = false;
  ThemeData _temaActual = ThemeData.dark();

  CambiarTema(int tema) {
    switch (tema) {
      case 1: //oscuro
        _temaLuz = false;
        _temaActual = ThemeData.dark();
        break;
      case 2: //luz
        _temaOscuro = false;
        _temaActual = ThemeData.light();
        break;
    }
  }

  bool get temaOscuro => _temaOscuro;
  bool get temaLuz => _temaLuz;
  ThemeData get temaActual => _temaActual;

  set temaOscuro(bool value) {
    _temaLuz = false;
    _temaOscuro = value;

    if (value) {
      _temaActual = ThemeData.dark(); //.copyWith(
      //scaffoldBackgroundColor: balticSea,
      //);
    } else {
      _temaActual = ThemeData.light(); //.copyWith(
      //scaffoldBackgroundColor: primario,
      //);
    }

    notifyListeners();
  }

  set temaLuz(bool value) {
    _temaLuz = value;
    _temaOscuro = false;

    if (value) {
      _temaActual = ThemeData.light();
    } else {
      _temaActual = ThemeData.dark();
    }
    notifyListeners();
  }
}
