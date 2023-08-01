
import 'package:flutter/material.dart';
class Apoyo{

  //*Obtener iniciales
  static String obtenerIniciales(String nombre) {
  List<String> iniciales = nombre.split(' ');
  String inicialesString = '';
  for (String inicial in iniciales) {
   inicialesString += inicial[0];
  }
  return inicialesString;
}

//*Capitalizar texto
static String capitalizar(String input) {
  if (input == null || input.isEmpty) {
    return "";
  }

  List<String> palabras = input.split(" ");
  List<String> palabrasCapitalizadas = [];

  for (String palabra in palabras) {
    if (palabra.isNotEmpty) {
      palabrasCapitalizadas.add(palabra[0].toUpperCase() + palabra.substring(1).toLowerCase());
    }
  }

  return palabrasCapitalizadas.join(" ");
}

}