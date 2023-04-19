import 'package:flutter/material.dart';
import 'package:innova_ito/theme/cambiar_tema.dart';

class InputDecorations {
  static InputDecoration accesoInputDecoration(
      {required String hintText,
      required String labelText,
      IconData? prefixIcon}) {
    return InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(217, 217, 217, 1),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(217, 217, 217, 1),
            ),
            borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromRGBO(250, 122, 30, 1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(color: Color.fromRGBO(46, 45, 47, 0.8)),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: const Color.fromRGBO(28, 27, 31, 0.9))
            : null);
  }

  static InputDecoration registroLiderDecoration(
      {required String hintText,
      required String labelText,
      IconData? prefixIcon}) {
    return InputDecoration(
        filled: true,
        fillColor: CambiarTema.grey100,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: CambiarTema.bluegrey700,
              width: 0.3,
            ),
            borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromRGBO(250, 122, 30, 1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
            color: CambiarTema.bluegrey700, fontWeight: FontWeight.normal),
        labelText: labelText,
        labelStyle: const TextStyle(color: CambiarTema.bluegrey700),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: const Color.fromRGBO(28, 27, 31, 0.9))
            : null);
  }
}
